import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/database/tables.dart';
import 'package:hearizons/errors.dart';
import 'package:hearizons/platforms/platform.dart';
import 'package:hearizons/utils/context_extension.dart';
import 'package:logging/logging.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

class Event {
  Database get database => GetIt.I.get<Database>();
  CommandsPlugin get commands => GetIt.I.get<CommandsPlugin>();
  INyxxWebsocket get client => GetIt.I.get<INyxxWebsocket>();

  final EventData data;

  late final Logger logger = Logger('Event ${data.id}');

  Event(this.data);

  Future<void> startNewCycle() async {
    logger.info('Moving to new cycle');

    if (!await canMoveToNextCycle()) {
      logger.fine("Can't move to next cycle");
      return;
    }

    final message = await sendNewCycleAnnouncement();
    final cycleStart = await database.getNextCycleStart(this);
    final events = await createReviewsAndNextCycleEvents(cycleStart);

    // Submissions event might be out of sync, update it here
    await updateSubmissionsEvent(
      (await database.getCurrentCycle(this)).nextCycleSubmissionsEventId,
      cycleStart,
    );

    await database.moveEventToNextCycle(
      this,
      reviewsEventId: events[0],
      nextCycleSubmissionsEventId: events[1],
      statusMessageId: message?.id ?? Snowflake.zero(),
    );

    logger.fine('Moved to next cycle');
  }

  Future<void> enterReviewPhase() async {
    logger.info('Entering review phase');

    final submissions = (await database.getCurrentSubmissions(this)).toList();

    if (!await canMoveToReviews(submissions)) {
      logger.fine("Couldn't enter review phase");
      return;
    }

    final message = await sendStartingReviewsAnnouncement();

    final assignments = (await createAssignments(submissions)).toList();
    await sendAssignmentMessages(submissions, assignments);

    await database.transaction(() async {
      await database.createAssignments(assignments);
      await database.moveEventToReviewPhase(
        this,
        statusMessageId: message?.id ?? Snowflake.zero(),
      );
    });

    logger.info('Moved to review phase');
  }

  Future<void> activate() async {
    logger.info('Activating event');

    final message = await sendNewCycleAnnouncement();
    final events = await createSubmissionsReviewsAndNextCycleEvents(DateTime.now());

    await database.startCycleForEvent(
      this,
      submissionsEventId: events[0],
      reviewsEventId: events[1],
      nextSubmissionsEventId: events[2],
      statusMessageId: message?.id ?? Snowflake.zero(),
    );
    await database.updateEvent(data.copyWith(active: true));

    logger.info('Activated event');
  }

  Future<void> update(EventsCompanion companion) async {
    final newEvent = await database.updateEvent(companion.copyWith(id: Value(data.id)));

    if (data.active) {
      await newEvent.applyUpdate();
    }
  }

  Future<void> applyUpdate() async {
    final cycle = await database.getCurrentCycle(this);
    final events = await Future.wait([
      createSubmissionsEventBuilder(cycle.startedAt),
      createReviewsEventBuilder(cycle.startedAt),
      createSubmissionsEventBuilder(
          cycle.startedAt.add(data.submissionsLength + data.reviewLength)),
    ].map(Future.value));

    for (final data in IterableZip([
      [cycle.submissionsEventId, cycle.reviewsEventId, cycle.nextCycleSubmissionsEventId],
      events,
    ])) {
      final id = data[0] as Snowflake;
      final event = data[1] as GuildEventBuilder;

      await _updateEvent(id, event);
    }

    if (cycle.statusMessageId != Snowflake.zero()) {
      try {
        MessageBuilder message;
        if (cycle.status == CycleStatus.submissions) {
          message = await createNewCycleAnnouncement();
        } else {
          message = await createStartingReviewsAnnouncement();
        }

        await client.httpEndpoints
            .editMessage(data.announcementsChannelId, cycle.statusMessageId, message);
      } on IHttpResponseError {
        // ignore: Message was probably deleted
      }
    }
  }

  Future<void> deactivate() => database.transaction(() async {
        logger.info('Deactivating event');

        await cancelAllEvents();

        await database.discardAssignments(this);
        await database.updateEvent(data.copyWith(active: false));

        logger.info('Event deactivated');
      });

  Future<void> createReview(Assignment assignment, String review) async {
    await _forAllDependencies((event) => event.validateReview(assignment, review));

    final submission = await database.getSubmissionFromAssignment(assignment);

    await _sendMessageToChannel(
      data.reviewsChannelId,
      MessageBuilder.embed(await createReviewEmbed(submission, assignment, review)),
    );

    final createdReview = await database.createReview(ReviewsCompanion.insert(
      submission: assignment.submission,
      userId: assignment.assignedUser,
      content: review,
    ));

    await processReview(createdReview);
  }

  FutureOr<void> validateReview(Assignment assignment, String review) {}

  Future<void> processReview(Review review) async {
    // Remove participant role
    try {
      await client.httpEndpoints.removeRoleFromUser(
        data.guildId,
        data.participantRoleId,
        review.userId,
      );
    } on IHttpResponseError catch (e) {
      logger.info('Error code ${e.code} removing role from ${review.userId}');
    }
  }

  Future<void> createSubmission({
    required String submission,
    required Snowflake userId,
  }) async {
    await _forAllDependencies((event) => event.validateSubmission(submission, userId));

    final createdSubmission = await database.createSubmission(SubmissionsCompanion.insert(
      cycle: (await database.getCurrentCycle(this)).id,
      userId: userId,
      content: submission,
    ));

    await processSubmission(createdSubmission);
  }

  FutureOr<void> validateSubmission(
    String submission,
    Snowflake userId,
  ) async {
    final existing = await database.getCurrentSubmissionsFromUser(this, userId);

    if (existing.isNotEmpty) {
      throw AlreadySubmittedException(
        event: this,
        existing: existing,
      );
    }

    final pending = await database.getIncompleteAssignmentsForUserInEvent(this, userId);
    if (pending.isNotEmpty) {
      throw PendingReviewsException(this);
    }
  }

  Future<void> processSubmission(Submission submission) async {
    // Give participant role
    try {
      await client.httpEndpoints.addRoleToUser(
        data.guildId,
        data.participantRoleId,
        submission.userId,
      );
    } on IHttpResponseError catch (e) {
      logger.fine('Http error ${e.code} adding role to member ${submission.userId}');
    }
  }

  FutureOr<Iterable<AssignmentsCompanion>> createAssignments(
    List<Submission> submissions,
  ) async {
    void derange<T>(List<T> list) {
      Random random = Random();

      for (int i = list.length; i > 1;) {
        i--;
        int j = random.nextInt(i);

        T temp = list[i];
        list[i] = list[j];
        list[j] = temp;
      }
    }

    submissions = submissions.toList();
    final originalSubmissions = List.of(submissions);

    derange(submissions);

    return IterableZip([submissions, originalSubmissions]).map((pair) {
      final submission = pair.first;
      final assignee = pair.last.userId;

      return AssignmentsCompanion.insert(submission: submission.id, assignedUser: assignee);
    });
  }

  FutureOr<bool> canMoveToNextCycle() => true;

  FutureOr<bool> canMoveToReviews(List<Submission> submissions) => submissions.length >= 2;

  Future<IMessage?> sendNewCycleAnnouncement() async => _sendMessageToChannel(
        data.announcementsChannelId,
        await createNewCycleAnnouncement(),
      );

  Future<IMessage?> sendStartingReviewsAnnouncement() async => _sendMessageToChannel(
        data.announcementsChannelId,
        await createStartingReviewsAnnouncement(),
      );

  FutureOr<MessageBuilder> createNewCycleAnnouncement() => MessageBuilder()
    ..append(
      data.announcementRoleId == data.guildId ? '@everyone' : '<@&${data.announcementRoleId}>',
    )
    ..addEmbed((embed) {
      embed
        ..title = 'New cycle'
        ..description = '''
Submissions are now open for ${data.name}!
Add your submission with `/submit event:${data.name}`!

Submissions close ${TimeStampStyle.relativeTime.format(DateTime.now().add(data.submissionsLength))}.
'''
        ..color = infoColour
        ..timestamp = DateTime.now();
    });

  FutureOr<MessageBuilder> createStartingReviewsAnnouncement() => MessageBuilder()
    ..append(
      data.participantRoleId == data.guildId ? '@everyone' : '<@&${data.participantRoleId}>',
    )
    ..addEmbed((embed) {
      embed
        ..title = 'Reviews open'
        ..description = '''
The review phase for ${data.name} is now open!
Create a review by running `/review event:${data.name}` and completing the form that appears with
the content of your review.

The next cycle starts ${TimeStampStyle.relativeTime.format(DateTime.now().add(data.reviewLength))}.
'''
        ..color = infoColour
        ..timestamp = DateTime.now();
    });

  Future<void> sendAssignmentMessages(
    List<Submission> submissions,
    List<AssignmentsCompanion> assignments,
  ) async {
    final assignmentMessageLines = [
      '**The assignments for this cycle are**:\n',
      ...assignments.map(
        (assignment) => '<@${assignment.assignedUser.value}>: ${submissions.firstWhere(
              (submission) => submission.id == assignment.submission.value,
            ).displayedContent}\n',
      ),
    ].map((line) => line.length > 1024 ? '${line.substring(0, 1021)}...' : line);

    final messages = assignmentMessageLines.fold(
      [''],
      (messages, line) {
        final currentMessageLength = messages.last.length;

        if (currentMessageLength + line.length > 2014) {
          messages.add('');
        }

        messages.last += line;
        return messages;
      },
    );

    for (final message in messages) {
      await _sendMessageToChannel(
        data.announcementsChannelId,
        MessageBuilder.content(message),
      );
    }
  }

  FutureOr<EmbedBuilder> createReviewEmbed(
    Submission submission,
    Assignment assignment,
    String review,
  ) async {
    if (review.length > 1024) {
      review = '${review.substring(0, 1021)}...';
    }

    return EmbedBuilder()
      ..title = 'Review by ${(await client.fetchUser(assignment.assignedUser)).username}'
      ..description =
          'This is <@!${assignment.assignedUser}>\'s review of ${submission.displayedContent}'
      ..addField(name: 'Review', content: review)
      ..timestamp = DateTime.now()
      ..color = infoColour;
  }

  Future<void> link(Event other) => database.link(this, other);

  @override
  String toString() => data.toString();

  Future<List<T>> _forAllDependencies<T>(
    FutureOr<T> Function(Event) computation,
  ) async {
    final seen = <int>[];
    final toProcess = [this];

    final result = <T>[];

    while (toProcess.isNotEmpty) {
      final event = toProcess.removeAt(0);

      if (seen.contains(event.data.id)) {
        continue;
      }
      seen.add(event.data.id);

      result.add(await computation(event));
      toProcess.addAll(await database.getDependenciesOf(event));
    }

    return result;
  }

  Future<List<Event>> getLinkedEvents() => database.getDependenciesOf(this);

  Future<void> unlink(Event other) => database.unlink(this, other);

  Future<List<Snowflake>> createReviewsAndNextCycleEvents(DateTime cycleStart) async {
    final builders = await Future.wait([
      createReviewsEventBuilder(cycleStart),
      createSubmissionsEventBuilder(cycleStart.add(data.submissionsLength + data.reviewLength)),
    ].map(Future.value));

    return Future.wait(builders.map((builder) async {
      if (builder.startDate!.isBefore(DateTime.now())) {
        return Snowflake.zero();
      }

      return (await client.httpEndpoints.createGuildEvent(data.guildId, builder)).id;
    }));
  }

  Future<List<Snowflake>> createSubmissionsReviewsAndNextCycleEvents(DateTime cycleStart) async {
    final builders = await Future.wait([
      createSubmissionsEventBuilder(cycleStart),
      createReviewsEventBuilder(cycleStart),
      createSubmissionsEventBuilder(cycleStart.add(data.submissionsLength + data.reviewLength)),
    ].map(Future.value));

    return Future.wait(builders.map((builder) async {
      if (builder.endDate!.isBefore(DateTime.now())) {
        return Snowflake.zero();
      }

      final lateStartTime = DateTime.now().add(const Duration(minutes: 1));
      if (builder.startDate!.isBefore(lateStartTime)) {
        builder.startDate = lateStartTime;
      }

      return (await client.httpEndpoints.createGuildEvent(data.guildId, builder)).id;
    }));
  }

  FutureOr<GuildEventBuilder> createReviewsEventBuilder(DateTime cycleStart) async =>
      GuildEventBuilder()
        ..startDate = cycleStart.add(data.submissionsLength)
        ..endDate = cycleStart.add(data.submissionsLength + data.reviewLength)
        ..name = '${data.name} Reviews'
        ..metadata = EntityMetadataBuilder(
            '#${(await client.httpEndpoints.fetchChannel<IMinimalGuildChannel>(data.reviewsChannelId)).name}')
        ..type = GuildEventType.external
        ..privacyLevel = GuildEventPrivacyLevel.guildOnly;

  FutureOr<GuildEventBuilder> createSubmissionsEventBuilder(DateTime cycleStart) =>
      GuildEventBuilder()
        ..startDate = cycleStart
        ..endDate = cycleStart.add(data.submissionsLength)
        ..name = '${data.name} Submissions'
        ..metadata = EntityMetadataBuilder('/submit')
        ..type = GuildEventType.external
        ..privacyLevel = GuildEventPrivacyLevel.guildOnly;

  Future<void> cancelAllEvents() async {
    final cycle = await database.getCurrentCycle(this);

    for (final id in [
      cycle.submissionsEventId,
      cycle.reviewsEventId,
      cycle.nextCycleSubmissionsEventId
    ]) {
      if (id == Snowflake.zero()) {
        continue;
      }

      try {
        await client.httpEndpoints.editGuildEvent(
          data.guildId,
          id,
          GuildEventBuilder()
            ..status = GuildEventStatus.canceled
            ..channelId = null,
        );
      } on IHttpResponseError {
        // Started
        try {
          await client.httpEndpoints.editGuildEvent(
            data.guildId,
            id,
            GuildEventBuilder()
              ..status = GuildEventStatus.completed
              ..channelId = null,
          );
        } on IHttpResponseError {
          // In the past
        }
      }
    }
  }

  Future<void> updateSubmissionsEvent(Snowflake eventId, DateTime cycleStart) async {
    final eventBuilder = await createSubmissionsEventBuilder(cycleStart);

    if (eventId == Snowflake.zero()) {
      return;
    }

    await _updateEvent(eventId, eventBuilder);
  }

  Future<void> _updateEvent(Snowflake eventId, GuildEventBuilder builder) async {
    if (builder.startDate?.isBefore(DateTime.now()) == true) {
      builder.startDate = null;
    }

    if (builder.endDate?.isBefore(DateTime.now()) != false) {
      builder.endDate = null;
      builder.status = GuildEventStatus.completed;
    }

    try {
      await client.httpEndpoints.editGuildEvent(data.guildId, eventId, builder);
    } on IHttpResponseError {
      // Event was completed before we updated it
    }
  }

  Future<IMessage?> _sendMessageToChannel(Snowflake channelId, MessageBuilder message) async {
    try {
      return await client.httpEndpoints.sendMessage(channelId, message);
    } on IHttpResponseError catch (e) {
      logger.warning('Error ${e.errorCode} sending message to channel $channelId');
    }

    return null;
  }
}

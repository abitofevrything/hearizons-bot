import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:hearizons/commands/converters/event.dart';
import 'package:hearizons/commands/converters/event_type.dart';
import 'package:hearizons/hearizons/events/event.dart';
import 'package:hearizons/utils/context_extension.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/hearizons/event_type.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final event = ChatGroup(
  'event',
  'Manage events',
  children: [create, details],
);

// Keep in sync with [update]!
final create = ChatCommand(
  'create',
  'Create a new event',
  id('admin-event-create', (
    IChatContext context,
    @Description('The name of the event') String name,
    @Description('The type of the event') @UseConverter(eventTypeConverter) EventType type,
    @Description('The length of the submissions phase') Duration submissionsLength,
    @Description('The length of the review phase') Duration reviewLength,
    @Description('The channel to send announcements to') ITextGuildChannel announcementsChannel,
    @Description('The channel to send reviews to') ITextGuildChannel reviewsChannel,
    @Description('The role to give to participants') IRole participantRole,
  ) async {
    final database = GetIt.I.get<Database>();

    final event = await database.createEvent(EventsCompanion.insert(
      name: name,
      active: true,
      type: type,
      submissionsLength: submissionsLength,
      reviewLength: reviewLength,
      announcementsChannelId: announcementsChannel.id,
      reviewsChannelId: reviewsChannel.id,
      guildId: context.guild!.id,
      participantRoleId: participantRole.id,
    ));

    await event.startEvent();

    await context.success(
      title: 'Event created',
      content: '''
Event $name successfully created!
''',
    );
  }),
);

final details = ChatCommand(
  'details',
  'View the details of an event',
  id('admin-event-details', (
    IChatContext context,
    @Description('The event to inspect') @UseConverter(manageableEventConverter) Event event,
  ) async {
    final database = GetIt.I.get<Database>();

    final data = event.data;
    final cycle = await database.getCurrentCycle(event);

    await context.info(
      title: 'Event: ${data.name}',
      content: '''
Active: ${data.active}
Type: ${data.type.name}
Submissions length: ${data.submissionsLength}
Reviews length: ${data.reviewLength}
Announcement channel: <#${data.announcementsChannelId}>
Reviews channel: <#${data.reviewsChannelId}>

Current cycle started at: ${cycle.startedAt}
Current cycle status: ${cycle.status.name}
''',
    );
  }),
);

final update = ChatCommand(
  'update',
  'Update an event',
  id('admin-event-update', (
    IChatContext context, [
    @Description('The name of the event') String? name,
    @Description('The type of the event') @UseConverter(eventTypeConverter) EventType? type,
    @Description('The length of the submissions phase') Duration? submissionsLength,
    @Description('The length of the review phase') Duration? reviewLength,
    @Description('The channel to send announcements to') ITextGuildChannel? announcementsChannel,
    @Description('The channel to send reviews to') ITextGuildChannel? reviewsChannel,
    @Description('The role to give to participants') IRole? participantRole,
  ]) async {
    final database = GetIt.I.get<Database>();

    await database.updateEvent(EventsCompanion(
      name: Value.ofNullable(name),
      announcementsChannelId: Value.ofNullable(announcementsChannel?.id),
      participantRoleId: Value.ofNullable(participantRole?.id),
      reviewLength: Value.ofNullable(reviewLength),
      reviewsChannelId: Value.ofNullable(reviewsChannel?.id),
      submissionsLength: Value.ofNullable(submissionsLength),
      type: Value.ofNullable(type),
    ));
  }),
);

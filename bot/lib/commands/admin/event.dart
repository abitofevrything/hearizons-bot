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
import 'package:nyxx_interactions/nyxx_interactions.dart';

final event = ChatGroup(
  'event',
  'Manage events',
  children: [create, details, update, activate, deactivate, link, unlink],
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
    @Description('The length of the interval between cycles') Duration intervalLength,
    @Description('The channel to send announcements to') ITextGuildChannel announcementsChannel,
    @Description('The channel to send reviews to') ITextGuildChannel reviewsChannel,
    @Description('The role to give to participants') IRole participantRole,
    @Description('The role to mention in announcements') IRole announcementsRole,
  ) async {
    final database = GetIt.I.get<Database>();

    await database.createEvent(EventsCompanion.insert(
      name: name,
      active: false,
      type: type,
      submissionsLength: submissionsLength,
      reviewLength: reviewLength,
      intervalLength: intervalLength,
      announcementsChannelId: announcementsChannel.id,
      reviewsChannelId: reviewsChannel.id,
      guildId: context.guild!.id,
      participantRoleId: participantRole.id,
      announcementRoleId: announcementsRole.id,
    ));

    await context.success(
      title: 'Event created',
      content: '''
Event $name successfully created!

Run `/admin event activate event:$name` to activate this event.
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

    String cycleStatus = '';
    if (data.active) {
      final cycle = await database.getCurrentCycle(event);

      cycleStatus = '''
Current cycle started at: ${TimeStampStyle.shortDateTime.format(cycle.startedAt)}
Current cycle status: ${cycle.status.name}
''';
    }

    String linkedEventsStatus = '';
    final linkedEvents = await event.getLinkedEvents();
    if (linkedEvents.isNotEmpty) {
      linkedEventsStatus = 'Linked events: ${linkedEvents.map((e) => e.data.name).join(', ')}';
    }

    await context.info(
      title: 'Event: ${data.name}',
      content: '''
Active: ${data.active}
Type: ${data.type.name}
Submissions length: ${data.submissionsLength}
Reviews length: ${data.reviewLength}
Interval length: ${data.intervalLength}
Announcement channel: <#${data.announcementsChannelId}>
Reviews channel: <#${data.reviewsChannelId}>
Participant role: <@&${data.participantRoleId}>
Announcement role: <@&${data.announcementRoleId}>
$linkedEventsStatus

$cycleStatus
''',
    );
  }),
);

final update = ChatCommand(
  'update',
  'Update an event',
  id('admin-event-update', (
    IChatContext context,
    @Description('The event to update') @UseConverter(manageableEventConverter) Event event, [
    @Description('The name of the event') String? name,
    @Description('The type of the event') @UseConverter(eventTypeConverter) EventType? type,
    @Description('The length of the submissions phase') Duration? submissionsLength,
    @Description('The length of the review phase') Duration? reviewLength,
    @Description('The length of the interval between cycles') Duration? intervalLength,
    @Description('The channel to send announcements to') ITextGuildChannel? announcementsChannel,
    @Description('The channel to send reviews to') ITextGuildChannel? reviewsChannel,
    @Description('The role to give to participants') IRole? participantRole,
    @Description('The role to mention in announcements') IRole? announcementsRole,
  ]) async {
    await event.update(EventsCompanion(
      name: Value.ofNullable(name),
      announcementsChannelId: Value.ofNullable(announcementsChannel?.id),
      participantRoleId: Value.ofNullable(participantRole?.id),
      reviewLength: Value.ofNullable(reviewLength),
      intervalLength: Value.ofNullable(intervalLength),
      reviewsChannelId: Value.ofNullable(reviewsChannel?.id),
      submissionsLength: Value.ofNullable(submissionsLength),
      type: Value.ofNullable(type),
      announcementRoleId: Value.ofNullable(announcementsRole?.id),
    ));

    await context.success(
      title: 'Updated event',
      content: '''
Event updated successfully.

Run `/admin event details event:${name ?? event.data.name}` to see the new configuration.
''',
    );
  }),
);

final deactivate = ChatCommand(
  'deactivate',
  'Deactivate an event, preventing cycles, submissions & reviews',
  id(
    'admin-event-deactivate',
    (
      IChatContext context,
      @Description('The event to deactivate')
      @UseConverter(deactivateableEventConverter)
          Event event,
    ) async {
      final confirmation = await context.getConfirmation(
        MessageBuilder.embed(
          EmbedBuilder()
            ..color = warningColour
            ..title = 'Are you sure?'
            ..description = '''
Deactivating an event will remove all uncompleted assignments and will prevent anyone from submitting or reviewing in this event. Are you sure you want to deactivate this event?
''',
        ),
        values: {
          true: 'Yes, deactivate this event',
          false: 'No, cancel this',
        },
        styles: {
          true: ButtonStyle.danger,
          false: ButtonStyle.secondary,
        },
      );

      if (!confirmation) {
        await (context.latestContext as IInteractionInteractiveContext).acknowledge();
        return;
      }

      await event.deactivate();

      await context.success(
        title: 'Event deactivated',
        content: '''
Successfully deactivated event ${event.data.name}. Run `/admin event activate event:${event.data.name}` to reactivate it.
''',
      );
    },
  ),
);

final activate = ChatCommand(
  'activate',
  'Activate an event, starting a cycle immediately',
  id('admin-event-activate', (
    IChatContext context,
    @Description('The event to activate') @UseConverter(activateableEventConverter) Event event,
  ) async {
    final confirmation = await context.getConfirmation(
      MessageBuilder.embed(
        EmbedBuilder()
          ..color = warningColour
          ..title = 'Are you sure?'
          ..description = '''
Activating an event will open submissions and start phase/cycle timers immediately. Are you sure you want to activate this event?
''',
      ),
      values: {
        true: 'Yes, activate this event',
        false: 'No, cancel this',
      },
      styles: {
        true: ButtonStyle.danger,
        false: ButtonStyle.secondary,
      },
    );

    if (!confirmation) {
      await (context.latestContext as IInteractionInteractiveContext).acknowledge();
      return;
    }

    await event.activate();

    await context.success(
      title: 'Event activated',
      content: '''
Successfully activated event ${event.data.name}. Run `/admin event deactivate event:${event.data.name}` to deactivate it.

Submissions are now open and will be closed in ${TimeStampStyle.relativeTime.format(DateTime.now().add(event.data.submissionsLength))}.
''',
    );
  }),
);

final link = ChatCommand(
  'link',
  'Link an event to another event. Joins submission & review restrictions.',
  id('admin-event-link', (
    IChatContext context,
    @UseConverter(manageableEventConverter)
    @Description('The event that will be linked')
        Event event,
  ) async {
    final database = GetIt.I.get<Database>();

    final toLink = await context.getSelection(
      await database.getLinkeableEvents(event),
      toMultiSelect: (event) => MultiselectOptionBuilder(event.data.name, event.data.id.toString()),
      MessageBuilder.embed(
        EmbedBuilder()
          ..title = 'Select event'
          ..description = '''
Select an event to link to ${event.data.name}.

This link is one way, the event you select will not be affected by this event.
''',
      ),
    );

    await event.link(toLink);

    await context.success(
      title: 'Linked event',
      content: 'Successfully linked event ${toLink.data.name} to ${event.data.name}',
    );
  }),
);

final unlink = ChatCommand(
  'unlink',
  'Remove a link from an event',
  id('admin-event-unlink', (
    IChatContext context,
    @Description('The event that will be unlinked')
    @UseConverter(manageableEventConverter)
        Event event,
  ) async {
    final linkedEvents = await event.getLinkedEvents();

    if (linkedEvents.isEmpty) {
      await context.error(
        title: 'No linked events',
        content: "${event.data.name} isn't linked to any events",
      );
      return;
    }

    final toUnlink = await context.getSelection(
      linkedEvents,
      toMultiSelect: (e) => MultiselectOptionBuilder(e.data.name, e.data.id.toString()),
      MessageBuilder.embed(
        EmbedBuilder()
          ..title = 'Select event'
          ..description = '''
Select an event to unlink from ${event.data.name}.
''',
      ),
    );

    await event.unlink(toUnlink);

    await context.success(
      title: 'Linked event',
      content: 'Successfully unlinked event ${toUnlink.data.name} from ${event.data.name}',
    );
  }),
);

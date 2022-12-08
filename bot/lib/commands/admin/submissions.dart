import 'package:get_it/get_it.dart';
import 'package:hearizons/commands/converters/event.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/hearizons/events/event.dart';
import 'package:hearizons/utils/context_extension.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_pagination/nyxx_pagination.dart';

final submission = ChatGroup(
  'submission',
  'Manage submissions',
  children: [list],
);

final list = ChatCommand(
  'list',
  'List submissions for an event',
  id('admin-submission-list', (
    IChatContext context,
    @Description('The event to fetch submissions for')
    // deactivateableEventConverter gets active and manageable events
    @UseConverter(deactivateableEventConverter)
        Event event,
  ) async {
    final database = GetIt.I.get<Database>();

    final submissions = await database.getSubmissionsFromCycle(
      await database.getCurrentCycle(event),
    );

    if (submissions.isEmpty) {
      await context.warning(
        title: 'No submissions',
        content: 'No submissions were found for the current cycle of ${event.data.name}',
      );
      return;
    }

    final stringifiedSubmissions = submissions.map(
      (submission) => '<@!${submission.userId}>: ${submission.content}',
    );

    final groupedSubmissions = stringifiedSubmissions.fold(
      <String>[''],
      (currentPages, element) {
        final current = currentPages.last;

        if (current.length + element.length + 1 > 1024) {
          currentPages.add(element);
        } else {
          currentPages[currentPages.length - 1] = '$current\n$element';
        }

        return currentPages;
      },
    );

    final paginator = EmbedComponentPagination(
      context.interactions,
      groupedSubmissions
          .map((data) => EmbedBuilder()
            ..color = successColour
            ..title = 'Submissions for ${event.data.name}'
            ..description = data)
          .toList(),
    );

    await context.respond(paginator.initMessageBuilder());
  }),
);

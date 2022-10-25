import 'package:get_it/get_it.dart';
import 'package:hearizons/commands/converters/event.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/hearizons/events/event.dart';
import 'package:hearizons/utils/context_extension.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final submit = ChatCommand(
  'submit',
  'Create a submission for an event',
  id(
    'submit',
    (
      IChatContext context,
      @Description('The event to submit to')
      @UseConverter(acceptingSubmissionEventConverter)
          Event event,
      @Description('The content of the submission') String submission,
    ) async {
      await event.createSubmission(
        submission: submission,
        userId: context.user.id,
      );

      final database = GetIt.I.get<Database>();
      final cycle = await database.getCurrentCycle(event);

      await context.success(
        title: 'Submission created',
        content: '''
Your submission for ${event.data.name} has been created!

Reviews for this event open ${TimeStampStyle.relativeTime.format(cycle.startedAt.add(event.data.submissionsLength))}.
''',
      );
    },
  ),
);

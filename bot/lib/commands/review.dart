import 'package:get_it/get_it.dart';
import 'package:hearizons/commands/converters/assignment.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/utils/context_extension.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final review = ChatCommand(
  'review',
  'Submit a review for an assignment',
  id(
    'review',
    (
      IChatContext context,
      @Description('The assignment to review')
      @UseConverter(assignedAssignmentConverter)
          Assignment assignment,
      @Description('The content of the review') String review,
    ) async {
      final database = GetIt.I.get<Database>();
      final event = await database.getEventFromAssignment(assignment);

      await event.createReview(assignment, review);

      await context.success(
        title: 'Review created',
        content: 'Your review was successfully created!',
      );
    },
  ),
);

import 'package:get_it/get_it.dart';
import 'package:hearizons/commands/converters/assignment.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/utils/context_extension.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

final review = ChatCommand(
  'review',
  'Submit a review for an assignment',
  id(
    'review',
    (
      InteractionChatContext context,
      @Description('The assignment to review')
      @UseConverter(assignedAssignmentConverter)
          Assignment assignment,
    ) async {
      final database = GetIt.I.get<Database>();
      final event = await database.getEventFromAssignment(assignment);

      final modal = await context.getModal(
        title: 'Review',
        components: [
          TextInputBuilder('content', TextInputStyle.paragraph, 'Your review')
            ..maxLength = 1024
            ..minLength = 50,
        ],
      );

      await event.createReview(assignment, modal['content']);

      await context.success(
        title: 'Review created',
        content: 'Your review was successfully created!',
      );
    },
  ),
);

import 'package:get_it/get_it.dart';
import 'package:hearizons_bot/src/models/assigned_reviewer.dart';
import 'package:hearizons_bot/src/models/hearizon.dart';
import 'package:hearizons_bot/src/services/database.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

final review = ChatCommand.slashOnly(
  'review',
  'Submit a review',
  id('review', (
    InteractionChatContext context, [
    @Description('The Hearizon to submit a review for') Hearizon? hearizon,
  ]) async {
    final database = GetIt.I.get<Database>();

    if (hearizon == null) {
      if (database.reviewingHearizon.isEmpty) {
        final embed = EmbedBuilder()
          ..color = DiscordColor.red
          ..title = 'No active hearizon'
          ..description =
              'There are no currently active hearizons accepting reviews. Try again in a while.';

        await context.respond(MessageBuilder.embed(embed), private: true);
        return;
      }

      if (database.reviewingHearizon.length > 1) {
        final embed = EmbedBuilder()
          ..color = DiscordColor.red
          ..title = 'Unspecified hearizon'
          ..description =
              'There are currently multiple ongoing hearizons and you did not specify which hearizon to review. Try again with the `hearizon` command argument.';

        await context.respond(MessageBuilder.embed(embed), private: true);
        return;
      }

      hearizon = database.reviewingHearizon.first;
    }

    AssignedReviewer? toReview = database.getAssignment(context.user.id.id, hearizon);

    if (toReview == null) {
      final embed = EmbedBuilder()
        ..color = DiscordColor.red
        ..title = 'No reviews assigned'
        ..description = 'There was no review assigned to you for this Hearizon.';

      await context.respond(MessageBuilder.embed(embed), private: true);
      return;
    }

    if (toReview.reviewId != null) {
      final embed = EmbedBuilder()
        ..color = DiscordColor.red
        ..title = 'Review already submitted'
        ..description = "You've already submitted a review for this Hearizon.";

      await context.respond(MessageBuilder.embed(embed), private: true);
      return;
    }

    await context.interactionEvent.respondModal(
      ModalBuilder(
        'review-${toReview.id}',
        'Review for ${hearizon.name}',
      )..componentRows = [
          ComponentRowBuilder()
            ..addComponent(
              TextInputBuilder(
                'review',
                TextInputStyle.paragraph,
                'Review',
              )
                ..placeholder =
                    'Your review of ${database.getSubmission(toReview.submissionId).url}...'
                ..maxLength = 1024,
            )
        ],
    );
  }),
);

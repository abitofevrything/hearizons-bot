import 'package:get_it/get_it.dart';
import 'package:hearizons_bot/src/converters/hearizons.dart';
import 'package:hearizons_bot/src/models/hearizons.dart';
import 'package:hearizons_bot/src/models/submission.dart';
import 'package:hearizons_bot/src/services/database.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

final submit = ChatCommand(
  'submit',
  'Submit an entry to a Hearizons',
  id('submit', (
    IChatContext context,
    @Description('Link or title of your submission') @Name('submission') String url, [
    @Description('The hearizons to submit this to')
    @UseConverter(submittingHearizonsConverter)
        Hearizons? hearizons,
  ]) async {
    final database = GetIt.I.get<Database>();

    if (hearizons == null) {
      if (database.submittingHearizons.isEmpty) {
        final embed = EmbedBuilder()
          ..color = DiscordColor.red
          ..title = 'No active hearizons'
          ..description =
              'There are no currently active hearizons accepting submissions. Try again in a while.';

        await context.respond(MessageBuilder.embed(embed), private: true);
        return;
      }

      if (database.submittingHearizons.length > 1) {
        final embed = EmbedBuilder()
          ..color = DiscordColor.red
          ..title = 'Unspecified hearizons'
          ..description =
              'There are currently multiple ongoing hearizons and you did not specify which hearizons to submit to. Try again with the `hearizons` command argument.';

        await context.respond(MessageBuilder.embed(embed), private: true);
        return;
      }

      hearizons = database.submittingHearizons.first;
    }

    final incompleteReview = database.getAssignment(context.user.id.id, hearizons);
    if (incompleteReview != null) {
      final embed = EmbedBuilder()
        ..color = DiscordColor.red
        ..title = 'Incomplete review'
        ..description =
            'You have an overdue review. Please complete your review of ${database.getSubmission(incompleteReview.submissionId).url} before submitting another song.';

      await context.respond(MessageBuilder.embed(embed), private: true);
      return;
    }

    Submission submission = Submission(
      hearizonsId: hearizons.id!,
      phaseId: hearizons.phase,
      userId: context.user.id.id,
      url: url,
    );

    if (database.hasExistingSubmission(submission)) {
      final embed = EmbedBuilder()
        ..color = DiscordColor.orange
        ..title = 'Submission already exists'
        ..description =
            "You've already created a submission for this hearizons. Do you want to update your submission?";

      final updateButton = ButtonBuilder(
        'Update',
        'update-${context.hashCode}',
        ButtonStyle.danger,
      );

      final cancelButton = ButtonBuilder(
        'Cancel',
        'cancel-${context.hashCode}',
        ButtonStyle.secondary,
      );

      final componentRow = ComponentRowBuilder()
        ..addComponent(updateButton)
        ..addComponent(cancelButton);

      final message = await context.respond(
        ComponentMessageBuilder()
          ..embeds = [embed]
          ..componentRows = [componentRow],
        private: true,
      );

      final confirmation = await context.getButtonPress([updateButton, cancelButton]);

      await message.edit(ComponentMessageBuilder()
        ..componentRows = []
        ..embeds = [embed]);

      if (confirmation.interaction.customId == cancelButton.customId) {
        return;
      }
    }

    database.upsertSubmission(submission);

    final embed = EmbedBuilder()
      ..color = DiscordColor.green
      ..title = 'Submission created'
      ..description = 'Your submission for `$url` has been created.';

    await context.respond(MessageBuilder.embed(embed), private: true);
  }),
);

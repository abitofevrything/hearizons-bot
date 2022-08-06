import 'package:get_it/get_it.dart';
import 'package:hearizons_bot/src/models/review.dart';
import 'package:hearizons_bot/src/services/database.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

// TODO: Move to configuaration file
final reviewChannelId = Snowflake(973333557873348699);
// final reviewChannelId = Snowflake(840651654625492993);

final _regexp = RegExp(r'^review-(\d+)$');

Future<void> handleModalSubmit(IModalInteractionEvent event) async {
  final database = GetIt.I.get<Database>();

  final match = _regexp.firstMatch(event.interaction.customId);
  if (match == null) {
    return;
  }

  final assignment = database.getAssignedReviewer(int.parse(match.group(1)!));

  if (assignment.reviewId != null) {
    await event.respond(
      MessageBuilder.content("You've already submitted a review for this."),
      hidden: true,
    );
    return;
  }

  final review = Review(
    submissionId: assignment.submissionId,
    userId: assignment.userId,
    content: event.interaction.components
        .expand((_) => _)
        .whereType<IMessageTextInput>()
        .firstWhere((element) => element.customId == 'review')
        .value,
  );

  database.submitReview(review);

  final embed = EmbedBuilder()
    ..color = DiscordColor.flutterBlue
    ..title =
        'Review for ${database.getHearizons(database.getSubmission(review.submissionId).hearizonsId).name}'
    ..description =
        "This is <@!${review.userId}>'s review of ${database.getSubmission(review.submissionId).url}."
    ..addField(name: 'Review', content: review.content)
    ..addAuthor((author) {
      author.name = event.interaction.userAuthor!.username;
      author.iconUrl = event.interaction.userAuthor!.avatarURL();
    });

  await event.client.httpEndpoints.sendMessage(reviewChannelId, MessageBuilder.embed(embed));

  await event.respond(MessageBuilder.content('Your review has been submitted.'), hidden: true);
}

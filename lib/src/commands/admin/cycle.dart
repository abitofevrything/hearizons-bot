import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:hearizons_bot/src/models/assigned_reviewer.dart';
import 'package:hearizons_bot/src/models/hearizon.dart';
import 'package:hearizons_bot/src/services/database.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:nyxx_pagination/nyxx_pagination.dart';

final cycle = ChatGroup(
  'cycle',
  'Manage the Hearizon cycles',
  children: [advance, review],
);

final advance = ChatCommand(
  'advance',
  'Advance a Hearizon to the next cycle',
  id('admin-cycle-advance', (
    IChatContext context,
    @Description('The Hearizon to advance') Hearizon hearizon,
  ) async {
    final database = GetIt.I.get<Database>();

    if (!hearizon.inReview) {
      final embed = EmbedBuilder()
        ..color = DiscordColor.orange
        ..title = 'Hearizon not in review phase'
        ..description =
            "This Hearizon hasn't yet had a review in its current cycle. Are you sure you want to continue? Doing so will discard all submissions to the current cycle.";

      final updateButton = ButtonBuilder(
        'Continue',
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
      );

      final confirmation = await context.getButtonPress([updateButton, cancelButton]);

      await message.edit(ComponentMessageBuilder()
        ..componentRows = []
        ..embeds = [embed]);

      if (confirmation.interaction.customId == cancelButton.customId) {
        return;
      }
    }

    database.upsertHearizon(hearizon.copyWith(
      inReview: false,
      phase: hearizon.phase + 1,
    ));

    final embed = EmbedBuilder()
      ..color = DiscordColor.green
      ..title = 'Hearizon moved to the next cycle'
      ..description = 'Successfully moved to the next cycle.';

    await context.respond(MessageBuilder.embed(embed));
  }),
);

final review = ChatCommand(
  'review',
  'Move a Hearizon into the review phase',
  id('admin-hearizon-review', (
    IChatContext context,
    @Description('The Hearizon to review') Hearizon hearizon,
  ) async {
    final database = GetIt.I.get<Database>();

    if (hearizon.inReview) {
      final embed = EmbedBuilder()
        ..color = DiscordColor.red
        ..title = 'Hearizon already in review'
        ..description = '${hearizon.name} is already in the review phase.';

      await context.respond(MessageBuilder.embed(embed));
      return;
    }

    var submissions = database.getSubmissionsForHearizon(hearizon).toList();

    if (submissions.length < 2) {
      final embed = EmbedBuilder()
        ..color = DiscordColor.red
        ..title = 'Not enough submissions'
        ..description =
            'There are not yet enough submissions (${submissions.length}) to move to the review phase.';

      await context.respond(MessageBuilder.embed(embed));
      return;
    }

    final userIds = submissions.map((submission) => submission.userId).toList();
    final originalSubmissions = submissions;

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

    ComponentMessageBuilder message;
    do {
      submissions = List.of(originalSubmissions);
      derange(submissions);

      List<String> lines = [
        for (int i = 0; i < userIds.length; i++) '<@!${userIds[i]}>: ${submissions[i].url}',
      ];

      final paginator = EmbedComponentPagination(
        context.commands.interactions,
        lines
            .fold<List<List<String>>>(
              [[]],
              (pages, line) {
                // +1 for newline
                final wouldBeLength = pages.last.join('\n').length + line.length + 1;

                if (wouldBeLength > 1024 || pages.last.length >= 10) {
                  pages.add([]);
                }

                return pages..last.add(line);
              },
            )
            .map(
              (lines) => EmbedBuilder()
                ..color = DiscordColor.yellow
                ..title = 'Assignments'
                ..description = lines.join('\n'),
            )
            .toList(),
      );

      message = paginator.initMessageBuilder();
    } while (!await context.getConfirmation(
      message,
      confirmMessage: 'Continue',
      denyMessage: 'Reshuffle',
    ));

    List<AssignedReviewer> assignments = [
      for (int i = 0; i < userIds.length; i++)
        AssignedReviewer(
          submissionId: submissions[i].id!,
          userId: userIds[i],
        ),
    ];

    for (final assignment in assignments) {
      database.upsertAssignedReviewer(assignment);
    }

    database.upsertHearizon(hearizon.copyWith(inReview: true));

    final embed = EmbedBuilder()
      ..color = DiscordColor.green
      ..title = 'Hearizon in review phase'
      ..description = 'Successfully moved to the review phase!';

    await context.respond(MessageBuilder.embed(embed));
  }),
);

import 'package:get_it/get_it.dart';
import 'package:hearizons_bot/src/models/hearizon.dart';
import 'package:hearizons_bot/src/services/database.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final hearizon = ChatGroup(
  'hearizon',
  'Manage Hearizons',
  children: [create],
);

final create = ChatCommand(
  'create',
  'Create a new hearizon',
  id('admin-hearizon-create', (
    IChatContext context,
    @Description('The name of the hearizon') String name,
  ) async {
    final database = GetIt.I.get<Database>();

    if (database.hearizonExists(name) || name.isEmpty) {
      final embed = EmbedBuilder()
        ..color = DiscordColor.red
        ..title = 'Invalid name'
        ..description =
            name.isEmpty ? 'Name cannot be empty.' : 'A hearizon with this name already exists.';

      await context.respond(MessageBuilder.embed(embed));
      return;
    }

    database.upsertHearizon(Hearizon(name: name));

    final embed = EmbedBuilder()
      ..color = DiscordColor.green
      ..title = 'Hearizon created'
      ..description = 'Hearizon `$name` created successfully!';

    await context.respond(MessageBuilder.embed(embed));
  }),
);

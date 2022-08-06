import 'package:get_it/get_it.dart';
import 'package:hearizons_bot/src/models/hearizons.dart';
import 'package:hearizons_bot/src/services/database.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

final hearizons = ChatGroup(
  'hearizons',
  'Manage hearizons',
  children: [create],
);

final create = ChatCommand(
  'create',
  'Create a new hearizons',
  id('admin-hearizons-create', (
    IChatContext context,
    @Description('The name of the hearizons') String name,
  ) async {
    final database = GetIt.I.get<Database>();

    if (database.hearizonsExists(name) || name.isEmpty) {
      final embed = EmbedBuilder()
        ..color = DiscordColor.red
        ..title = 'Invalid name'
        ..description =
            name.isEmpty ? 'Name cannot be empty.' : 'A hearizons with this name already exists.';

      await context.respond(MessageBuilder.embed(embed));
      return;
    }

    database.upsertHearizons(Hearizons(name: name));

    final embed = EmbedBuilder()
      ..color = DiscordColor.green
      ..title = 'Hearizons created'
      ..description = 'Hearizons `$name` created successfully!';

    await context.respond(MessageBuilder.embed(embed));
  }),
);

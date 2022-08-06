import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hearizons_bot/hearizons_bot.dart';
import 'package:hearizons_bot/src/services/database.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

void main() async {
  final client = NyxxFactory.createNyxxWebsocket(
    Platform.environment['TOKEN']!,
    GatewayIntents.allUnprivileged,
    options: ClientOptions(
      initialPresence: PresenceBuilder.of(activity: ActivityBuilder.listening('your music!')),
    ),
  );

  final commands = CommandsPlugin(
    // No prefix
    prefix: (_) => '',
    guild: Snowflake(Platform.environment['GUILD']!),
    options: CommandsOptions(
      hideOriginalResponse: true,
      defaultCommandType: CommandType.slashOnly,
    ),
  );

  commands
    ..addCommand(ping)
    ..addCommand(admin)
    ..addCommand(submit)
    ..addCommand(review);

  commands.addConverter(activeHearizonsConverter);

  client
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions())
    ..registerPlugin(commands);

  commands.interactions.events.onModalEvent.listen(handleModalSubmit);

  GetIt.I.registerSingleton(initializeDatabase());

  await client.connect();
}

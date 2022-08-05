import 'dart:io';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

void main() async {
  final client = NyxxFactory.createNyxxWebsocket(
    Platform.environment['TOKEN']!,
    GatewayIntents.allUnprivileged,
  );

  final commands = CommandsPlugin(
    // No prefix
    prefix: (_) => '',
    guild: Snowflake(Platform.environment['GUILD']!),
  );

  // Only allow interactions
  commands.check(InteractionCommandCheck());

  client
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions())
    ..registerPlugin(commands);

  await client.connect();
}

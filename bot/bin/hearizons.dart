import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hearizons/commands/ping.dart';
import 'package:hearizons/commands/review.dart';
import 'package:hearizons/commands/submit.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/error_handler.dart';
import 'package:hearizons/hearizons/events_service.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

void main() async {
  final client = NyxxFactory.createNyxxWebsocket(
    Platform.environment['HEARIZONS_TOKEN']!,
    GatewayIntents.allUnprivileged,
  );

  final commands = CommandsPlugin(
    prefix: null,
    options: CommandsOptions(
      defaultResponseLevel: ResponseLevel.private,
      inferDefaultCommandType: true,
      logErrors: false,
    ),
  );

  commands
    ..addCommand(ping)
    ..addCommand(submit)
    ..addCommand(review);

  commands.onCommandError.listen(handleError);

  client
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions())
    ..registerPlugin(commands);

  GetIt.I.registerSingleton(Database());
  GetIt.I.registerSingleton(EventsService());
  GetIt.I.registerSingleton(client);
  GetIt.I.registerSingleton(commands);

  await client.connect();
}
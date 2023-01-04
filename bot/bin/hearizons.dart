import 'dart:io' as io;

import 'package:get_it/get_it.dart';
import 'package:hearizons/commands/admin/admin.dart';
import 'package:hearizons/commands/converters/duration.dart';
import 'package:hearizons/commands/ping.dart';
import 'package:hearizons/commands/review.dart';
import 'package:hearizons/commands/submit.dart';
import 'package:hearizons/database/database.dart';
import 'package:hearizons/error_handler.dart';
import 'package:hearizons/hearizons/events_service.dart';
import 'package:hearizons/platforms/platform.dart';
import 'package:hearizons/platforms/spotify.dart';
import 'package:hearizons/platforms/youtube.dart';
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

void main() async {
  final client = NyxxFactory.createNyxxWebsocket(
    io.Platform.environment['HEARIZONS_TOKEN']!,
    GatewayIntents.allUnprivileged,
    options: ClientOptions(
      shutdownHook: (client) async {
        await Future.wait(platforms.map((platform) => platform.dispose()));
      },
    ),
  );

  final commands = CommandsPlugin(
    prefix: null,
    options: CommandsOptions(
      defaultResponseLevel: ResponseLevel.private,
      inferDefaultCommandType: true,
      logErrors: false,
      autoAcknowledgeDuration: Duration.zero, // Hack for slow internet
    ),
  );

  commands
    ..addCommand(ping)
    ..addCommand(submit)
    ..addCommand(review)
    ..addCommand(admin);

  commands.onCommandError.listen(handleError);

  commands
    ..addConverter(durationConverter)
    ..addConverter<Duration?>(durationConverter);

  // Nullable converters
  commands
    ..addConverter(commands.getConverter(const DartType<String?>(), logWarn: false)!)
    ..addConverter(commands.getConverter(const DartType<ITextGuildChannel?>(), logWarn: false)!)
    ..addConverter(commands.getConverter(const DartType<IRole?>(), logWarn: false)!);

  client
    ..registerPlugin(Logging())
    ..registerPlugin(CliIntegration())
    ..registerPlugin(IgnoreExceptions())
    ..registerPlugin(commands);

  GetIt.I.registerSingleton(Database());
  GetIt.I.registerSingleton(EventsService());
  GetIt.I.registerSingleton(client);
  GetIt.I.registerSingleton(commands);

  GetIt.I.registerSingleton(await Spotify.connect());
  GetIt.I.registerSingleton(await YouTube.connect());

  await client.connect();
}

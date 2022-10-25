import 'package:http/http.dart' as http;
import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:hearizons/utils/context_extension.dart';

final ping = ChatCommand(
  'ping',
  'Check if the bot is connected to Discord.',
  options: CommandOptions(
    defaultResponseLevel: ResponseLevel.public,
  ),
  id('ping', (IChatContext context) async {
    final gatewayLatency =
        (context.client as INyxxWebsocket).shardManager.gatewayLatency.inMilliseconds;

    final restLatencyTimer = Stopwatch()..start();
    await http.head(Uri(
      scheme: 'https',
      host: Constants.host,
      path: Constants.baseUri,
    ));
    final restLatency = (restLatencyTimer..stop()).elapsedMilliseconds;

    await context.info(
      title: 'Pong!',
      content: '''
HTTP latency: ${restLatency}ms
Gateway latency: ${gatewayLatency}ms
''',
    );
  }),
);

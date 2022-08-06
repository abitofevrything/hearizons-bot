import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

Future<void> handleError(CommandsException error) async {
  if (error is CommandInvocationException) {
    final embed = EmbedBuilder()
      ..title = 'An error occurred'
      ..description = """
We're sorry, but an error occurred when trying to run your command.

The bot is still in beta, so bugs are to be expected! Please help us make the bot better by mentioning
<@!506759329068613643> and linking this message.
"""
      ..addFooter((footer) {
        if (error is UncaughtException) {
          footer.text = error.exception.runtimeType.toString();
        } else {
          footer.text = error.runtimeType.toString();
        }
      });

    await error.context.respond(MessageBuilder.embed(embed), private: true);
  }
}

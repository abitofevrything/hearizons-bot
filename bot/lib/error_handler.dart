import 'package:hearizons/errors.dart';
import 'package:hearizons/utils/context_extension.dart';
import 'package:nyxx_commands/nyxx_commands.dart';

Future<void> handleError(CommandsException error) async {
  if (error is CommandInvocationException) {
    final context = error.context;

    if (error is UncaughtException) {
      final exception = error.exception;

      if (exception is UserDisplayedException) {
        return exception.handle(context);
      }

      await context.error(
        title: 'Sorry, an unexpected error has occurred.',
        content: '''
You're seeing this message because an error happened while processing your command. Try again, and if the error persists, contact an administrator for more information.
''',
      );
      return;
    } else if (error is NotEnoughArgumentsException) {
      // Ignore, we don't use text commands
    } else if (error is CheckFailedException) {
      await context.error(
        title: "Sorry, you can't use this command.",
        content: '''
You can't use this command right now. Try again later or from a different channel.
''',
      );

      return;
    }
  } else if (error is ConverterFailedException) {
    final context = error.context;

    if (context is IInteractiveContext) {
      await (context as IInteractiveContext).error(
        title: 'Bad input',
        content: '''
We couldn't convert your input to a valid value. Please try again.
''',
      );
      return;
    }
  }
}

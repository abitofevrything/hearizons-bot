import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart' as fuzzy;
import 'package:human_duration_parser/human_duration_parser.dart';

final durationConverter = Converter<Duration>(
  (view, context) {
    final duration = parseStringToDuration(view.getQuotedWord());

    // [parseStringToDuration] returns Duration.zero on parsing failure
    if (duration.inMilliseconds > 0) {
      return duration;
    }

    return null;
  },
  autocompleteCallback: autocompleteDuration,
);

Iterable<ArgChoiceBuilder> autocompleteDuration(AutocompleteContext context) {
  final clustersSoFar = context.currentValue.split(RegExp(r'((?<=\s)(?=\d))'));
  final options = ['seconds', 'minutes', 'hours', 'days', 'months', 'years'];

  Iterable<String> correct(String current, Iterable<String> nextParts) {
    current = current.trim();
    final currentSplit = current.split(RegExp(r'\s+|(?<=\d)(?=\w)|(?<=\w)(?=\d)'));
    final corrected = <String>[];

    if (current.isEmpty) {
      // Populate the choices with examples.
      corrected.addAll(options.map((suffix) => '1 $suffix'));
    } else if (currentSplit.length >= 2) {
      // Try to fix the current input. If it is already valid, this code does nothing.
      final numbers = currentSplit.takeWhile((value) => RegExp(r'\d+').hasMatch(value));
      final rest = currentSplit.skip(numbers.length).join();

      var number = numbers.join();
      if (number.isEmpty) {
        number = '0';
      }

      String resolvedRest;
      try {
        resolvedRest = fuzzy
            .extractOne(
              query: rest,
              choices: options,
            )
            .choice;
      } on StateError {
        resolvedRest = rest;
      }

      corrected.add('$number $resolvedRest');
    } else if (RegExp(r'\d$').hasMatch(current)) {
      corrected.addAll(options.map((suffix) => '$current $suffix'));
    }

    if (nextParts.isEmpty) {
      return corrected;
    }

    return corrected
        // Expand each corrected part with all possible corrections to the following parts
        .expand((correctedStart) => correct(nextParts.first, nextParts.skip(1)).map(
              (correctedEnd) => '$correctedStart $correctedEnd'.trim(),
            ));
  }

  final result = correct(clustersSoFar.first, clustersSoFar.skip(1))
      .take(25)
      .map((e) => ArgChoiceBuilder(e, e));

  if (result.isNotEmpty) {
    return result;
  }

  return [ArgChoiceBuilder(context.currentValue, context.currentValue)];
}

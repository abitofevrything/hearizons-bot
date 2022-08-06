import 'package:collection/collection.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:get_it/get_it.dart';
import 'package:hearizons_bot/src/models/hearizons.dart';
import 'package:hearizons_bot/src/services/database.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

Iterable<Hearizons> _searchHearizons(String name, Iterable<Hearizons> source) {
  return Fuzzy<Hearizons>(
    source.toList(),
    options: FuzzyOptions(
      keys: [
        WeightedKey(name: 'name', getter: (hearizons) => hearizons.name, weight: 1),
      ],
    ),
  ).search(name).map((e) => e.item);
}

Hearizons? _getHearizons(String name, Iterable<Hearizons> source) =>
    _searchHearizons(name, source).firstOrNull;

final activeHearizonsConverter = Converter<Hearizons>(
  (view, context) => _getHearizons(view.getQuotedWord(), GetIt.I.get<Database>().activeHearizons),
  autocompleteCallback: (context) => _searchHearizons(
    context.currentValue,
    GetIt.I.get<Database>().activeHearizons,
  ).map(
    (e) => ArgChoiceBuilder(e.name, e.name),
  ),
);

Hearizons? _getSubmittingHearizons(StringView view, IChatContext context) =>
    _getHearizons(view.getQuotedWord(), GetIt.I.get<Database>().submittingHearizons);

Iterable<ArgChoiceBuilder> _searchSubmittingHearizons(AutocompleteContext context) =>
    _searchHearizons(
      context.currentValue,
      GetIt.I.get<Database>().submittingHearizons,
    ).map(
      (e) => ArgChoiceBuilder(e.name, e.name),
    );

const submittingHearizonsConverter = Converter<Hearizons>(
  _getSubmittingHearizons,
  autocompleteCallback: _searchSubmittingHearizons,
);

Hearizons? _getReviewingHearizons(StringView view, IChatContext context) =>
    _getHearizons(view.getQuotedWord(), GetIt.I.get<Database>().reviewingHearizons);

Iterable<ArgChoiceBuilder> _searchReviewingHearizons(AutocompleteContext context) =>
    _searchHearizons(
      context.currentValue,
      GetIt.I.get<Database>().reviewingHearizons,
    ).map(
      (e) => ArgChoiceBuilder(e.name, e.name),
    );

const reviewingHearizonsConverter = Converter<Hearizons>(
  _getReviewingHearizons,
  autocompleteCallback: _searchReviewingHearizons,
);

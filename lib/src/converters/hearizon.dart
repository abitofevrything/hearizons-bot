import 'package:collection/collection.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:get_it/get_it.dart';
import 'package:hearizons_bot/src/models/hearizon.dart';
import 'package:hearizons_bot/src/services/database.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:nyxx_interactions/nyxx_interactions.dart';

Iterable<Hearizon> _searchHearizons(String name, Iterable<Hearizon> source) {
  return Fuzzy<Hearizon>(
    source.toList(),
    options: FuzzyOptions(
      keys: [
        WeightedKey(name: 'name', getter: (hearizon) => hearizon.name, weight: 1),
      ],
    ),
  ).search(name).map((e) => e.item);
}

Hearizon? _getHearizons(String name, Iterable<Hearizon> source) =>
    _searchHearizons(name, source).firstOrNull;

final activeHearizonConverter = Converter<Hearizon>(
  (view, context) => _getHearizons(view.getQuotedWord(), GetIt.I.get<Database>().activeHearizon),
  autocompleteCallback: (context) => _searchHearizons(
    context.currentValue,
    GetIt.I.get<Database>().activeHearizon,
  ).map(
    (e) => ArgChoiceBuilder(e.name, e.name),
  ),
);

Hearizon? _getSubmittingHearizon(StringView view, IChatContext context) =>
    _getHearizons(view.getQuotedWord(), GetIt.I.get<Database>().submittingHearizon);

Iterable<ArgChoiceBuilder> _searchSubmittingHearizons(AutocompleteContext context) =>
    _searchHearizons(
      context.currentValue,
      GetIt.I.get<Database>().submittingHearizon,
    ).map(
      (e) => ArgChoiceBuilder(e.name, e.name),
    );

const submittingHearizonConverter = Converter<Hearizon>(
  _getSubmittingHearizon,
  autocompleteCallback: _searchSubmittingHearizons,
);

Hearizon? _getReviewingHearizon(StringView view, IChatContext context) =>
    _getHearizons(view.getQuotedWord(), GetIt.I.get<Database>().reviewingHearizon);

Iterable<ArgChoiceBuilder> _searchReviewingHearizons(AutocompleteContext context) =>
    _searchHearizons(
      context.currentValue,
      GetIt.I.get<Database>().reviewingHearizon,
    ).map(
      (e) => ArgChoiceBuilder(e.name, e.name),
    );

const reviewingHearizonConverter = Converter<Hearizon>(
  _getReviewingHearizon,
  autocompleteCallback: _searchReviewingHearizons,
);

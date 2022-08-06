import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hearizons_bot/src/util.dart';

part 'hearizon.freezed.dart';
part 'hearizon.g.dart';

@freezed
class Hearizon with _$Hearizon {
  @SqliteBoolConverter()
  const factory Hearizon({
    int? id,
    required String name,
    @Default(false) @JsonKey(name: 'in_review') bool inReview,
    @Default(0) int phase,
    @Default(false) bool closed,
  }) = _Hearizon;

  factory Hearizon.fromJson(Map<String, Object?> json) => _$HearizonFromJson(json);
}

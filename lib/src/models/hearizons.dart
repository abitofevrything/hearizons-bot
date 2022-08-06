import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hearizons_bot/src/util.dart';

part 'hearizons.freezed.dart';
part 'hearizons.g.dart';

@freezed
class Hearizons with _$Hearizons {
  @SqliteBoolConverter()
  const factory Hearizons({
    int? id,
    required String name,
    @Default(false) @JsonKey(name: 'in_review') bool inReview,
    @Default(0) int phase,
    @Default(false) bool closed,
  }) = _Hearizons;

  factory Hearizons.fromJson(Map<String, Object?> json) => _$HearizonsFromJson(json);
}

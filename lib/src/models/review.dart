import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hearizons_bot/src/util.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  @SqliteBoolConverter()
  const factory Review({
    int? id,
    @JsonKey(name: 'submission_id') required int submissionId,
    @JsonKey(name: 'user_id') required int userId,
    required String content,
  }) = _Review;

  factory Review.fromJson(Map<String, Object?> json) => _$ReviewFromJson(json);
}

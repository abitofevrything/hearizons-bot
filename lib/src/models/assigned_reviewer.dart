import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hearizons_bot/src/util.dart';

part 'assigned_reviewer.freezed.dart';
part 'assigned_reviewer.g.dart';

@freezed
class AssignedReviewer with _$AssignedReviewer {
  @SqliteBoolConverter()
  const factory AssignedReviewer({
    int? id,
    @JsonKey(name: 'submission_id') required int submissionId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'review_id') int? reviewId,
  }) = _AssignedReviewer;

  factory AssignedReviewer.fromJson(Map<String, Object?> json) => _$AssignedReviewerFromJson(json);
}

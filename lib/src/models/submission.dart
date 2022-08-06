import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hearizons_bot/src/util.dart';

part 'submission.freezed.dart';
part 'submission.g.dart';

@freezed
class Submission with _$Submission {
  @SqliteBoolConverter()
  const factory Submission({
    int? id,
    @JsonKey(name: 'hearizons_id') required int hearizonsId,
    @JsonKey(name: 'phase_id') required int phaseId,
    @JsonKey(name: 'user_id') required int userId,
    required String url,
  }) = _Submission;

  factory Submission.fromJson(Map<String, Object?> json) => _$SubmissionFromJson(json);
}

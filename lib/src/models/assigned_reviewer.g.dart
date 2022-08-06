// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_reviewer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AssignedReviewer _$$_AssignedReviewerFromJson(Map<String, dynamic> json) =>
    _$_AssignedReviewer(
      id: json['id'] as int?,
      submissionId: json['submission_id'] as int,
      userId: json['user_id'] as int,
      reviewId: json['review_id'] as int?,
    );

Map<String, dynamic> _$$_AssignedReviewerToJson(_$_AssignedReviewer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'submission_id': instance.submissionId,
      'user_id': instance.userId,
      'review_id': instance.reviewId,
    };

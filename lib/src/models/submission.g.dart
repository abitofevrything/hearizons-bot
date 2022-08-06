// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Submission _$$_SubmissionFromJson(Map<String, dynamic> json) =>
    _$_Submission(
      id: json['id'] as int?,
      hearizonId: json['hearizons_id'] as int,
      phaseId: json['phase_id'] as int,
      userId: json['user_id'] as int,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$_SubmissionToJson(_$_Submission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hearizons_id': instance.hearizonId,
      'phase_id': instance.phaseId,
      'user_id': instance.userId,
      'url': instance.url,
    };

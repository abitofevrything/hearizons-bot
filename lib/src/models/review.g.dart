// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Review _$$_ReviewFromJson(Map<String, dynamic> json) => _$_Review(
      id: json['id'] as int?,
      submissionId: json['submission_id'] as int,
      userId: json['user_id'] as int,
      content: json['content'] as String,
    );

Map<String, dynamic> _$$_ReviewToJson(_$_Review instance) => <String, dynamic>{
      'id': instance.id,
      'submission_id': instance.submissionId,
      'user_id': instance.userId,
      'content': instance.content,
    };

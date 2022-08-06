// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hearizons.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Hearizons _$$_HearizonsFromJson(Map<String, dynamic> json) => _$_Hearizons(
      id: json['id'] as int?,
      name: json['name'] as String,
      inReview: json['in_review'] == null
          ? false
          : const SqliteBoolConverter().fromJson(json['in_review'] as int),
      phase: json['phase'] as int? ?? 0,
      closed: json['closed'] == null
          ? false
          : const SqliteBoolConverter().fromJson(json['closed'] as int),
    );

Map<String, dynamic> _$$_HearizonsToJson(_$_Hearizons instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'in_review': const SqliteBoolConverter().toJson(instance.inReview),
      'phase': instance.phase,
      'closed': const SqliteBoolConverter().toJson(instance.closed),
    };

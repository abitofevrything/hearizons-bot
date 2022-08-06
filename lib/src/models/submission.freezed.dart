// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'submission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Submission _$SubmissionFromJson(Map<String, dynamic> json) {
  return _Submission.fromJson(json);
}

/// @nodoc
mixin _$Submission {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'hearizons_id')
  int get hearizonId => throw _privateConstructorUsedError;
  @JsonKey(name: 'phase_id')
  int get phaseId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubmissionCopyWith<Submission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmissionCopyWith<$Res> {
  factory $SubmissionCopyWith(
          Submission value, $Res Function(Submission) then) =
      _$SubmissionCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      @JsonKey(name: 'hearizons_id') int hearizonId,
      @JsonKey(name: 'phase_id') int phaseId,
      @JsonKey(name: 'user_id') int userId,
      String url});
}

/// @nodoc
class _$SubmissionCopyWithImpl<$Res> implements $SubmissionCopyWith<$Res> {
  _$SubmissionCopyWithImpl(this._value, this._then);

  final Submission _value;
  // ignore: unused_field
  final $Res Function(Submission) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? hearizonId = freezed,
    Object? phaseId = freezed,
    Object? userId = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      hearizonId: hearizonId == freezed
          ? _value.hearizonId
          : hearizonId // ignore: cast_nullable_to_non_nullable
              as int,
      phaseId: phaseId == freezed
          ? _value.phaseId
          : phaseId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_SubmissionCopyWith<$Res>
    implements $SubmissionCopyWith<$Res> {
  factory _$$_SubmissionCopyWith(
          _$_Submission value, $Res Function(_$_Submission) then) =
      __$$_SubmissionCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      @JsonKey(name: 'hearizons_id') int hearizonId,
      @JsonKey(name: 'phase_id') int phaseId,
      @JsonKey(name: 'user_id') int userId,
      String url});
}

/// @nodoc
class __$$_SubmissionCopyWithImpl<$Res> extends _$SubmissionCopyWithImpl<$Res>
    implements _$$_SubmissionCopyWith<$Res> {
  __$$_SubmissionCopyWithImpl(
      _$_Submission _value, $Res Function(_$_Submission) _then)
      : super(_value, (v) => _then(v as _$_Submission));

  @override
  _$_Submission get _value => super._value as _$_Submission;

  @override
  $Res call({
    Object? id = freezed,
    Object? hearizonId = freezed,
    Object? phaseId = freezed,
    Object? userId = freezed,
    Object? url = freezed,
  }) {
    return _then(_$_Submission(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      hearizonId: hearizonId == freezed
          ? _value.hearizonId
          : hearizonId // ignore: cast_nullable_to_non_nullable
              as int,
      phaseId: phaseId == freezed
          ? _value.phaseId
          : phaseId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@SqliteBoolConverter()
class _$_Submission implements _Submission {
  const _$_Submission(
      {this.id,
      @JsonKey(name: 'hearizons_id') required this.hearizonId,
      @JsonKey(name: 'phase_id') required this.phaseId,
      @JsonKey(name: 'user_id') required this.userId,
      required this.url});

  factory _$_Submission.fromJson(Map<String, dynamic> json) =>
      _$$_SubmissionFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'hearizons_id')
  final int hearizonId;
  @override
  @JsonKey(name: 'phase_id')
  final int phaseId;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  final String url;

  @override
  String toString() {
    return 'Submission(id: $id, hearizonId: $hearizonId, phaseId: $phaseId, userId: $userId, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Submission &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.hearizonId, hearizonId) &&
            const DeepCollectionEquality().equals(other.phaseId, phaseId) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(hearizonId),
      const DeepCollectionEquality().hash(phaseId),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  _$$_SubmissionCopyWith<_$_Submission> get copyWith =>
      __$$_SubmissionCopyWithImpl<_$_Submission>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubmissionToJson(
      this,
    );
  }
}

abstract class _Submission implements Submission {
  const factory _Submission(
      {final int? id,
      @JsonKey(name: 'hearizons_id') required final int hearizonId,
      @JsonKey(name: 'phase_id') required final int phaseId,
      @JsonKey(name: 'user_id') required final int userId,
      required final String url}) = _$_Submission;

  factory _Submission.fromJson(Map<String, dynamic> json) =
      _$_Submission.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'hearizons_id')
  int get hearizonId;
  @override
  @JsonKey(name: 'phase_id')
  int get phaseId;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  String get url;
  @override
  @JsonKey(ignore: true)
  _$$_SubmissionCopyWith<_$_Submission> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'assigned_reviewer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AssignedReviewer _$AssignedReviewerFromJson(Map<String, dynamic> json) {
  return _AssignedReviewer.fromJson(json);
}

/// @nodoc
mixin _$AssignedReviewer {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'submission_id')
  int get submissionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'review_id')
  int? get reviewId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssignedReviewerCopyWith<AssignedReviewer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssignedReviewerCopyWith<$Res> {
  factory $AssignedReviewerCopyWith(
          AssignedReviewer value, $Res Function(AssignedReviewer) then) =
      _$AssignedReviewerCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      @JsonKey(name: 'submission_id') int submissionId,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'review_id') int? reviewId});
}

/// @nodoc
class _$AssignedReviewerCopyWithImpl<$Res>
    implements $AssignedReviewerCopyWith<$Res> {
  _$AssignedReviewerCopyWithImpl(this._value, this._then);

  final AssignedReviewer _value;
  // ignore: unused_field
  final $Res Function(AssignedReviewer) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? submissionId = freezed,
    Object? userId = freezed,
    Object? reviewId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      submissionId: submissionId == freezed
          ? _value.submissionId
          : submissionId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      reviewId: reviewId == freezed
          ? _value.reviewId
          : reviewId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$$_AssignedReviewerCopyWith<$Res>
    implements $AssignedReviewerCopyWith<$Res> {
  factory _$$_AssignedReviewerCopyWith(
          _$_AssignedReviewer value, $Res Function(_$_AssignedReviewer) then) =
      __$$_AssignedReviewerCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      @JsonKey(name: 'submission_id') int submissionId,
      @JsonKey(name: 'user_id') int userId,
      @JsonKey(name: 'review_id') int? reviewId});
}

/// @nodoc
class __$$_AssignedReviewerCopyWithImpl<$Res>
    extends _$AssignedReviewerCopyWithImpl<$Res>
    implements _$$_AssignedReviewerCopyWith<$Res> {
  __$$_AssignedReviewerCopyWithImpl(
      _$_AssignedReviewer _value, $Res Function(_$_AssignedReviewer) _then)
      : super(_value, (v) => _then(v as _$_AssignedReviewer));

  @override
  _$_AssignedReviewer get _value => super._value as _$_AssignedReviewer;

  @override
  $Res call({
    Object? id = freezed,
    Object? submissionId = freezed,
    Object? userId = freezed,
    Object? reviewId = freezed,
  }) {
    return _then(_$_AssignedReviewer(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      submissionId: submissionId == freezed
          ? _value.submissionId
          : submissionId // ignore: cast_nullable_to_non_nullable
              as int,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      reviewId: reviewId == freezed
          ? _value.reviewId
          : reviewId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@SqliteBoolConverter()
class _$_AssignedReviewer implements _AssignedReviewer {
  const _$_AssignedReviewer(
      {this.id,
      @JsonKey(name: 'submission_id') required this.submissionId,
      @JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'review_id') this.reviewId});

  factory _$_AssignedReviewer.fromJson(Map<String, dynamic> json) =>
      _$$_AssignedReviewerFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'submission_id')
  final int submissionId;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'review_id')
  final int? reviewId;

  @override
  String toString() {
    return 'AssignedReviewer(id: $id, submissionId: $submissionId, userId: $userId, reviewId: $reviewId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AssignedReviewer &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.submissionId, submissionId) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.reviewId, reviewId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(submissionId),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(reviewId));

  @JsonKey(ignore: true)
  @override
  _$$_AssignedReviewerCopyWith<_$_AssignedReviewer> get copyWith =>
      __$$_AssignedReviewerCopyWithImpl<_$_AssignedReviewer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AssignedReviewerToJson(
      this,
    );
  }
}

abstract class _AssignedReviewer implements AssignedReviewer {
  const factory _AssignedReviewer(
      {final int? id,
      @JsonKey(name: 'submission_id') required final int submissionId,
      @JsonKey(name: 'user_id') required final int userId,
      @JsonKey(name: 'review_id') final int? reviewId}) = _$_AssignedReviewer;

  factory _AssignedReviewer.fromJson(Map<String, dynamic> json) =
      _$_AssignedReviewer.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'submission_id')
  int get submissionId;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'review_id')
  int? get reviewId;
  @override
  @JsonKey(ignore: true)
  _$$_AssignedReviewerCopyWith<_$_AssignedReviewer> get copyWith =>
      throw _privateConstructorUsedError;
}

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hearizons.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Hearizons _$HearizonsFromJson(Map<String, dynamic> json) {
  return _Hearizons.fromJson(json);
}

/// @nodoc
mixin _$Hearizons {
  int? get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'in_review')
  bool get inReview => throw _privateConstructorUsedError;
  int get phase => throw _privateConstructorUsedError;
  bool get closed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HearizonsCopyWith<Hearizons> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HearizonsCopyWith<$Res> {
  factory $HearizonsCopyWith(Hearizons value, $Res Function(Hearizons) then) =
      _$HearizonsCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String name,
      @JsonKey(name: 'in_review') bool inReview,
      int phase,
      bool closed});
}

/// @nodoc
class _$HearizonsCopyWithImpl<$Res> implements $HearizonsCopyWith<$Res> {
  _$HearizonsCopyWithImpl(this._value, this._then);

  final Hearizons _value;
  // ignore: unused_field
  final $Res Function(Hearizons) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? inReview = freezed,
    Object? phase = freezed,
    Object? closed = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      inReview: inReview == freezed
          ? _value.inReview
          : inReview // ignore: cast_nullable_to_non_nullable
              as bool,
      phase: phase == freezed
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as int,
      closed: closed == freezed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_HearizonsCopyWith<$Res> implements $HearizonsCopyWith<$Res> {
  factory _$$_HearizonsCopyWith(
          _$_Hearizons value, $Res Function(_$_Hearizons) then) =
      __$$_HearizonsCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String name,
      @JsonKey(name: 'in_review') bool inReview,
      int phase,
      bool closed});
}

/// @nodoc
class __$$_HearizonsCopyWithImpl<$Res> extends _$HearizonsCopyWithImpl<$Res>
    implements _$$_HearizonsCopyWith<$Res> {
  __$$_HearizonsCopyWithImpl(
      _$_Hearizons _value, $Res Function(_$_Hearizons) _then)
      : super(_value, (v) => _then(v as _$_Hearizons));

  @override
  _$_Hearizons get _value => super._value as _$_Hearizons;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? inReview = freezed,
    Object? phase = freezed,
    Object? closed = freezed,
  }) {
    return _then(_$_Hearizons(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      inReview: inReview == freezed
          ? _value.inReview
          : inReview // ignore: cast_nullable_to_non_nullable
              as bool,
      phase: phase == freezed
          ? _value.phase
          : phase // ignore: cast_nullable_to_non_nullable
              as int,
      closed: closed == freezed
          ? _value.closed
          : closed // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@SqliteBoolConverter()
class _$_Hearizons implements _Hearizons {
  const _$_Hearizons(
      {this.id,
      required this.name,
      @JsonKey(name: 'in_review') this.inReview = false,
      this.phase = 0,
      this.closed = false});

  factory _$_Hearizons.fromJson(Map<String, dynamic> json) =>
      _$$_HearizonsFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  @JsonKey(name: 'in_review')
  final bool inReview;
  @override
  @JsonKey()
  final int phase;
  @override
  @JsonKey()
  final bool closed;

  @override
  String toString() {
    return 'Hearizons(id: $id, name: $name, inReview: $inReview, phase: $phase, closed: $closed)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Hearizons &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.inReview, inReview) &&
            const DeepCollectionEquality().equals(other.phase, phase) &&
            const DeepCollectionEquality().equals(other.closed, closed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(inReview),
      const DeepCollectionEquality().hash(phase),
      const DeepCollectionEquality().hash(closed));

  @JsonKey(ignore: true)
  @override
  _$$_HearizonsCopyWith<_$_Hearizons> get copyWith =>
      __$$_HearizonsCopyWithImpl<_$_Hearizons>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_HearizonsToJson(
      this,
    );
  }
}

abstract class _Hearizons implements Hearizons {
  const factory _Hearizons(
      {final int? id,
      required final String name,
      @JsonKey(name: 'in_review') final bool inReview,
      final int phase,
      final bool closed}) = _$_Hearizons;

  factory _Hearizons.fromJson(Map<String, dynamic> json) =
      _$_Hearizons.fromJson;

  @override
  int? get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'in_review')
  bool get inReview;
  @override
  int get phase;
  @override
  bool get closed;
  @override
  @JsonKey(ignore: true)
  _$$_HearizonsCopyWith<_$_Hearizons> get copyWith =>
      throw _privateConstructorUsedError;
}

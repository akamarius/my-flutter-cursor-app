// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Claim _$ClaimFromJson(Map<String, dynamic> json) {
  return _Claim.fromJson(json);
}

/// @nodoc
mixin _$Claim {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  ClaimStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  List<String> get photoUrls => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get resolvedAt => throw _privateConstructorUsedError;

  /// Serializes this Claim to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClaimCopyWith<Claim> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimCopyWith<$Res> {
  factory $ClaimCopyWith(Claim value, $Res Function(Claim) then) =
      _$ClaimCopyWithImpl<$Res, Claim>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String description,
      ClaimStatus status,
      DateTime createdAt,
      double latitude,
      double longitude,
      List<String> photoUrls,
      String? notes,
      DateTime? resolvedAt});
}

/// @nodoc
class _$ClaimCopyWithImpl<$Res, $Val extends Claim>
    implements $ClaimCopyWith<$Res> {
  _$ClaimCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? description = null,
    Object? status = null,
    Object? createdAt = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? photoUrls = null,
    Object? notes = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ClaimStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrls: null == photoUrls
          ? _value.photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClaimImplCopyWith<$Res> implements $ClaimCopyWith<$Res> {
  factory _$$ClaimImplCopyWith(
          _$ClaimImpl value, $Res Function(_$ClaimImpl) then) =
      __$$ClaimImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String description,
      ClaimStatus status,
      DateTime createdAt,
      double latitude,
      double longitude,
      List<String> photoUrls,
      String? notes,
      DateTime? resolvedAt});
}

/// @nodoc
class __$$ClaimImplCopyWithImpl<$Res>
    extends _$ClaimCopyWithImpl<$Res, _$ClaimImpl>
    implements _$$ClaimImplCopyWith<$Res> {
  __$$ClaimImplCopyWithImpl(
      _$ClaimImpl _value, $Res Function(_$ClaimImpl) _then)
      : super(_value, _then);

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? description = null,
    Object? status = null,
    Object? createdAt = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? photoUrls = null,
    Object? notes = freezed,
    Object? resolvedAt = freezed,
  }) {
    return _then(_$ClaimImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ClaimStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrls: null == photoUrls
          ? _value._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedAt: freezed == resolvedAt
          ? _value.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClaimImpl implements _Claim {
  const _$ClaimImpl(
      {required this.id,
      required this.userId,
      required this.description,
      required this.status,
      required this.createdAt,
      required this.latitude,
      required this.longitude,
      required final List<String> photoUrls,
      this.notes,
      this.resolvedAt})
      : _photoUrls = photoUrls;

  factory _$ClaimImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClaimImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String description;
  @override
  final ClaimStatus status;
  @override
  final DateTime createdAt;
  @override
  final double latitude;
  @override
  final double longitude;
  final List<String> _photoUrls;
  @override
  List<String> get photoUrls {
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photoUrls);
  }

  @override
  final String? notes;
  @override
  final DateTime? resolvedAt;

  @override
  String toString() {
    return 'Claim(id: $id, userId: $userId, description: $description, status: $status, createdAt: $createdAt, latitude: $latitude, longitude: $longitude, photoUrls: $photoUrls, notes: $notes, resolvedAt: $resolvedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.resolvedAt, resolvedAt) ||
                other.resolvedAt == resolvedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      description,
      status,
      createdAt,
      latitude,
      longitude,
      const DeepCollectionEquality().hash(_photoUrls),
      notes,
      resolvedAt);

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimImplCopyWith<_$ClaimImpl> get copyWith =>
      __$$ClaimImplCopyWithImpl<_$ClaimImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClaimImplToJson(
      this,
    );
  }
}

abstract class _Claim implements Claim {
  const factory _Claim(
      {required final String id,
      required final String userId,
      required final String description,
      required final ClaimStatus status,
      required final DateTime createdAt,
      required final double latitude,
      required final double longitude,
      required final List<String> photoUrls,
      final String? notes,
      final DateTime? resolvedAt}) = _$ClaimImpl;

  factory _Claim.fromJson(Map<String, dynamic> json) = _$ClaimImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get description;
  @override
  ClaimStatus get status;
  @override
  DateTime get createdAt;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  List<String> get photoUrls;
  @override
  String? get notes;
  @override
  DateTime? get resolvedAt;

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClaimImplCopyWith<_$ClaimImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClaimRequest _$ClaimRequestFromJson(Map<String, dynamic> json) {
  return _ClaimRequest.fromJson(json);
}

/// @nodoc
mixin _$ClaimRequest {
  String get description => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  List<String> get photoUrls => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this ClaimRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClaimRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClaimRequestCopyWith<ClaimRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimRequestCopyWith<$Res> {
  factory $ClaimRequestCopyWith(
          ClaimRequest value, $Res Function(ClaimRequest) then) =
      _$ClaimRequestCopyWithImpl<$Res, ClaimRequest>;
  @useResult
  $Res call(
      {String description,
      double latitude,
      double longitude,
      List<String> photoUrls,
      String? notes});
}

/// @nodoc
class _$ClaimRequestCopyWithImpl<$Res, $Val extends ClaimRequest>
    implements $ClaimRequestCopyWith<$Res> {
  _$ClaimRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClaimRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? photoUrls = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrls: null == photoUrls
          ? _value.photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClaimRequestImplCopyWith<$Res>
    implements $ClaimRequestCopyWith<$Res> {
  factory _$$ClaimRequestImplCopyWith(
          _$ClaimRequestImpl value, $Res Function(_$ClaimRequestImpl) then) =
      __$$ClaimRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      double latitude,
      double longitude,
      List<String> photoUrls,
      String? notes});
}

/// @nodoc
class __$$ClaimRequestImplCopyWithImpl<$Res>
    extends _$ClaimRequestCopyWithImpl<$Res, _$ClaimRequestImpl>
    implements _$$ClaimRequestImplCopyWith<$Res> {
  __$$ClaimRequestImplCopyWithImpl(
      _$ClaimRequestImpl _value, $Res Function(_$ClaimRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClaimRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? photoUrls = null,
    Object? notes = freezed,
  }) {
    return _then(_$ClaimRequestImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrls: null == photoUrls
          ? _value._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClaimRequestImpl implements _ClaimRequest {
  const _$ClaimRequestImpl(
      {required this.description,
      required this.latitude,
      required this.longitude,
      required final List<String> photoUrls,
      this.notes})
      : _photoUrls = photoUrls;

  factory _$ClaimRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClaimRequestImplFromJson(json);

  @override
  final String description;
  @override
  final double latitude;
  @override
  final double longitude;
  final List<String> _photoUrls;
  @override
  List<String> get photoUrls {
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_photoUrls);
  }

  @override
  final String? notes;

  @override
  String toString() {
    return 'ClaimRequest(description: $description, latitude: $latitude, longitude: $longitude, photoUrls: $photoUrls, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimRequestImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, latitude, longitude,
      const DeepCollectionEquality().hash(_photoUrls), notes);

  /// Create a copy of ClaimRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimRequestImplCopyWith<_$ClaimRequestImpl> get copyWith =>
      __$$ClaimRequestImplCopyWithImpl<_$ClaimRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClaimRequestImplToJson(
      this,
    );
  }
}

abstract class _ClaimRequest implements ClaimRequest {
  const factory _ClaimRequest(
      {required final String description,
      required final double latitude,
      required final double longitude,
      required final List<String> photoUrls,
      final String? notes}) = _$ClaimRequestImpl;

  factory _ClaimRequest.fromJson(Map<String, dynamic> json) =
      _$ClaimRequestImpl.fromJson;

  @override
  String get description;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  List<String> get photoUrls;
  @override
  String? get notes;

  /// Create a copy of ClaimRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClaimRequestImplCopyWith<_$ClaimRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

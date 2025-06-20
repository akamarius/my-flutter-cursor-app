// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Claim {
  String get id;
  String get userId;
  String get description;
  ClaimStatus get status;
  DateTime get createdAt;
  double get latitude;
  double get longitude;
  List<String> get photoUrls;
  String? get notes;
  DateTime? get resolvedAt;

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClaimCopyWith<Claim> get copyWith =>
      _$ClaimCopyWithImpl<Claim>(this as Claim, _$identity);

  /// Serializes this Claim to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Claim &&
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
            const DeepCollectionEquality().equals(other.photoUrls, photoUrls) &&
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
      const DeepCollectionEquality().hash(photoUrls),
      notes,
      resolvedAt);

  @override
  String toString() {
    return 'Claim(id: $id, userId: $userId, description: $description, status: $status, createdAt: $createdAt, latitude: $latitude, longitude: $longitude, photoUrls: $photoUrls, notes: $notes, resolvedAt: $resolvedAt)';
  }
}

/// @nodoc
abstract mixin class $ClaimCopyWith<$Res> {
  factory $ClaimCopyWith(Claim value, $Res Function(Claim) _then) =
      _$ClaimCopyWithImpl;
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
class _$ClaimCopyWithImpl<$Res> implements $ClaimCopyWith<$Res> {
  _$ClaimCopyWithImpl(this._self, this._then);

  final Claim _self;
  final $Res Function(Claim) _then;

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
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ClaimStatus,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrls: null == photoUrls
          ? _self.photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedAt: freezed == resolvedAt
          ? _self.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Claim implements Claim {
  const _Claim(
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
  factory _Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);

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

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClaimCopyWith<_Claim> get copyWith =>
      __$ClaimCopyWithImpl<_Claim>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClaimToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Claim &&
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

  @override
  String toString() {
    return 'Claim(id: $id, userId: $userId, description: $description, status: $status, createdAt: $createdAt, latitude: $latitude, longitude: $longitude, photoUrls: $photoUrls, notes: $notes, resolvedAt: $resolvedAt)';
  }
}

/// @nodoc
abstract mixin class _$ClaimCopyWith<$Res> implements $ClaimCopyWith<$Res> {
  factory _$ClaimCopyWith(_Claim value, $Res Function(_Claim) _then) =
      __$ClaimCopyWithImpl;
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
class __$ClaimCopyWithImpl<$Res> implements _$ClaimCopyWith<$Res> {
  __$ClaimCopyWithImpl(this._self, this._then);

  final _Claim _self;
  final $Res Function(_Claim) _then;

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
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
    return _then(_Claim(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as ClaimStatus,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrls: null == photoUrls
          ? _self._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedAt: freezed == resolvedAt
          ? _self.resolvedAt
          : resolvedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$ClaimRequest {
  String get description;
  double get latitude;
  double get longitude;
  List<String> get photoUrls;
  String? get notes;

  /// Create a copy of ClaimRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ClaimRequestCopyWith<ClaimRequest> get copyWith =>
      _$ClaimRequestCopyWithImpl<ClaimRequest>(
          this as ClaimRequest, _$identity);

  /// Serializes this ClaimRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ClaimRequest &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality().equals(other.photoUrls, photoUrls) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, description, latitude, longitude,
      const DeepCollectionEquality().hash(photoUrls), notes);

  @override
  String toString() {
    return 'ClaimRequest(description: $description, latitude: $latitude, longitude: $longitude, photoUrls: $photoUrls, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $ClaimRequestCopyWith<$Res> {
  factory $ClaimRequestCopyWith(
          ClaimRequest value, $Res Function(ClaimRequest) _then) =
      _$ClaimRequestCopyWithImpl;
  @useResult
  $Res call(
      {String description,
      double latitude,
      double longitude,
      List<String> photoUrls,
      String? notes});
}

/// @nodoc
class _$ClaimRequestCopyWithImpl<$Res> implements $ClaimRequestCopyWith<$Res> {
  _$ClaimRequestCopyWithImpl(this._self, this._then);

  final ClaimRequest _self;
  final $Res Function(ClaimRequest) _then;

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
    return _then(_self.copyWith(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrls: null == photoUrls
          ? _self.photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ClaimRequest implements ClaimRequest {
  const _ClaimRequest(
      {required this.description,
      required this.latitude,
      required this.longitude,
      required final List<String> photoUrls,
      this.notes})
      : _photoUrls = photoUrls;
  factory _ClaimRequest.fromJson(Map<String, dynamic> json) =>
      _$ClaimRequestFromJson(json);

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

  /// Create a copy of ClaimRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ClaimRequestCopyWith<_ClaimRequest> get copyWith =>
      __$ClaimRequestCopyWithImpl<_ClaimRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ClaimRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ClaimRequest &&
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

  @override
  String toString() {
    return 'ClaimRequest(description: $description, latitude: $latitude, longitude: $longitude, photoUrls: $photoUrls, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$ClaimRequestCopyWith<$Res>
    implements $ClaimRequestCopyWith<$Res> {
  factory _$ClaimRequestCopyWith(
          _ClaimRequest value, $Res Function(_ClaimRequest) _then) =
      __$ClaimRequestCopyWithImpl;
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
class __$ClaimRequestCopyWithImpl<$Res>
    implements _$ClaimRequestCopyWith<$Res> {
  __$ClaimRequestCopyWithImpl(this._self, this._then);

  final _ClaimRequest _self;
  final $Res Function(_ClaimRequest) _then;

  /// Create a copy of ClaimRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? description = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? photoUrls = null,
    Object? notes = freezed,
  }) {
    return _then(_ClaimRequest(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      photoUrls: null == photoUrls
          ? _self._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

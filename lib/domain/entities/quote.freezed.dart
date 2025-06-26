// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Quote {
  String get id;
  String get userId;
  InsuranceType get insuranceType;
  Map<String, dynamic> get requestData;
  DateTime get createdAt;
  QuoteStatus get status;
  String? get assignedAgent;
  double? get estimatedAmount;
  Map<String, dynamic>? get responseData;
  DateTime? get updatedAt;
  String? get notes;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuoteCopyWith<Quote> get copyWith =>
      _$QuoteCopyWithImpl<Quote>(this as Quote, _$identity);

  /// Serializes this Quote to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Quote &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.insuranceType, insuranceType) ||
                other.insuranceType == insuranceType) &&
            const DeepCollectionEquality()
                .equals(other.requestData, requestData) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.assignedAgent, assignedAgent) ||
                other.assignedAgent == assignedAgent) &&
            (identical(other.estimatedAmount, estimatedAmount) ||
                other.estimatedAmount == estimatedAmount) &&
            const DeepCollectionEquality()
                .equals(other.responseData, responseData) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      insuranceType,
      const DeepCollectionEquality().hash(requestData),
      createdAt,
      status,
      assignedAgent,
      estimatedAmount,
      const DeepCollectionEquality().hash(responseData),
      updatedAt,
      notes);

  @override
  String toString() {
    return 'Quote(id: $id, userId: $userId, insuranceType: $insuranceType, requestData: $requestData, createdAt: $createdAt, status: $status, assignedAgent: $assignedAgent, estimatedAmount: $estimatedAmount, responseData: $responseData, updatedAt: $updatedAt, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $QuoteCopyWith<$Res> {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) _then) =
      _$QuoteCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String userId,
      InsuranceType insuranceType,
      Map<String, dynamic> requestData,
      DateTime createdAt,
      QuoteStatus status,
      String? assignedAgent,
      double? estimatedAmount,
      Map<String, dynamic>? responseData,
      DateTime? updatedAt,
      String? notes});
}

/// @nodoc
class _$QuoteCopyWithImpl<$Res> implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._self, this._then);

  final Quote _self;
  final $Res Function(Quote) _then;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? insuranceType = null,
    Object? requestData = null,
    Object? createdAt = null,
    Object? status = null,
    Object? assignedAgent = freezed,
    Object? estimatedAmount = freezed,
    Object? responseData = freezed,
    Object? updatedAt = freezed,
    Object? notes = freezed,
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
      insuranceType: null == insuranceType
          ? _self.insuranceType
          : insuranceType // ignore: cast_nullable_to_non_nullable
              as InsuranceType,
      requestData: null == requestData
          ? _self.requestData
          : requestData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as QuoteStatus,
      assignedAgent: freezed == assignedAgent
          ? _self.assignedAgent
          : assignedAgent // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedAmount: freezed == estimatedAmount
          ? _self.estimatedAmount
          : estimatedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      responseData: freezed == responseData
          ? _self.responseData
          : responseData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Quote implements Quote {
  const _Quote(
      {required this.id,
      required this.userId,
      required this.insuranceType,
      required final Map<String, dynamic> requestData,
      required this.createdAt,
      required this.status,
      this.assignedAgent,
      this.estimatedAmount,
      final Map<String, dynamic>? responseData,
      this.updatedAt,
      this.notes})
      : _requestData = requestData,
        _responseData = responseData;
  factory _Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final InsuranceType insuranceType;
  final Map<String, dynamic> _requestData;
  @override
  Map<String, dynamic> get requestData {
    if (_requestData is EqualUnmodifiableMapView) return _requestData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_requestData);
  }

  @override
  final DateTime createdAt;
  @override
  final QuoteStatus status;
  @override
  final String? assignedAgent;
  @override
  final double? estimatedAmount;
  final Map<String, dynamic>? _responseData;
  @override
  Map<String, dynamic>? get responseData {
    final value = _responseData;
    if (value == null) return null;
    if (_responseData is EqualUnmodifiableMapView) return _responseData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? updatedAt;
  @override
  final String? notes;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuoteCopyWith<_Quote> get copyWith =>
      __$QuoteCopyWithImpl<_Quote>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuoteToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Quote &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.insuranceType, insuranceType) ||
                other.insuranceType == insuranceType) &&
            const DeepCollectionEquality()
                .equals(other._requestData, _requestData) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.assignedAgent, assignedAgent) ||
                other.assignedAgent == assignedAgent) &&
            (identical(other.estimatedAmount, estimatedAmount) ||
                other.estimatedAmount == estimatedAmount) &&
            const DeepCollectionEquality()
                .equals(other._responseData, _responseData) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      insuranceType,
      const DeepCollectionEquality().hash(_requestData),
      createdAt,
      status,
      assignedAgent,
      estimatedAmount,
      const DeepCollectionEquality().hash(_responseData),
      updatedAt,
      notes);

  @override
  String toString() {
    return 'Quote(id: $id, userId: $userId, insuranceType: $insuranceType, requestData: $requestData, createdAt: $createdAt, status: $status, assignedAgent: $assignedAgent, estimatedAmount: $estimatedAmount, responseData: $responseData, updatedAt: $updatedAt, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$QuoteCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$QuoteCopyWith(_Quote value, $Res Function(_Quote) _then) =
      __$QuoteCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      InsuranceType insuranceType,
      Map<String, dynamic> requestData,
      DateTime createdAt,
      QuoteStatus status,
      String? assignedAgent,
      double? estimatedAmount,
      Map<String, dynamic>? responseData,
      DateTime? updatedAt,
      String? notes});
}

/// @nodoc
class __$QuoteCopyWithImpl<$Res> implements _$QuoteCopyWith<$Res> {
  __$QuoteCopyWithImpl(this._self, this._then);

  final _Quote _self;
  final $Res Function(_Quote) _then;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? insuranceType = null,
    Object? requestData = null,
    Object? createdAt = null,
    Object? status = null,
    Object? assignedAgent = freezed,
    Object? estimatedAmount = freezed,
    Object? responseData = freezed,
    Object? updatedAt = freezed,
    Object? notes = freezed,
  }) {
    return _then(_Quote(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      insuranceType: null == insuranceType
          ? _self.insuranceType
          : insuranceType // ignore: cast_nullable_to_non_nullable
              as InsuranceType,
      requestData: null == requestData
          ? _self._requestData
          : requestData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as QuoteStatus,
      assignedAgent: freezed == assignedAgent
          ? _self.assignedAgent
          : assignedAgent // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedAmount: freezed == estimatedAmount
          ? _self.estimatedAmount
          : estimatedAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      responseData: freezed == responseData
          ? _self._responseData
          : responseData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$QuoteRequest {
  String get userId;
  InsuranceType get insuranceType;
  Map<String, dynamic> get data;
  String? get notes;

  /// Create a copy of QuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuoteRequestCopyWith<QuoteRequest> get copyWith =>
      _$QuoteRequestCopyWithImpl<QuoteRequest>(
          this as QuoteRequest, _$identity);

  /// Serializes this QuoteRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuoteRequest &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.insuranceType, insuranceType) ||
                other.insuranceType == insuranceType) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, insuranceType,
      const DeepCollectionEquality().hash(data), notes);

  @override
  String toString() {
    return 'QuoteRequest(userId: $userId, insuranceType: $insuranceType, data: $data, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $QuoteRequestCopyWith<$Res> {
  factory $QuoteRequestCopyWith(
          QuoteRequest value, $Res Function(QuoteRequest) _then) =
      _$QuoteRequestCopyWithImpl;
  @useResult
  $Res call(
      {String userId,
      InsuranceType insuranceType,
      Map<String, dynamic> data,
      String? notes});
}

/// @nodoc
class _$QuoteRequestCopyWithImpl<$Res> implements $QuoteRequestCopyWith<$Res> {
  _$QuoteRequestCopyWithImpl(this._self, this._then);

  final QuoteRequest _self;
  final $Res Function(QuoteRequest) _then;

  /// Create a copy of QuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? insuranceType = null,
    Object? data = null,
    Object? notes = freezed,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      insuranceType: null == insuranceType
          ? _self.insuranceType
          : insuranceType // ignore: cast_nullable_to_non_nullable
              as InsuranceType,
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _QuoteRequest implements QuoteRequest {
  const _QuoteRequest(
      {required this.userId,
      required this.insuranceType,
      required final Map<String, dynamic> data,
      this.notes})
      : _data = data;
  factory _QuoteRequest.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestFromJson(json);

  @override
  final String userId;
  @override
  final InsuranceType insuranceType;
  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  final String? notes;

  /// Create a copy of QuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuoteRequestCopyWith<_QuoteRequest> get copyWith =>
      __$QuoteRequestCopyWithImpl<_QuoteRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuoteRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuoteRequest &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.insuranceType, insuranceType) ||
                other.insuranceType == insuranceType) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, insuranceType,
      const DeepCollectionEquality().hash(_data), notes);

  @override
  String toString() {
    return 'QuoteRequest(userId: $userId, insuranceType: $insuranceType, data: $data, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class _$QuoteRequestCopyWith<$Res>
    implements $QuoteRequestCopyWith<$Res> {
  factory _$QuoteRequestCopyWith(
          _QuoteRequest value, $Res Function(_QuoteRequest) _then) =
      __$QuoteRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String userId,
      InsuranceType insuranceType,
      Map<String, dynamic> data,
      String? notes});
}

/// @nodoc
class __$QuoteRequestCopyWithImpl<$Res>
    implements _$QuoteRequestCopyWith<$Res> {
  __$QuoteRequestCopyWithImpl(this._self, this._then);

  final _QuoteRequest _self;
  final $Res Function(_QuoteRequest) _then;

  /// Create a copy of QuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? insuranceType = null,
    Object? data = null,
    Object? notes = freezed,
  }) {
    return _then(_QuoteRequest(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      insuranceType: null == insuranceType
          ? _self.insuranceType
          : insuranceType // ignore: cast_nullable_to_non_nullable
              as InsuranceType,
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

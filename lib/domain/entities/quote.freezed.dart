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
  String get brand;
  String get model;
  int get year;
  bool get hasAccidents;
  double get amount;
  DateTime get createdAt;
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
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.hasAccidents, hasAccidents) ||
                other.hasAccidents == hasAccidents) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, brand, model, year,
      hasAccidents, amount, createdAt, notes);

  @override
  String toString() {
    return 'Quote(id: $id, userId: $userId, brand: $brand, model: $model, year: $year, hasAccidents: $hasAccidents, amount: $amount, createdAt: $createdAt, notes: $notes)';
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
      String brand,
      String model,
      int year,
      bool hasAccidents,
      double amount,
      DateTime createdAt,
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
    Object? brand = null,
    Object? model = null,
    Object? year = null,
    Object? hasAccidents = null,
    Object? amount = null,
    Object? createdAt = null,
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
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      hasAccidents: null == hasAccidents
          ? _self.hasAccidents
          : hasAccidents // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
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
      required this.brand,
      required this.model,
      required this.year,
      required this.hasAccidents,
      required this.amount,
      required this.createdAt,
      this.notes});
  factory _Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String brand;
  @override
  final String model;
  @override
  final int year;
  @override
  final bool hasAccidents;
  @override
  final double amount;
  @override
  final DateTime createdAt;
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
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.hasAccidents, hasAccidents) ||
                other.hasAccidents == hasAccidents) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, brand, model, year,
      hasAccidents, amount, createdAt, notes);

  @override
  String toString() {
    return 'Quote(id: $id, userId: $userId, brand: $brand, model: $model, year: $year, hasAccidents: $hasAccidents, amount: $amount, createdAt: $createdAt, notes: $notes)';
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
      String brand,
      String model,
      int year,
      bool hasAccidents,
      double amount,
      DateTime createdAt,
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
    Object? brand = null,
    Object? model = null,
    Object? year = null,
    Object? hasAccidents = null,
    Object? amount = null,
    Object? createdAt = null,
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
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      hasAccidents: null == hasAccidents
          ? _self.hasAccidents
          : hasAccidents // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$QuoteRequest {
  String get brand;
  String get model;
  int get year;
  bool get hasAccidents;
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
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.hasAccidents, hasAccidents) ||
                other.hasAccidents == hasAccidents) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, brand, model, year, hasAccidents, notes);

  @override
  String toString() {
    return 'QuoteRequest(brand: $brand, model: $model, year: $year, hasAccidents: $hasAccidents, notes: $notes)';
  }
}

/// @nodoc
abstract mixin class $QuoteRequestCopyWith<$Res> {
  factory $QuoteRequestCopyWith(
          QuoteRequest value, $Res Function(QuoteRequest) _then) =
      _$QuoteRequestCopyWithImpl;
  @useResult
  $Res call(
      {String brand, String model, int year, bool hasAccidents, String? notes});
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
    Object? brand = null,
    Object? model = null,
    Object? year = null,
    Object? hasAccidents = null,
    Object? notes = freezed,
  }) {
    return _then(_self.copyWith(
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      hasAccidents: null == hasAccidents
          ? _self.hasAccidents
          : hasAccidents // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {required this.brand,
      required this.model,
      required this.year,
      required this.hasAccidents,
      this.notes});
  factory _QuoteRequest.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestFromJson(json);

  @override
  final String brand;
  @override
  final String model;
  @override
  final int year;
  @override
  final bool hasAccidents;
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
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.hasAccidents, hasAccidents) ||
                other.hasAccidents == hasAccidents) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, brand, model, year, hasAccidents, notes);

  @override
  String toString() {
    return 'QuoteRequest(brand: $brand, model: $model, year: $year, hasAccidents: $hasAccidents, notes: $notes)';
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
      {String brand, String model, int year, bool hasAccidents, String? notes});
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
    Object? brand = null,
    Object? model = null,
    Object? year = null,
    Object? hasAccidents = null,
    Object? notes = freezed,
  }) {
    return _then(_QuoteRequest(
      brand: null == brand
          ? _self.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _self.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      hasAccidents: null == hasAccidents
          ? _self.hasAccidents
          : hasAccidents // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on

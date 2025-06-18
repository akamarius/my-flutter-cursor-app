// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Quote _$QuoteFromJson(Map<String, dynamic> json) {
  return _Quote.fromJson(json);
}

/// @nodoc
mixin _$Quote {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  bool get hasAccidents => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this Quote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteCopyWith<Quote> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteCopyWith<$Res> {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) then) =
      _$QuoteCopyWithImpl<$Res, Quote>;
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
class _$QuoteCopyWithImpl<$Res, $Val extends Quote>
    implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      hasAccidents: null == hasAccidents
          ? _value.hasAccidents
          : hasAccidents // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuoteImplCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$$QuoteImplCopyWith(
          _$QuoteImpl value, $Res Function(_$QuoteImpl) then) =
      __$$QuoteImplCopyWithImpl<$Res>;
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
class __$$QuoteImplCopyWithImpl<$Res>
    extends _$QuoteCopyWithImpl<$Res, _$QuoteImpl>
    implements _$$QuoteImplCopyWith<$Res> {
  __$$QuoteImplCopyWithImpl(
      _$QuoteImpl _value, $Res Function(_$QuoteImpl) _then)
      : super(_value, _then);

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
    return _then(_$QuoteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      hasAccidents: null == hasAccidents
          ? _value.hasAccidents
          : hasAccidents // ignore: cast_nullable_to_non_nullable
              as bool,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteImpl implements _Quote {
  const _$QuoteImpl(
      {required this.id,
      required this.userId,
      required this.brand,
      required this.model,
      required this.year,
      required this.hasAccidents,
      required this.amount,
      required this.createdAt,
      this.notes});

  factory _$QuoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteImplFromJson(json);

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

  @override
  String toString() {
    return 'Quote(id: $id, userId: $userId, brand: $brand, model: $model, year: $year, hasAccidents: $hasAccidents, amount: $amount, createdAt: $createdAt, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteImpl &&
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

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteImplCopyWith<_$QuoteImpl> get copyWith =>
      __$$QuoteImplCopyWithImpl<_$QuoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteImplToJson(
      this,
    );
  }
}

abstract class _Quote implements Quote {
  const factory _Quote(
      {required final String id,
      required final String userId,
      required final String brand,
      required final String model,
      required final int year,
      required final bool hasAccidents,
      required final double amount,
      required final DateTime createdAt,
      final String? notes}) = _$QuoteImpl;

  factory _Quote.fromJson(Map<String, dynamic> json) = _$QuoteImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get brand;
  @override
  String get model;
  @override
  int get year;
  @override
  bool get hasAccidents;
  @override
  double get amount;
  @override
  DateTime get createdAt;
  @override
  String? get notes;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteImplCopyWith<_$QuoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuoteRequest _$QuoteRequestFromJson(Map<String, dynamic> json) {
  return _QuoteRequest.fromJson(json);
}

/// @nodoc
mixin _$QuoteRequest {
  String get brand => throw _privateConstructorUsedError;
  String get model => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  bool get hasAccidents => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this QuoteRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuoteRequestCopyWith<QuoteRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuoteRequestCopyWith<$Res> {
  factory $QuoteRequestCopyWith(
          QuoteRequest value, $Res Function(QuoteRequest) then) =
      _$QuoteRequestCopyWithImpl<$Res, QuoteRequest>;
  @useResult
  $Res call(
      {String brand, String model, int year, bool hasAccidents, String? notes});
}

/// @nodoc
class _$QuoteRequestCopyWithImpl<$Res, $Val extends QuoteRequest>
    implements $QuoteRequestCopyWith<$Res> {
  _$QuoteRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      hasAccidents: null == hasAccidents
          ? _value.hasAccidents
          : hasAccidents // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuoteRequestImplCopyWith<$Res>
    implements $QuoteRequestCopyWith<$Res> {
  factory _$$QuoteRequestImplCopyWith(
          _$QuoteRequestImpl value, $Res Function(_$QuoteRequestImpl) then) =
      __$$QuoteRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String brand, String model, int year, bool hasAccidents, String? notes});
}

/// @nodoc
class __$$QuoteRequestImplCopyWithImpl<$Res>
    extends _$QuoteRequestCopyWithImpl<$Res, _$QuoteRequestImpl>
    implements _$$QuoteRequestImplCopyWith<$Res> {
  __$$QuoteRequestImplCopyWithImpl(
      _$QuoteRequestImpl _value, $Res Function(_$QuoteRequestImpl) _then)
      : super(_value, _then);

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
    return _then(_$QuoteRequestImpl(
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      hasAccidents: null == hasAccidents
          ? _value.hasAccidents
          : hasAccidents // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuoteRequestImpl implements _QuoteRequest {
  const _$QuoteRequestImpl(
      {required this.brand,
      required this.model,
      required this.year,
      required this.hasAccidents,
      this.notes});

  factory _$QuoteRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuoteRequestImplFromJson(json);

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

  @override
  String toString() {
    return 'QuoteRequest(brand: $brand, model: $model, year: $year, hasAccidents: $hasAccidents, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuoteRequestImpl &&
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

  /// Create a copy of QuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuoteRequestImplCopyWith<_$QuoteRequestImpl> get copyWith =>
      __$$QuoteRequestImplCopyWithImpl<_$QuoteRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuoteRequestImplToJson(
      this,
    );
  }
}

abstract class _QuoteRequest implements QuoteRequest {
  const factory _QuoteRequest(
      {required final String brand,
      required final String model,
      required final int year,
      required final bool hasAccidents,
      final String? notes}) = _$QuoteRequestImpl;

  factory _QuoteRequest.fromJson(Map<String, dynamic> json) =
      _$QuoteRequestImpl.fromJson;

  @override
  String get brand;
  @override
  String get model;
  @override
  int get year;
  @override
  bool get hasAccidents;
  @override
  String? get notes;

  /// Create a copy of QuoteRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuoteRequestImplCopyWith<_$QuoteRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

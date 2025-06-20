import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote.freezed.dart';
part 'quote.g.dart';

@freezed
class Quote with _$Quote {
  const factory Quote({
    required String id,
    required String userId,
    required String brand,
    required String model,
    required int year,
    required bool hasAccidents,
    required double amount,
    required DateTime createdAt,
    String? notes,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  @override
  // TODO: implement amount
  double get amount => throw UnimplementedError();

  @override
  // TODO: implement brand
  String get brand => throw UnimplementedError();

  @override
  // TODO: implement createdAt
  DateTime get createdAt => throw UnimplementedError();

  @override
  // TODO: implement hasAccidents
  bool get hasAccidents => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement model
  String get model => throw UnimplementedError();

  @override
  // TODO: implement notes
  String? get notes => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  // TODO: implement userId
  String get userId => throw UnimplementedError();

  @override
  // TODO: implement year
  int get year => throw UnimplementedError();
}

@freezed
class QuoteRequest with _$QuoteRequest {
  const factory QuoteRequest({
    required String brand,
    required String model,
    required int year,
    required bool hasAccidents,
    String? notes,
  }) = _QuoteRequest;

  factory QuoteRequest.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestFromJson(json);

  @override
  // TODO: implement brand
  String get brand => throw UnimplementedError();

  @override
  // TODO: implement hasAccidents
  bool get hasAccidents => throw UnimplementedError();

  @override
  // TODO: implement model
  String get model => throw UnimplementedError();

  @override
  // TODO: implement notes
  String? get notes => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  // TODO: implement year
  int get year => throw UnimplementedError();
} 
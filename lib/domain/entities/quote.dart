import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote.freezed.dart';
part 'quote.g.dart';

@freezed
abstract class Quote with _$Quote {
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
}

@freezed
abstract class QuoteRequest with _$QuoteRequest {
  const factory QuoteRequest({
    required String brand,
    required String model,
    required int year,
    required bool hasAccidents,
    String? notes,
  }) = _QuoteRequest;

  factory QuoteRequest.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote.freezed.dart';
part 'quote.g.dart';

enum InsuranceType {
  @JsonValue('auto')
  auto,
  @JsonValue('habitation')
  habitation,
  @JsonValue('deces')
  deces,
  @JsonValue('epargne')
  epargne,
  @JsonValue('sante')
  sante,
  @JsonValue('voyage')
  voyage,
}

enum QuoteStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('inProgress')
  inProgress,
  @JsonValue('rejected')
  rejected,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('completed')
  completed,
}

@freezed
abstract class Quote with _$Quote {
  const factory Quote({
    required String id,
    required String userId,
    required InsuranceType insuranceType,
    required Map<String, dynamic> requestData,
    required DateTime createdAt,
    required QuoteStatus status,
    String? assignedAgent,
    double? estimatedAmount,
    Map<String, dynamic>? responseData,
    DateTime? updatedAt,
    String? notes,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}

@freezed
abstract class QuoteRequest with _$QuoteRequest {
  const factory QuoteRequest({
    required String userId,
    required InsuranceType insuranceType,
    required Map<String, dynamic> data,
    String? notes,
  }) = _QuoteRequest;

  factory QuoteRequest.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestFromJson(json);
}

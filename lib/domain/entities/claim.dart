import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim.freezed.dart';
part 'claim.g.dart';

enum ClaimStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('resolved')
  resolved,
  @JsonValue('rejected')
  rejected
}

@freezed
class Claim with _$Claim {
  const factory Claim({
    required String id,
    required String userId,
    required String description,
    required ClaimStatus status,
    required DateTime createdAt,
    required double latitude,
    required double longitude,
    required List<String> photoUrls,
    String? notes,
    DateTime? resolvedAt,
  }) = _Claim;

  factory Claim.fromJson(Map<String, dynamic> json) => _$ClaimFromJson(json);
}

@freezed
class ClaimRequest with _$ClaimRequest {
  const factory ClaimRequest({
    required String description,
    required double latitude,
    required double longitude,
    required List<String> photoUrls,
    String? notes,
  }) = _ClaimRequest;

  factory ClaimRequest.fromJson(Map<String, dynamic> json) =>
      _$ClaimRequestFromJson(json);
} 
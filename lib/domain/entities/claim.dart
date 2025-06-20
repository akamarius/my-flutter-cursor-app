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

  @override
  // TODO: implement createdAt
  DateTime get createdAt => throw UnimplementedError();

  @override
  // TODO: implement description
  String get description => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement latitude
  double get latitude => throw UnimplementedError();

  @override
  // TODO: implement longitude
  double get longitude => throw UnimplementedError();

  @override
  // TODO: implement notes
  String? get notes => throw UnimplementedError();

  @override
  // TODO: implement photoUrls
  List<String> get photoUrls => throw UnimplementedError();

  @override
  // TODO: implement resolvedAt
  DateTime? get resolvedAt => throw UnimplementedError();

  @override
  // TODO: implement status
  ClaimStatus get status => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }

  @override
  // TODO: implement userId
  String get userId => throw UnimplementedError();
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

  @override
  // TODO: implement description
  String get description => throw UnimplementedError();

  @override
  // TODO: implement latitude
  double get latitude => throw UnimplementedError();

  @override
  // TODO: implement longitude
  double get longitude => throw UnimplementedError();

  @override
  // TODO: implement notes
  String? get notes => throw UnimplementedError();

  @override
  // TODO: implement photoUrls
  List<String> get photoUrls => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
} 
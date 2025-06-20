// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Claim _$ClaimFromJson(Map<String, dynamic> json) => _Claim(
      id: json['id'] as String,
      userId: json['userId'] as String,
      description: json['description'] as String,
      status: $enumDecode(_$ClaimStatusEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      photoUrls:
          (json['photoUrls'] as List<dynamic>).map((e) => e as String).toList(),
      notes: json['notes'] as String?,
      resolvedAt: json['resolvedAt'] == null
          ? null
          : DateTime.parse(json['resolvedAt'] as String),
    );

Map<String, dynamic> _$ClaimToJson(_Claim instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'description': instance.description,
      'status': _$ClaimStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'photoUrls': instance.photoUrls,
      'notes': instance.notes,
      'resolvedAt': instance.resolvedAt?.toIso8601String(),
    };

const _$ClaimStatusEnumMap = {
  ClaimStatus.pending: 'pending',
  ClaimStatus.inProgress: 'in_progress',
  ClaimStatus.resolved: 'resolved',
  ClaimStatus.rejected: 'rejected',
};

_ClaimRequest _$ClaimRequestFromJson(Map<String, dynamic> json) =>
    _ClaimRequest(
      description: json['description'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      photoUrls:
          (json['photoUrls'] as List<dynamic>).map((e) => e as String).toList(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$ClaimRequestToJson(_ClaimRequest instance) =>
    <String, dynamic>{
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'photoUrls': instance.photoUrls,
      'notes': instance.notes,
    };

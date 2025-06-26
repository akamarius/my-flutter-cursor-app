// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Quote _$QuoteFromJson(Map<String, dynamic> json) => _Quote(
      id: json['id'] as String,
      userId: json['userId'] as String,
      insuranceType: $enumDecode(_$InsuranceTypeEnumMap, json['insuranceType']),
      requestData: json['requestData'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: $enumDecode(_$QuoteStatusEnumMap, json['status']),
      assignedAgent: json['assignedAgent'] as String?,
      estimatedAmount: (json['estimatedAmount'] as num?)?.toDouble(),
      responseData: json['responseData'] as Map<String, dynamic>?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$QuoteToJson(_Quote instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'insuranceType': _$InsuranceTypeEnumMap[instance.insuranceType]!,
      'requestData': instance.requestData,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': _$QuoteStatusEnumMap[instance.status]!,
      'assignedAgent': instance.assignedAgent,
      'estimatedAmount': instance.estimatedAmount,
      'responseData': instance.responseData,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'notes': instance.notes,
    };

const _$InsuranceTypeEnumMap = {
  InsuranceType.auto: 'auto',
  InsuranceType.habitation: 'habitation',
  InsuranceType.deces: 'deces',
  InsuranceType.epargne: 'epargne',
  InsuranceType.sante: 'sante',
  InsuranceType.voyage: 'voyage',
};

const _$QuoteStatusEnumMap = {
  QuoteStatus.pending: 'pending',
  QuoteStatus.inProgress: 'inProgress',
  QuoteStatus.rejected: 'rejected',
  QuoteStatus.cancelled: 'cancelled',
  QuoteStatus.completed: 'completed',
};

_QuoteRequest _$QuoteRequestFromJson(Map<String, dynamic> json) =>
    _QuoteRequest(
      userId: json['userId'] as String,
      insuranceType: $enumDecode(_$InsuranceTypeEnumMap, json['insuranceType']),
      data: json['data'] as Map<String, dynamic>,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$QuoteRequestToJson(_QuoteRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'insuranceType': _$InsuranceTypeEnumMap[instance.insuranceType]!,
      'data': instance.data,
      'notes': instance.notes,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Quote _$QuoteFromJson(Map<String, dynamic> json) => _Quote(
      id: json['id'] as String,
      userId: json['userId'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      hasAccidents: json['hasAccidents'] as bool,
      amount: (json['amount'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$QuoteToJson(_Quote instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'brand': instance.brand,
      'model': instance.model,
      'year': instance.year,
      'hasAccidents': instance.hasAccidents,
      'amount': instance.amount,
      'createdAt': instance.createdAt.toIso8601String(),
      'notes': instance.notes,
    };

_QuoteRequest _$QuoteRequestFromJson(Map<String, dynamic> json) =>
    _QuoteRequest(
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      hasAccidents: json['hasAccidents'] as bool,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$QuoteRequestToJson(_QuoteRequest instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'model': instance.model,
      'year': instance.year,
      'hasAccidents': instance.hasAccidents,
      'notes': instance.notes,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuoteImpl _$$QuoteImplFromJson(Map<String, dynamic> json) => _$QuoteImpl(
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

Map<String, dynamic> _$$QuoteImplToJson(_$QuoteImpl instance) =>
    <String, dynamic>{
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

_$QuoteRequestImpl _$$QuoteRequestImplFromJson(Map<String, dynamic> json) =>
    _$QuoteRequestImpl(
      brand: json['brand'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      hasAccidents: json['hasAccidents'] as bool,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$QuoteRequestImplToJson(_$QuoteRequestImpl instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'model': instance.model,
      'year': instance.year,
      'hasAccidents': instance.hasAccidents,
      'notes': instance.notes,
    };

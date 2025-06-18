// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Office _$OfficeFromJson(Map<String, dynamic> json) => Office(
      id: json['id'] as String,
      name: json['name'] as String,
      services:
          (json['services'] as List<dynamic>).map((e) => e as String).toList(),
      address: json['address'] as String,
      location: LatLng.fromJson(json['location'] as Map<String, dynamic>),
      phone: json['phone'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
      isOpen: json['isOpen'] as bool,
    );

Map<String, dynamic> _$OfficeToJson(Office instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'services': instance.services,
      'address': instance.address,
      'location': instance.location,
      'phone': instance.phone,
      'email': instance.email,
      'description': instance.description,
      'isOpen': instance.isOpen,
    };

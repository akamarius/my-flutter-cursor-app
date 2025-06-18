import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'office.g.dart';

@JsonSerializable()
class Office {
  final String id;
  final String name;
  final List<String> services;
  final String address;
  final LatLng location;
  final String phone;
  final String email;
  final String description;
  final bool isOpen;

  const Office({
    required this.id,
    required this.name,
    required this.services,
    required this.address,
    required this.location,
    required this.phone,
    required this.email,
    required this.description,
    required this.isOpen,
  });

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
  Map<String, dynamic> toJson() => _$OfficeToJson(this);
} 
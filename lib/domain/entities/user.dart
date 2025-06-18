import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum UserRole {
  @JsonValue('prospect')
  prospect,
  @JsonValue('assure')
  assure
}

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required UserRole role,
    String? phoneNumber,
    String? displayName,
    String? photoUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
} 
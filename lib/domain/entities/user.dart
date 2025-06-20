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

  @override
  // TODO: implement displayName
  String? get displayName => throw UnimplementedError();

  @override
  // TODO: implement email
  String get email => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement phoneNumber
  String? get phoneNumber => throw UnimplementedError();

  @override
  // TODO: implement photoUrl
  String? get photoUrl => throw UnimplementedError();

  @override
  // TODO: implement role
  UserRole get role => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
} 
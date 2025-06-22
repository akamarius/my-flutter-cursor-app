import 'package:my_flutter_app/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> signInWithPhoneNumber(String phoneNumber);
  Future<User> signUp(String firstName, String lastName, String email,
      String password, UserRole role);
  Future<void> signOut();
  Future<User?> getCurrentUser();
  Future<void> updateUserProfile({
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  });
  Future<void> updateUserProfileWithNames({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
  });
}

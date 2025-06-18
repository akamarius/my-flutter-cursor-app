import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_flutter_app/domain/entities/user.dart';
import 'package:my_flutter_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final FlutterSecureStorage _secureStorage;

  AuthRepositoryImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    FlutterSecureStorage? secureStorage,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _secureStorage = secureStorage ?? const FlutterSecureStorage();

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        throw Exception('User document not found');
      }

      final userData = userDoc.data()!;
      final user = User(
        id: userCredential.user!.uid,
        email: userCredential.user!.email!,
        role: UserRole.values.firstWhere(
          (role) => role.toString().split('.').last == userData['role'],
        ),
        phoneNumber: userCredential.user!.phoneNumber,
        displayName: userCredential.user!.displayName,
        photoUrl: userCredential.user!.photoURL,
      );

      await _secureStorage.write(key: 'user_id', value: user.id);
      await _secureStorage.write(key: 'user_role', value: user.role.toString());

      return user;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  @override
  Future<User> signInWithPhoneNumber(String phoneNumber) async {
    try {
      // TODO: Implement phone authentication
      throw UnimplementedError('Phone authentication not implemented yet');
    } catch (e) {
      throw Exception('Failed to sign in with phone: $e');
    }
  }

  @override
  Future<User> signUp(String email, String password, UserRole role) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = User(
        id: userCredential.user!.uid,
        email: email,
        role: role,
      );

      await _firestore.collection('users').doc(user.id).set({
        'email': email,
        'role': role.toString().split('.').last,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await _secureStorage.write(key: 'user_id', value: user.id);
      await _secureStorage.write(key: 'user_role', value: user.role.toString());

      return user;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _secureStorage.deleteAll();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) return null;

      final userDoc = await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .get();

      if (!userDoc.exists) return null;

      final userData = userDoc.data()!;
      return User(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        role: UserRole.values.firstWhere(
          (role) => role.toString().split('.').last == userData['role'],
        ),
        phoneNumber: firebaseUser.phoneNumber,
        displayName: firebaseUser.displayName,
        photoUrl: firebaseUser.photoURL,
      );
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  @override
  Future<void> updateUserProfile({
    String? displayName,
    String? photoUrl,
    String? phoneNumber,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw Exception('No user logged in');

      await user.updateDisplayName(displayName);
      await user.updatePhotoURL(photoUrl);
      if (phoneNumber != null) {
        // TODO: Implement phone number update
      }

      await _firestore.collection('users').doc(user.uid).update({
        if (displayName != null) 'displayName': displayName,
        if (photoUrl != null) 'photoUrl': photoUrl,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
      });
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }
} 
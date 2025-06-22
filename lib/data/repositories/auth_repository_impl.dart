import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/domain/entities/claim.dart';
import 'package:my_flutter_app/domain/repositories/claim_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_flutter_app/domain/entities/user.dart';
import 'package:my_flutter_app/domain/repositories/auth_repository.dart';

class ClaimRepositoryImpl implements ClaimRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ClaimRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  @override
  Future<Claim> createClaim(ClaimRequest request, String userId) async {
    try {
      final docRef = _firestore.collection('claims').doc();
      final claim = Claim(
        id: docRef.id,
        userId: userId,
        description: request.description,
        status: ClaimStatus.pending,
        createdAt: DateTime.now(),
        latitude: request.latitude,
        longitude: request.longitude,
        photoUrls: request.photoUrls ?? [],
        notes: request.notes ?? '',
      );

      await docRef.set(claim.toJson());
      return claim;
    } on FirebaseException catch (e) {
      throw Exception('Failed to create claim: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create claim: ${e.toString()}');
    }
  }

  @override
  Future<List<Claim>> getUserClaims(String userId) async {
    try {
      if (userId.isEmpty) {
        throw ArgumentError('User ID cannot be empty');
      }

      final snapshot = await _firestore
          .collection('claims')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Claim.fromJson(doc.data()..['id'] = doc.id))
          .toList();
    } on FirebaseException catch (e) {
      throw Exception('Failed to get user claims: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get user claims: ${e.toString()}');
    }
  }

  @override
  Future<Claim> getClaimById(String claimId) async {
    try {
      if (claimId.isEmpty) {
        throw ArgumentError('Claim ID cannot be empty');
      }

      final doc = await _firestore.collection('claims').doc(claimId).get();

      if (!doc.exists) {
        throw Exception('Claim not found');
      }

      return Claim.fromJson(doc.data()!..['id'] = doc.id);
    } on FirebaseException catch (e) {
      throw Exception('Failed to get claim: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get claim: ${e.toString()}');
    }
  }

  @override
  Future<void> updateClaimStatus(String claimId, ClaimStatus status) async {
    try {
      if (claimId.isEmpty) {
        throw ArgumentError('Claim ID cannot be empty');
      }

      final updates = {
        'status': status.toString().split('.').last,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (status == ClaimStatus.resolved) {
        updates['resolvedAt'] = FieldValue.serverTimestamp();
      }

      await _firestore.collection('claims').doc(claimId).update(updates);
    } on FirebaseException catch (e) {
      throw Exception('Failed to update claim status: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update claim status: ${e.toString()}');
    }
  }

  @override
  Future<String> uploadClaimPhoto(String claimId, List<int> photoBytes) async {
    try {
      if (claimId.isEmpty) {
        throw ArgumentError('Claim ID cannot be empty');
      }
      if (photoBytes.isEmpty) {
        throw ArgumentError('Photo bytes cannot be empty');
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final ref = _storage.ref().child('claims/$claimId/$timestamp.jpg');

      final uploadTask = ref.putData(
        Uint8List.fromList(photoBytes),
        SettableMetadata(contentType: 'image/jpeg'),
      );

      final snapshot = await uploadTask;
      if (snapshot.bytesTransferred != snapshot.totalBytes) {
        throw Exception('Upload incomplete');
      }

      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw Exception('Failed to upload claim photo: ${e.message}');
    } catch (e) {
      throw Exception('Failed to upload claim photo: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteClaim(String claimId) async {
    try {
      if (claimId.isEmpty) {
        throw ArgumentError('Claim ID cannot be empty');
      }

      await _firestore.collection('claims').doc(claimId).delete();
    } on FirebaseException catch (e) {
      throw Exception('Failed to delete claim: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete claim: ${e.toString()}');
    }
  }
}

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
        firstName: userData['firstName'],
        lastName: userData['lastName'],
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
  Future<User> signUp(String firstName, String lastName, String email,
      String password, UserRole role) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = User(
        id: userCredential.user!.uid,
        email: email,
        role: role,
        firstName: firstName,
        lastName: lastName,
      );

      await _firestore.collection('users').doc(user.id).set({
        'email': email,
        'role': role.toString().split('.').last,
        'firstName': firstName,
        'lastName': lastName,
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

      final userDoc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      if (!userDoc.exists) return null;

      final userData = userDoc.data()!;
      return User(
        id: firebaseUser.uid,
        email: firebaseUser.email!,
        role: UserRole.values.firstWhere(
          (role) => role.toString().split('.').last == userData['role'],
        ),
        firstName: userData['firstName'],
        lastName: userData['lastName'],
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

  @override
  Future<void> updateUserProfileWithNames({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw Exception('No user logged in');

      // Mettre à jour l'email Firebase si fourni
      if (email != null && email != user.email) {
        await user.updateEmail(email);
      }

      // Mettre à jour le displayName avec firstName + lastName
      String? displayName;
      if (firstName != null || lastName != null) {
        displayName = '${firstName ?? ''} ${lastName ?? ''}'.trim();
        await user.updateDisplayName(displayName);
      }

      // Mettre à jour Firestore
      final updates = <String, dynamic>{};
      if (firstName != null) updates['firstName'] = firstName;
      if (lastName != null) updates['lastName'] = lastName;
      if (email != null) updates['email'] = email;
      if (phoneNumber != null) updates['phoneNumber'] = phoneNumber;
      if (displayName != null) updates['displayName'] = displayName;

      await _firestore.collection('users').doc(user.uid).update(updates);
    } catch (e) {
      throw Exception('Failed to update profile with names: $e');
    }
  }
}

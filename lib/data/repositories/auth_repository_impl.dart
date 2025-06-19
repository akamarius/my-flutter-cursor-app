import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_flutter_app/domain/entities/claim.dart';
import 'package:my_flutter_app/domain/repositories/claim_repository.dart';

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

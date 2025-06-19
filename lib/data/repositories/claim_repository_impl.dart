import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
        photoUrls: request.photoUrls,
        notes: request.notes,
      );

      await docRef.set(claim.toJson());
      return claim;
    } catch (e) {
      throw Exception('Failed to create claim: $e');
    }
  }

  @override
  Future<List<Claim>> getUserClaims(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('claims')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => Claim.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to get user claims: $e');
    }
  }

  @override
  Future<Claim> getClaimById(String claimId) async {
    try {
      final doc = await _firestore.collection('claims').doc(claimId).get();
      if (!doc.exists) {
        throw Exception('Claim not found');
      }
      return Claim.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('Failed to get claim: $e');
    }
  }

  @override
  Future<void> updateClaimStatus(String claimId, ClaimStatus status) async {
    try {
      await _firestore.collection('claims').doc(claimId).update({
        'status': status.toString().split('.').last,
        if (status == ClaimStatus.resolved)
          'resolvedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update claim status: $e');
    }
  }

  @override
  Future<String> uploadClaimPhoto(String claimId, List<int> photoBytes) async {
    try {
      final ref = _storage.ref().child(
          'claims/$claimId/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putData(Uint8List.fromList(photoBytes));
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload claim photo: $e');
    }
  }
}

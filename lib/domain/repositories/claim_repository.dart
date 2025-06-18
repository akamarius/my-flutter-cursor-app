import 'package:my_flutter_app/domain/entities/claim.dart';

abstract class ClaimRepository {
  Future<Claim> createClaim(ClaimRequest request);
  Future<List<Claim>> getUserClaims(String userId);
  Future<Claim> getClaimById(String claimId);
  Future<void> updateClaimStatus(String claimId, ClaimStatus status);
  Future<String> uploadClaimPhoto(String claimId, List<int> photoBytes);
} 
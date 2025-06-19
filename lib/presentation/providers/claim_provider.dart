import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/entities/claim.dart';
import 'package:my_flutter_app/domain/repositories/claim_repository.dart';

final claimRepositoryProvider = Provider<ClaimRepository>((ref) {
  throw UnimplementedError('ClaimRepository not initialized');
});

final claimStateProvider =
    StateNotifierProvider<ClaimNotifier, AsyncValue<List<Claim>>>((ref) {
  final repository = ref.watch(claimRepositoryProvider);
  return ClaimNotifier(repository);
});

final claimRequestProvider =
    StateNotifierProvider<ClaimRequestNotifier, AsyncValue<Claim?>>((ref) {
  final repository = ref.watch(claimRepositoryProvider);
  return ClaimRequestNotifier(repository);
});

class ClaimNotifier extends StateNotifier<AsyncValue<List<Claim>>> {
  final ClaimRepository _repository;

  ClaimNotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> loadUserClaims(String userId) async {
    state = const AsyncValue.loading();
    try {
      final claims = await _repository.getUserClaims(userId);
      state = AsyncValue.data(claims);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> updateClaimStatus(String claimId, ClaimStatus status) async {
    try {
      await _repository.updateClaimStatus(claimId, status);
      // Reload claims after status update
      final userId = state.value?.first.userId;
      if (userId != null) {
        await loadUserClaims(userId);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

class ClaimRequestNotifier extends StateNotifier<AsyncValue<Claim?>> {
  final ClaimRepository _repository;

  ClaimRequestNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> createClaim(ClaimRequest request) async {
    state = const AsyncValue.loading();
    try {
      final claim = await _repository.createClaim(
          request, "current_user_id"); // TODO: get user id from auth provider
      state = AsyncValue.data(claim);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<String> uploadPhoto(String claimId, List<int> photoBytes) async {
    try {
      return await _repository.uploadClaimPhoto(claimId, photoBytes);
    } catch (e) {
      throw Exception('Failed to upload photo: $e');
    }
  }
}

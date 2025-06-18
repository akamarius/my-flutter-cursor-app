import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/domain/entities/claim.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';
import 'package:my_flutter_app/presentation/providers/claim_provider.dart';

class ClaimsListScreen extends ConsumerStatefulWidget {
  const ClaimsListScreen({super.key});

  @override
  ConsumerState<ClaimsListScreen> createState() => _ClaimsListScreenState();
}

class _ClaimsListScreenState extends ConsumerState<ClaimsListScreen> {
  @override
  void initState() {
    super.initState();
    _loadClaims();
  }

  Future<void> _loadClaims() async {
    final user = ref.read(authStateProvider).value;
    if (user != null) {
      await ref.read(claimStateProvider.notifier).loadUserClaims(user.id);
    }
  }

  Color _getStatusColor(ClaimStatus status) {
    switch (status) {
      case ClaimStatus.pending:
        return Colors.orange;
      case ClaimStatus.inProgress:
        return Colors.blue;
      case ClaimStatus.resolved:
        return Colors.green;
      case ClaimStatus.rejected:
        return Colors.red;
    }
  }

  String _getStatusText(ClaimStatus status) {
    switch (status) {
      case ClaimStatus.pending:
        return 'En attente';
      case ClaimStatus.inProgress:
        return 'En cours';
      case ClaimStatus.resolved:
        return 'Résolu';
      case ClaimStatus.rejected:
        return 'Rejeté';
    }
  }

  @override
  Widget build(BuildContext context) {
    final claimsAsync = ref.watch(claimStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes sinistres'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/claims/new'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadClaims,
        child: claimsAsync.when(
          data: (claims) {
            if (claims.isEmpty) {
              return const Center(
                child: Text('Aucun sinistre déclaré'),
              );
            }

            return ListView.builder(
              itemCount: claims.length,
              itemBuilder: (context, index) {
                final claim = claims[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      claim.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Date: ${claim.createdAt.toString()}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (claim.notes != null && claim.notes!.isNotEmpty)
                          Text(
                            'Notes: ${claim.notes}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                      ],
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(claim.status),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getStatusText(claim.status),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    onTap: () => context.push('/claims/${claim.id}'),
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
} 
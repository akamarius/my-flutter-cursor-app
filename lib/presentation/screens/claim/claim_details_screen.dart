import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/entities/claim.dart';
import 'package:my_flutter_app/presentation/providers/claim_provider.dart';

class ClaimDetailsScreen extends ConsumerWidget {
  final String claimId;

  const ClaimDetailsScreen({
    super.key,
    required this.claimId,
  });

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
  Widget build(BuildContext context, WidgetRef ref) {
    final claimsAsync = ref.watch(claimStateProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: const Text('Détails du sinistre'),
      ),
      body: claimsAsync.when(
        data: (claims) {
          final claim = claims.firstWhere(
            (c) => c.id == claimId,
            orElse: () => throw Exception('Claim not found'),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Statut',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(claim.status),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                _getStatusText(claim.status),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Description',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(claim.description),
                        if (claim.notes != null && claim.notes!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text(
                            'Notes',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(claim.notes!),
                        ],
                        const SizedBox(height: 16),
                        Text(
                          'Date de création',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(claim.createdAt.toString()),
                        const SizedBox(height: 16),
                        Text(
                          'Localisation',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Latitude: ${claim.latitude}\nLongitude: ${claim.longitude}',
                        ),
                      ],
                    ),
                  ),
                ),
                if (claim.photoUrls.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Photos',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: claim.photoUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              claim.photoUrls[index],
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
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
    );
  }
}

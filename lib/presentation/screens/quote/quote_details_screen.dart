import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';
import 'package:my_flutter_app/presentation/providers/quote_provider.dart';
import 'package:intl/intl.dart';

class QuoteDetailsScreen extends ConsumerWidget {
  final String quoteId;

  const QuoteDetailsScreen({super.key, required this.quoteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quoteState = ref.watch(quoteStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la cotation'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(quoteStateProvider.notifier).loadQuoteDetails(quoteId);
            },
          ),
        ],
      ),
      body: quoteState.when(
        data: (quote) {
          if (quote.isEmpty) {
            return const Center(
              child: Text('Cotation non trouvée'),
            );
          }
          return _buildQuoteDetails(context, quote.first);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Erreur: $error',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(quoteStateProvider.notifier)
                      .loadQuoteDetails(quoteId);
                },
                child: const Text('Réessayer'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuoteDetails(BuildContext context, Quote quote) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête avec statut
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _getStatusColor(quote.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          _getInsuranceTypeIcon(quote.insuranceType),
                          color: _getStatusColor(quote.status),
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getInsuranceTypeText(quote.insuranceType),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              'ID: ${quote.id}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(quote.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getStatusText(quote.status),
                          style: TextStyle(
                            color: _getStatusColor(quote.status),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        'Créée le ${DateFormat('dd/MM/yyyy à HH:mm').format(quote.createdAt)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      if (quote.updatedAt != null) ...[
                        const SizedBox(width: 16),
                        const Icon(Icons.update, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Modifiée le ${DateFormat('dd/MM/yyyy à HH:mm').format(quote.updatedAt!)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                  if (quote.estimatedAmount != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.euro, size: 16, color: Colors.green),
                        const SizedBox(width: 4),
                        Text(
                          'Montant estimé: ${quote.estimatedAmount!.toStringAsFixed(0)} €',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ],
                  if (quote.assignedAgent != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 16, color: Colors.blue),
                        const SizedBox(width: 4),
                        Text(
                          'Agent assigné: ${quote.assignedAgent}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Demande de cotation
          Text(
            'Demande de cotation',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRequestData(quote.requestData, quote.insuranceType),
                  if (quote.notes != null && quote.notes!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),
                    Text(
                      'Notes:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(quote.notes!),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Réponse de cotation
          if (quote.responseData != null) ...[
            Text(
              'Réponse de cotation',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildResponseData(
                    quote.responseData!, quote.insuranceType),
              ),
            ),
          ] else ...[
            Card(
              color: Colors.orange.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.schedule, color: Colors.orange),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'En attente de traitement par nos experts',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRequestData(Map<String, dynamic> data, InsuranceType type) {
    switch (type) {
      case InsuranceType.auto:
        return _buildAutoRequestData(data);
      case InsuranceType.habitation:
        return _buildHabitationRequestData(data);
      case InsuranceType.epargne:
        return _buildEpargneRequestData(data);
      case InsuranceType.deces:
        return _buildDecesRequestData(data);
      case InsuranceType.sante:
        return _buildSanteRequestData(data);
      case InsuranceType.voyage:
        return _buildVoyageRequestData(data);
    }
  }

  Widget _buildResponseData(Map<String, dynamic> data, InsuranceType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: data.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120,
                child: Text(
                  '${entry.key}:',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Text(entry.value.toString()),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAutoRequestData(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDataRow('Marque', data['brand'] ?? ''),
        _buildDataRow('Modèle', data['model'] ?? ''),
        _buildDataRow('Année', data['year']?.toString() ?? ''),
        _buildDataRow('Plaque', data['licensePlate'] ?? ''),
        _buildDataRow('Permis', data['driverLicense'] ?? ''),
        _buildDataRow('Expérience', '${data['drivingExperience']} an(s)'),
        _buildDataRow(
            'Accidents', data['hasAccidents'] == true ? 'Oui' : 'Non'),
        _buildDataRow('Usage', data['usage'] ?? ''),
        _buildDataRow('Kilométrage', '${data['annualMileage']} km/an'),
      ],
    );
  }

  Widget _buildHabitationRequestData(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDataRow('Adresse', data['address'] ?? ''),
        _buildDataRow('Type', data['propertyType'] ?? ''),
        _buildDataRow(
            'Année construction', data['constructionYear']?.toString() ?? ''),
        _buildDataRow('Surface', '${data['surfaceArea']} m²'),
        _buildDataRow('Pièces', data['numberOfRooms']?.toString() ?? ''),
        _buildDataRow('Système sécurité',
            data['hasSecuritySystem'] == true ? 'Oui' : 'Non'),
        _buildDataRow(
            'Détecteur fumée', data['hasFireAlarm'] == true ? 'Oui' : 'Non'),
        _buildDataRow('Type occupation', data['occupancyType'] ?? ''),
      ],
    );
  }

  Widget _buildEpargneRequestData(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDataRow('Montant cible', '${data['targetAmount']} €'),
        _buildDataRow('Durée', '${data['duration']} an(s)'),
        _buildDataRow('Profil investissement', data['investmentProfile'] ?? ''),
        _buildDataRow(
            'Contribution mensuelle', '${data['monthlyContribution']} €'),
        _buildDataRow('Bénéficiaire', data['beneficiary'] ?? ''),
        _buildDataRow('Stratégie', data['investmentStrategy'] ?? ''),
      ],
    );
  }

  Widget _buildDecesRequestData(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDataRow('Montant couverture', '${data['coverageAmount']} €'),
        _buildDataRow('Durée', '${data['duration']} an(s)'),
        _buildDataRow('Bénéficiaire', data['beneficiary'] ?? ''),
        _buildDataRow('Conditions médicales',
            data['hasMedicalConditions'] == true ? 'Oui' : 'Non'),
        _buildDataRow('Profession', data['occupation'] ?? ''),
        _buildDataRow('Fumeur', data['isSmoker'] == true ? 'Oui' : 'Non'),
      ],
    );
  }

  Widget _buildSanteRequestData(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDataRow('Type couverture', data['coverageType'] ?? ''),
        _buildDataRow('Membres famille',
            (data['familyMembers'] as List?)?.join(', ') ?? ''),
        _buildDataRow('Conditions préexistantes',
            data['hasPreExistingConditions'] == true ? 'Oui' : 'Non'),
        _buildDataRow('Hôpital préféré', data['preferredHospital'] ?? ''),
        _buildDataRow(
            'Inclut dentaire', data['includesDental'] == true ? 'Oui' : 'Non'),
        _buildDataRow(
            'Inclut vision', data['includesVision'] == true ? 'Oui' : 'Non'),
      ],
    );
  }

  Widget _buildVoyageRequestData(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDataRow('Destination', data['destination'] ?? ''),
        _buildDataRow(
            'Date départ',
            DateFormat('dd/MM/yyyy')
                .format(DateTime.parse(data['departureDate']))),
        _buildDataRow(
            'Date retour',
            DateFormat('dd/MM/yyyy')
                .format(DateTime.parse(data['returnDate']))),
        _buildDataRow(
            'Nombre voyageurs', data['numberOfTravelers']?.toString() ?? ''),
        _buildDataRow(
            'Voyageurs', (data['travelers'] as List?)?.join(', ') ?? ''),
        _buildDataRow('Type voyage', data['tripType'] ?? ''),
        _buildDataRow(
            'Inclut médical', data['includesMedical'] == true ? 'Oui' : 'Non'),
        _buildDataRow('Inclut annulation',
            data['includesCancellation'] == true ? 'Oui' : 'Non'),
        _buildDataRow(
            'Inclut bagages', data['includesBaggage'] == true ? 'Oui' : 'Non'),
      ],
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  String _getStatusText(QuoteStatus status) {
    switch (status) {
      case QuoteStatus.pending:
        return 'En attente';
      case QuoteStatus.inProgress:
        return 'En cours';
      case QuoteStatus.completed:
        return 'Terminé';
      case QuoteStatus.rejected:
        return 'Rejeté';
      case QuoteStatus.cancelled:
        return 'Annulé';
    }
  }

  String _getInsuranceTypeText(InsuranceType type) {
    switch (type) {
      case InsuranceType.auto:
        return 'Auto';
      case InsuranceType.habitation:
        return 'Habitation';
      case InsuranceType.epargne:
        return 'Épargne';
      case InsuranceType.deces:
        return 'Décès';
      case InsuranceType.sante:
        return 'Santé';
      case InsuranceType.voyage:
        return 'Voyage';
    }
  }

  Color _getStatusColor(QuoteStatus status) {
    switch (status) {
      case QuoteStatus.pending:
        return Colors.orange;
      case QuoteStatus.inProgress:
        return Colors.blue;
      case QuoteStatus.completed:
        return Colors.green;
      case QuoteStatus.rejected:
        return Colors.red;
      case QuoteStatus.cancelled:
        return Colors.grey;
    }
  }

  IconData _getInsuranceTypeIcon(InsuranceType type) {
    switch (type) {
      case InsuranceType.auto:
        return Icons.directions_car;
      case InsuranceType.habitation:
        return Icons.home;
      case InsuranceType.epargne:
        return Icons.savings;
      case InsuranceType.deces:
        return Icons.favorite;
      case InsuranceType.sante:
        return Icons.local_hospital;
      case InsuranceType.voyage:
        return Icons.flight;
    }
  }
}

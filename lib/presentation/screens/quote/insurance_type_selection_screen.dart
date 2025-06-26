import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';

class InsuranceTypeSelectionScreen extends StatelessWidget {
  const InsuranceTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisir un type d\'assurance'),
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.security,
                      size: 48,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Quel type d\'assurance recherchez-vous ?',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sélectionnez le type d\'assurance qui correspond à vos besoins',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Grille des types d'assurance
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: [
                _buildInsuranceCard(
                  context,
                  InsuranceType.auto,
                  'Auto',
                  Icons.directions_car,
                  Colors.blue,
                  'Assurance automobile complète',
                ),
                _buildInsuranceCard(
                  context,
                  InsuranceType.habitation,
                  'Habitation',
                  Icons.home,
                  Colors.green,
                  'Protection de votre logement',
                ),
                _buildInsuranceCard(
                  context,
                  InsuranceType.epargne,
                  'Épargne',
                  Icons.savings,
                  Colors.orange,
                  'Épargne et investissement',
                ),
                _buildInsuranceCard(
                  context,
                  InsuranceType.deces,
                  'Décès',
                  Icons.favorite,
                  Colors.red,
                  'Protection de votre famille',
                ),
                _buildInsuranceCard(
                  context,
                  InsuranceType.sante,
                  'Santé',
                  Icons.local_hospital,
                  Colors.purple,
                  'Couverture médicale',
                ),
                _buildInsuranceCard(
                  context,
                  InsuranceType.voyage,
                  'Voyage',
                  Icons.flight,
                  Colors.teal,
                  'Assurance voyage',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsuranceCard(
    BuildContext context,
    InsuranceType type,
    String title,
    IconData icon,
    Color color,
    String description,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => _navigateToQuoteForm(context, type),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToQuoteForm(BuildContext context, InsuranceType type) {
    switch (type) {
      case InsuranceType.auto:
        context.push('/quote/auto');
        break;
      case InsuranceType.habitation:
        context.push('/quote/habitation');
        break;
      case InsuranceType.epargne:
        context.push('/quote/epargne');
        break;
      case InsuranceType.deces:
        context.push('/quote/deces');
        break;
      case InsuranceType.sante:
        context.push('/quote/sante');
        break;
      case InsuranceType.voyage:
        context.push('/quote/voyage');
        break;
    }
  }
}

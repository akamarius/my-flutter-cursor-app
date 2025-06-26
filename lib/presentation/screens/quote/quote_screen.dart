import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class QuoteScreen extends ConsumerStatefulWidget {
  const QuoteScreen({super.key});

  @override
  ConsumerState<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends ConsumerState<QuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: const Text('Cotations'),
        //actions: [
        //  IconButton(
        //    icon: const Icon(Icons.list),
        //    onPressed: () {
        //      Navigator.pushNamed(context, '/quote/list');
        //    },
        //  ),
        //],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // En-tête
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.calculate,
                      size: 48,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Service de Cotation',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Obtenez des devis personnalisés pour tous vos besoins d\'assurance',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Options principales
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        context.push('/quote/selection');
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 32,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Nouvelle cotation',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Demander un devis',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        context.push('/quote/list');
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.list_alt,
                                size: 32,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Mes cotations',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Voir l\'historique',
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Informations sur les types d'assurance
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.info, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          'Types d\'assurance disponibles',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildInsuranceTypeInfo('Auto',
                        'Assurance automobile complète', Icons.directions_car),
                    _buildInsuranceTypeInfo('Habitation',
                        'Protection de votre logement', Icons.home),
                    _buildInsuranceTypeInfo(
                        'Épargne', 'Épargne et investissement', Icons.savings),
                    _buildInsuranceTypeInfo(
                        'Décès', 'Protection de votre famille', Icons.favorite),
                    _buildInsuranceTypeInfo(
                        'Santé', 'Couverture médicale', Icons.local_hospital),
                    _buildInsuranceTypeInfo(
                        'Voyage', 'Assurance voyage', Icons.flight),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Informations importantes
            Card(
              color: Colors.orange.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.lightbulb, color: Colors.orange),
                        const SizedBox(width: 8),
                        Text(
                          'Informations importantes',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Votre demande sera traitée dans les 24h\n'
                      '• Un expert vous contactera pour finaliser votre devis\n'
                      '• Aucun engagement de votre part\n'
                      '• Devis gratuit et sans obligation',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsuranceTypeInfo(
      String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

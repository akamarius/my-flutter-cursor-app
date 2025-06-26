import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';
import 'package:my_flutter_app/presentation/providers/quote_provider.dart';
import 'package:my_flutter_app/presentation/widgets/animated_button.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';

class EpargneQuoteScreen extends ConsumerStatefulWidget {
  const EpargneQuoteScreen({super.key});

  @override
  ConsumerState<EpargneQuoteScreen> createState() => _EpargneQuoteScreenState();
}

class _EpargneQuoteScreenState extends ConsumerState<EpargneQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _beneficiaryController = TextEditingController();
  final _notesController = TextEditingController();

  double _targetAmount = 10000.0;
  int _duration = 5;
  String _investmentProfile = 'Conservateur';
  double _monthlyContribution = 200.0;
  String _investmentStrategy = 'Diversifié';
  bool _isLoading = false;

  final List<String> _investmentProfiles = [
    'Conservateur',
    'Modéré',
    'Dynamique',
    'Agressif',
  ];

  final List<String> _investmentStrategies = [
    'Diversifié',
    'Actions',
    'Obligations',
    'Immobilier',
    'Matériaux précieux',
    'Technologies',
    'Énergies vertes',
  ];

  @override
  void dispose() {
    _beneficiaryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitQuote(String userId) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final requestData = {
        'targetAmount': _targetAmount,
        'duration': _duration,
        'investmentProfile': _investmentProfile,
        'monthlyContribution': _monthlyContribution,
        'investmentStrategy': _investmentStrategy,
        'beneficiary': _beneficiaryController.text.isNotEmpty
            ? _beneficiaryController.text
            : null,
      };

      final request = QuoteRequest(
        userId: userId,
        insuranceType: InsuranceType.epargne,
        data: requestData,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      await ref.read(quoteRequestProvider.notifier).requestQuote(request);

      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Demande envoyée'),
        content: const Text(
          'Votre demande de cotation épargne a été envoyée avec succès. '
          'Un expert vous contactera dans les plus brefs délais.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              context.pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final user = authState.value;
    final userId = user?.id ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cotation Épargne'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
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
                        Icons.savings,
                        size: 48,
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Cotation Assurance Épargne',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Construisez votre avenir financier avec une épargne adaptée',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Objectif d'épargne
              Text(
                'Objectif d\'épargne',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: _targetAmount.toString(),
                decoration: const InputDecoration(
                  labelText: 'Montant cible (XOF) *',
                  border: OutlineInputBorder(),
                  suffixText: 'XOF',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le montant cible';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Veuillez entrer un montant valide';
                  }
                  return null;
                },
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
                onChanged: (value) {
                  final amount = double.tryParse(value);
                  if (amount != null && amount > 0) {
                    setState(() => _targetAmount = amount);
                  }
                },
              ),

              const SizedBox(height: 16),

              // Durée
              DropdownButtonFormField<int>(
                value: _duration,
                decoration: const InputDecoration(
                  labelText: 'Durée (années) *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                items: List.generate(30, (index) {
                  final years = index + 1;
                  return DropdownMenuItem(
                    value: years,
                    child: Text('$years an${years > 1 ? 's' : ''}'),
                  );
                }),
                onChanged: (value) {
                  setState(() => _duration = value!);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner la durée';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Contribution mensuelle
              TextFormField(
                initialValue: _monthlyContribution.toString(),
                decoration: const InputDecoration(
                  labelText: 'Contribution mensuelle (XOF) *',
                  border: OutlineInputBorder(),
                  suffixText: 'XOF',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la contribution mensuelle';
                  }
                  final contribution = double.tryParse(value);
                  if (contribution == null || contribution <= 0) {
                    return 'Veuillez entrer un montant valide';
                  }
                  return null;
                },
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
                onChanged: (value) {
                  final contribution = double.tryParse(value);
                  if (contribution != null && contribution > 0) {
                    setState(() => _monthlyContribution = contribution);
                  }
                },
              ),

              const SizedBox(height: 24),

              // Profil d'investissement
              Text(
                'Profil d\'investissement',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _investmentProfile,
                decoration: const InputDecoration(
                  labelText: 'Profil de risque *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.trending_up),
                ),
                items: _investmentProfiles.map((profile) {
                  return DropdownMenuItem(
                    value: profile,
                    child: Text(profile),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _investmentProfile = value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner le profil de risque';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Stratégie d'investissement
              DropdownButtonFormField<String>(
                value: _investmentStrategy,
                decoration: const InputDecoration(
                  labelText: 'Stratégie d\'investissement *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.analytics),
                ),
                items: _investmentStrategies.map((strategy) {
                  return DropdownMenuItem(
                    value: strategy,
                    child: Text(strategy),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _investmentStrategy = value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner la stratégie';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Bénéficiaire
              TextFormField(
                controller: _beneficiaryController,
                decoration: const InputDecoration(
                  labelText: 'Bénéficiaire',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Nom du bénéficiaire (optionnel)',
                ),
              ),

              const SizedBox(height: 24),

              // Simulation
              Card(
                color: Colors.blue.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calculate, color: Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            'Simulation',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSimulationRow('Montant cible:',
                          '${_targetAmount.toStringAsFixed(0)} XOF'),
                      _buildSimulationRow('Durée:', '$_duration ans'),
                      _buildSimulationRow('Contribution mensuelle:',
                          '${_monthlyContribution.toStringAsFixed(0)} XOF'),
                      _buildSimulationRow('Contribution totale:',
                          '${(_monthlyContribution * 12 * _duration).toStringAsFixed(0)} XOF'),
                      _buildSimulationRow('Profil:', _investmentProfile),
                      _buildSimulationRow('Stratégie:', _investmentStrategy),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Notes
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes supplémentaires',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 24),

              // Bouton de soumission
              AnimatedButton(
                text: 'Demander une cotation',
                onPressed: () => _submitQuote(userId),
                isLoading: _isLoading,
                icon: Icons.send,
                backgroundColor: Colors.orange,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimulationRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

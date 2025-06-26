import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';
import 'package:my_flutter_app/presentation/providers/quote_provider.dart';
import 'package:my_flutter_app/presentation/widgets/animated_button.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';

class DecesQuoteScreen extends ConsumerStatefulWidget {
  const DecesQuoteScreen({super.key});

  @override
  ConsumerState<DecesQuoteScreen> createState() => _DecesQuoteScreenState();
}

class _DecesQuoteScreenState extends ConsumerState<DecesQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _beneficiaryController = TextEditingController();
  final _notesController = TextEditingController();

  double _coverageAmount = 100000.0;
  int _duration = 20;
  String _occupation = 'Employé';
  bool _hasMedicalConditions = false;
  final List<String> _medicalConditions = [];
  bool _isSmoker = false;
  bool _isLoading = false;

  final List<String> _occupations = [
    'Employé',
    'Cadre',
    'Dirigeant',
    'Profession libérale',
    'Artisan',
    'Commerçant',
    'Agriculteur',
    'Retraité',
    'Étudiant',
    'Sans emploi',
    'Autre',
  ];

  final List<String> _medicalConditionsOptions = [
    'Diabète',
    'Hypertension',
    'Maladie cardiaque',
    'Cancer',
    'Asthme',
    'Arthrite',
    'Dépression',
    'Anxiété',
    'Problèmes de vue',
    'Problèmes auditifs',
    'Allergies',
    'Autres',
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
        'coverageAmount': _coverageAmount,
        'duration': _duration,
        'beneficiary': _beneficiaryController.text,
        'hasMedicalConditions': _hasMedicalConditions,
        'medicalConditions': _medicalConditions,
        'occupation': _occupation,
        'isSmoker': _isSmoker,
      };

      final request = QuoteRequest(
        userId: userId,
        insuranceType: InsuranceType.deces,
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
          'Votre demande de cotation décès a été envoyée avec succès. '
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
        title: const Text('Cotation Décès'),
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
                        Icons.favorite,
                        size: 48,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Cotation Assurance Décès',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Protégez l\'avenir de vos proches',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Montant de couverture
              Text(
                'Montant de couverture',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              TextFormField(
                initialValue: _coverageAmount.toString(),
                decoration: const InputDecoration(
                  labelText: 'Montant de couverture (XOF) *',
                  border: OutlineInputBorder(),
                  suffixText: 'XOF',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le montant de couverture';
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
                    setState(() => _coverageAmount = amount);
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
                items: List.generate(40, (index) {
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

              // Bénéficiaire
              TextFormField(
                controller: _beneficiaryController,
                decoration: const InputDecoration(
                  labelText: 'Bénéficiaire *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du bénéficiaire';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Profession
              DropdownButtonFormField<String>(
                value: _occupation,
                decoration: const InputDecoration(
                  labelText: 'Profession *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.work),
                ),
                items: _occupations.map((occupation) {
                  return DropdownMenuItem(
                    value: occupation,
                    child: Text(occupation),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _occupation = value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner votre profession';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Informations médicales
              Text(
                'Informations médicales',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              SwitchListTile(
                title: const Text('Conditions médicales'),
                subtitle: const Text(
                    'Avez-vous des conditions médicales existantes ?'),
                value: _hasMedicalConditions,
                onChanged: (value) {
                  setState(() => _hasMedicalConditions = value);
                },
                secondary: const Icon(Icons.medical_services),
              ),

              if (_hasMedicalConditions) ...[
                const SizedBox(height: 16),
                Text(
                  'Sélectionnez vos conditions médicales',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _medicalConditionsOptions.map((condition) {
                    final isSelected = _medicalConditions.contains(condition);
                    return FilterChip(
                      label: Text(condition),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _medicalConditions.add(condition);
                          } else {
                            _medicalConditions.remove(condition);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 16),

              SwitchListTile(
                title: const Text('Fumeur'),
                subtitle: const Text('Êtes-vous fumeur ?'),
                value: _isSmoker,
                onChanged: (value) {
                  setState(() => _isSmoker = value);
                },
                secondary: const Icon(Icons.smoking_rooms),
              ),

              const SizedBox(height: 24),

              // Simulation
              Card(
                color: Colors.red.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calculate, color: Colors.red),
                          const SizedBox(width: 8),
                          Text(
                            'Simulation',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSimulationRow('Montant de couverture:',
                          '${_coverageAmount.toStringAsFixed(0)} XOF'),
                      _buildSimulationRow('Durée:', '$_duration ans'),
                      _buildSimulationRow(
                          'Bénéficiaire:',
                          _beneficiaryController.text.isNotEmpty
                              ? _beneficiaryController.text
                              : 'Non spécifié'),
                      _buildSimulationRow('Profession:', _occupation),
                      _buildSimulationRow('Conditions médicales:',
                          _hasMedicalConditions ? 'Oui' : 'Non'),
                      _buildSimulationRow('Fumeur:', _isSmoker ? 'Oui' : 'Non'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Informations importantes
              Card(
                color: Colors.blue.withOpacity(0.1),
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
                            'Informations importantes',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• La déclaration de conditions médicales est obligatoire\n'
                        '• Certaines conditions peuvent être exclues ou soumises à délai d\'attente\n'
                        '• Les tarifs varient selon l\'âge, l\'état de santé et le mode de vie\n'
                        '• Un questionnaire médical détaillé pourra être demandé\n'
                        '• Le statut de fumeur impacte significativement les tarifs',
                        style: TextStyle(fontSize: 12),
                      ),
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
                backgroundColor: Colors.red,
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

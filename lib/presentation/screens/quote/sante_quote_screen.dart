import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';
import 'package:my_flutter_app/presentation/providers/quote_provider.dart';
import 'package:my_flutter_app/presentation/widgets/animated_button.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';

class SanteQuoteScreen extends ConsumerStatefulWidget {
  const SanteQuoteScreen({super.key});

  @override
  ConsumerState<SanteQuoteScreen> createState() => _SanteQuoteScreenState();
}

class _SanteQuoteScreenState extends ConsumerState<SanteQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _preferredHospitalController = TextEditingController();
  final _notesController = TextEditingController();

  String _coverageType = 'Individuelle';
  final List<String> _familyMembers = ['Moi'];
  bool _hasPreExistingConditions = false;
  final List<String> _preExistingConditions = [];
  bool _includesDental = true;
  bool _includesVision = true;
  bool _isLoading = false;

  final List<String> _coverageTypes = [
    'Individuelle',
    'Famille',
    'Couple',
    'Enfant',
    'Senior',
    'Étudiant',
  ];

  final List<String> _familyMemberOptions = [
    'Moi',
    'Conjoint(e)',
    'Enfant 1',
    'Enfant 2',
    'Enfant 3',
    'Enfant 4',
    'Parent 1',
    'Parent 2',
  ];

  final List<String> _preExistingConditionsOptions = [
    'Diabète',
    'Hypertension',
    'Asthme',
    'Maladie cardiaque',
    'Cancer',
    'Arthrite',
    'Dépression',
    'Anxiété',
    'Allergies',
    'Problèmes de vue',
    'Problèmes dentaires',
    'Autres',
  ];

  @override
  void dispose() {
    _preferredHospitalController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitQuote(String userId) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final requestData = {
        'coverageType': _coverageType,
        'familyMembers': _familyMembers,
        'hasPreExistingConditions': _hasPreExistingConditions,
        'preExistingConditions': _preExistingConditions,
        'preferredHospital': _preferredHospitalController.text,
        'includesDental': _includesDental,
        'includesVision': _includesVision,
      };

      final request = QuoteRequest(
        userId: userId,
        insuranceType: InsuranceType.sante,
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
          'Votre demande de cotation santé a été envoyée avec succès. '
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
        title: const Text('Cotation Santé'),
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
                        Icons.local_hospital,
                        size: 48,
                        color: Colors.purple,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Cotation Assurance Santé',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Protégez votre santé et celle de votre famille',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Type de couverture
              Text(
                'Type de couverture',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _coverageType,
                decoration: const InputDecoration(
                  labelText: 'Type de couverture *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.people),
                ),
                items: _coverageTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _coverageType = value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner le type de couverture';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Membres de la famille
              Text(
                'Membres à assurer',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Sélectionnez les membres de votre famille à inclure',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _familyMemberOptions.map((member) {
                  final isSelected = _familyMembers.contains(member);
                  return FilterChip(
                    label: Text(member),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _familyMembers.add(member);
                        } else {
                          _familyMembers.remove(member);
                        }
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // Conditions préexistantes
              Text(
                'Conditions médicales',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              SwitchListTile(
                title: const Text('Conditions préexistantes'),
                subtitle: const Text(
                    'Avez-vous des conditions médicales existantes ?'),
                value: _hasPreExistingConditions,
                onChanged: (value) {
                  setState(() => _hasPreExistingConditions = value);
                },
                secondary: const Icon(Icons.medical_services),
              ),

              if (_hasPreExistingConditions) ...[
                const SizedBox(height: 16),
                Text(
                  'Sélectionnez vos conditions médicales',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _preExistingConditionsOptions.map((condition) {
                    final isSelected =
                        _preExistingConditions.contains(condition);
                    return FilterChip(
                      label: Text(condition),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _preExistingConditions.add(condition);
                          } else {
                            _preExistingConditions.remove(condition);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 24),

              // Hôpital préféré
              TextFormField(
                controller: _preferredHospitalController,
                decoration: const InputDecoration(
                  labelText: 'Hôpital préféré',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.local_hospital),
                  hintText: 'Nom de l\'hôpital ou centre médical',
                ),
              ),

              const SizedBox(height: 24),

              // Couvertures supplémentaires
              Text(
                'Couvertures supplémentaires',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              SwitchListTile(
                title: const Text('Couverture dentaire'),
                subtitle: const Text('Soins dentaires et orthodontie'),
                value: _includesDental,
                onChanged: (value) {
                  setState(() => _includesDental = value);
                },
                secondary: const Icon(Icons.medical_services),
              ),

              SwitchListTile(
                title: const Text('Couverture optique'),
                subtitle:
                    const Text('Lunettes, lentilles et chirurgie oculaire'),
                value: _includesVision,
                onChanged: (value) {
                  setState(() => _includesVision = value);
                },
                secondary: const Icon(Icons.visibility),
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
                        '• La déclaration de conditions préexistantes est obligatoire\n'
                        '• Certaines conditions peuvent être exclues ou soumises à délai d\'attente\n'
                        '• Les tarifs varient selon l\'âge et l\'état de santé\n'
                        '• Un questionnaire médical détaillé pourra être demandé',
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
                backgroundColor: Colors.purple,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

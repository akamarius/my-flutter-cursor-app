import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';
import 'package:my_flutter_app/presentation/providers/quote_provider.dart';
import 'package:my_flutter_app/presentation/widgets/animated_button.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';

class AutoQuoteScreen extends ConsumerStatefulWidget {
  const AutoQuoteScreen({super.key});

  @override
  ConsumerState<AutoQuoteScreen> createState() => _AutoQuoteScreenState();
}

class _AutoQuoteScreenState extends ConsumerState<AutoQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _licensePlateController = TextEditingController();
  final _driverLicenseController = TextEditingController();
  final _notesController = TextEditingController();

  int _selectedYear = DateTime.now().year;
  int _drivingExperience = 1;
  bool _hasAccidents = false;
  String _usage = 'Personnel';
  int _annualMileage = 10000;
  bool _isLoading = false;

  final List<String> _usageOptions = [
    'Personnel',
    'Professionnel',
    'Commercial',
    'Transport',
  ];

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _licensePlateController.dispose();
    _driverLicenseController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitQuote(String userId) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final requestData = {
        'brand': _brandController.text,
        'model': _modelController.text,
        'year': _selectedYear,
        'licensePlate': _licensePlateController.text,
        'driverLicense': _driverLicenseController.text,
        'drivingExperience': _drivingExperience,
        'hasAccidents': _hasAccidents,
        'usage': _usage,
        'annualMileage': _annualMileage,
      };

      final request = QuoteRequest(
        userId: userId,
        insuranceType: InsuranceType.auto,
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
          'Votre demande de cotation automobile a été envoyée avec succès. '
          'Un expert vous contactera dans les plus brefs délais.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
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
        title: const Text('Cotation Auto'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
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
                        Icons.directions_car,
                        size: 48,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Cotation Assurance Auto',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Remplissez les informations de votre véhicule',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Informations du véhicule
              Text(
                'Informations du véhicule',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(
                  labelText: 'Marque *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_car),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la marque';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(
                  labelText: 'Modèle *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_car),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le modèle';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Année du véhicule
              DropdownButtonFormField<int>(
                value: _selectedYear,
                decoration: const InputDecoration(
                  labelText: 'Année *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                items: List.generate(30, (index) {
                  final year = DateTime.now().year - index;
                  return DropdownMenuItem(
                    value: year,
                    child: Text(year.toString()),
                  );
                }),
                onChanged: (value) {
                  setState(() => _selectedYear = value!);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner l\'année';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _licensePlateController,
                decoration: const InputDecoration(
                  labelText: 'Plaque d\'immatriculation *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.confirmation_number),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la plaque';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Informations du conducteur
              Text(
                'Informations du conducteur',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _driverLicenseController,
                decoration: const InputDecoration(
                  labelText: 'Numéro de permis *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le numéro de permis';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Expérience de conduite
              DropdownButtonFormField<int>(
                value: _drivingExperience,
                decoration: const InputDecoration(
                  labelText: 'Expérience de conduite (années) *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timeline),
                ),
                items: List.generate(50, (index) {
                  return DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1} an${index > 0 ? 's' : ''}'),
                  );
                }),
                onChanged: (value) {
                  setState(() => _drivingExperience = value!);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner l\'expérience';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Accidents
              SwitchListTile(
                title: const Text('Avez-vous eu des accidents ?'),
                subtitle: const Text(
                    'Accidents responsables dans les 3 dernières années'),
                value: _hasAccidents,
                onChanged: (value) {
                  setState(() => _hasAccidents = value);
                },
                secondary: const Icon(Icons.warning),
              ),

              const SizedBox(height: 16),

              // Usage du véhicule
              DropdownButtonFormField<String>(
                value: _usage,
                decoration: const InputDecoration(
                  labelText: 'Usage du véhicule *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.business),
                ),
                items: _usageOptions.map((usage) {
                  return DropdownMenuItem(
                    value: usage,
                    child: Text(usage),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _usage = value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner l\'usage';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Kilométrage annuel
              DropdownButtonFormField<int>(
                value: _annualMileage,
                decoration: const InputDecoration(
                  labelText: 'Kilométrage annuel *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.speed),
                ),
                items: const [
                  DropdownMenuItem(value: 5000, child: Text('5 000 km')),
                  DropdownMenuItem(value: 10000, child: Text('10 000 km')),
                  DropdownMenuItem(value: 15000, child: Text('15 000 km')),
                  DropdownMenuItem(value: 20000, child: Text('20 000 km')),
                  DropdownMenuItem(value: 25000, child: Text('25 000 km')),
                  DropdownMenuItem(value: 30000, child: Text('30 000 km')),
                  DropdownMenuItem(value: 50000, child: Text('50 000 km')),
                ],
                onChanged: (value) {
                  setState(() => _annualMileage = value!);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner le kilométrage';
                  }
                  return null;
                },
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
                backgroundColor: Colors.blue,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

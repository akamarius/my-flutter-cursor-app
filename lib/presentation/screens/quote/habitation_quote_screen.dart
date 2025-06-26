import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';
import 'package:my_flutter_app/presentation/providers/quote_provider.dart';
import 'package:my_flutter_app/presentation/widgets/animated_button.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';

class HabitationQuoteScreen extends ConsumerStatefulWidget {
  const HabitationQuoteScreen({super.key});

  @override
  ConsumerState<HabitationQuoteScreen> createState() =>
      _HabitationQuoteScreenState();
}

class _HabitationQuoteScreenState extends ConsumerState<HabitationQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _notesController = TextEditingController();

  String _propertyType = 'Appartement';
  int _constructionYear = DateTime.now().year;
  double _surfaceArea = 50.0;
  int _numberOfRooms = 2;
  bool _hasSecuritySystem = false;
  bool _hasFireAlarm = false;
  String _occupancyType = 'Résidence principale';
  final List<String> _valuableItems = [];
  bool _isLoading = false;

  final List<String> _propertyTypes = [
    'Appartement',
    'Maison',
    'Villa',
    'Studio',
    'Loft',
    'Duplex',
    'Triplex',
    'Maison de ville',
  ];

  final List<String> _occupancyTypes = [
    'Résidence principale',
    'Résidence secondaire',
    'Location',
    'Colocation',
    'Bureau',
    'Commerce',
  ];

  final List<String> _valuableItemsOptions = [
    'Bijoux',
    'Œuvres d\'art',
    'Équipements électroniques',
    'Instruments de musique',
    'Collections',
    'Mobilier de valeur',
    'Véhicules',
    'Autres',
  ];

  @override
  void dispose() {
    _addressController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submitQuote(String userId) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final requestData = {
        'address': _addressController.text,
        'propertyType': _propertyType,
        'constructionYear': _constructionYear,
        'surfaceArea': _surfaceArea,
        'numberOfRooms': _numberOfRooms,
        'hasSecuritySystem': _hasSecuritySystem,
        'hasFireAlarm': _hasFireAlarm,
        'occupancyType': _occupancyType,
        'valuableItems': _valuableItems,
      };

      final request = QuoteRequest(
        userId: userId,
        insuranceType: InsuranceType.habitation,
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
          'Votre demande de cotation habitation a été envoyée avec succès. '
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
        title: const Text('Cotation Habitation'),
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
                        Icons.home,
                        size: 48,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Cotation Assurance Habitation',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Protégez votre logement avec une assurance adaptée',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Informations du logement
              Text(
                'Informations du logement',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Adresse complète *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                maxLines: 2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer l\'adresse';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _propertyType,
                decoration: const InputDecoration(
                  labelText: 'Type de bien *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
                items: _propertyTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _propertyType = value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner le type de bien';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Année de construction
              DropdownButtonFormField<int>(
                value: _constructionYear,
                decoration: const InputDecoration(
                  labelText: 'Année de construction *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                items: List.generate(100, (index) {
                  final year = DateTime.now().year - index;
                  return DropdownMenuItem(
                    value: year,
                    child: Text(year.toString()),
                  );
                }),
                onChanged: (value) {
                  setState(() => _constructionYear = value!);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner l\'année';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Surface
              TextFormField(
                initialValue: _surfaceArea.toString(),
                decoration: const InputDecoration(
                  labelText: 'Surface (m²) *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.square_foot),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la surface';
                  }
                  final surface = double.tryParse(value);
                  if (surface == null || surface <= 0) {
                    return 'Veuillez entrer une surface valide';
                  }
                  return null;
                },
                onChanged: (value) {
                  final surface = double.tryParse(value);
                  if (surface != null && surface > 0) {
                    setState(() => _surfaceArea = surface);
                  }
                },
              ),

              const SizedBox(height: 16),

              // Nombre de pièces
              DropdownButtonFormField<int>(
                value: _numberOfRooms,
                decoration: const InputDecoration(
                  labelText: 'Nombre de pièces *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.door_front_door),
                ),
                items: List.generate(20, (index) {
                  return DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1} pièce${index > 0 ? 's' : ''}'),
                  );
                }),
                onChanged: (value) {
                  setState(() => _numberOfRooms = value!);
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner le nombre de pièces';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Type d'occupation
              DropdownButtonFormField<String>(
                value: _occupancyType,
                decoration: const InputDecoration(
                  labelText: 'Type d\'occupation *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                items: _occupancyTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _occupancyType = value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner le type d\'occupation';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Équipements de sécurité
              Text(
                'Équipements de sécurité',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              SwitchListTile(
                title: const Text('Système d\'alarme'),
                subtitle: const Text('Système de sécurité installé'),
                value: _hasSecuritySystem,
                onChanged: (value) {
                  setState(() => _hasSecuritySystem = value);
                },
                secondary: const Icon(Icons.security),
              ),

              SwitchListTile(
                title: const Text('Détecteur de fumée'),
                subtitle: const Text('Détecteurs installés'),
                value: _hasFireAlarm,
                onChanged: (value) {
                  setState(() => _hasFireAlarm = value);
                },
                secondary: const Icon(Icons.smoke_free),
              ),

              const SizedBox(height: 24),

              // Objets de valeur
              Text(
                'Objets de valeur',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Sélectionnez les objets de valeur présents dans votre logement',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _valuableItemsOptions.map((item) {
                  final isSelected = _valuableItems.contains(item);
                  return FilterChip(
                    label: Text(item),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _valuableItems.add(item);
                        } else {
                          _valuableItems.remove(item);
                        }
                      });
                    },
                  );
                }).toList(),
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
                backgroundColor: Colors.green,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

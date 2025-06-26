import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/domain/entities/quote.dart';
import 'package:my_flutter_app/presentation/providers/quote_provider.dart';
import 'package:my_flutter_app/presentation/widgets/animated_button.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';

class VoyageQuoteScreen extends ConsumerStatefulWidget {
  const VoyageQuoteScreen({super.key});

  @override
  ConsumerState<VoyageQuoteScreen> createState() => _VoyageQuoteScreenState();
}

class _VoyageQuoteScreenState extends ConsumerState<VoyageQuoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _destinationController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _departureDate = DateTime.now().add(const Duration(days: 7));
  DateTime _returnDate = DateTime.now().add(const Duration(days: 14));
  int _numberOfTravelers = 1;
  List<String> _travelers = ['Moi'];
  String _tripType = 'Loisirs';
  bool _includesMedical = true;
  bool _includesCancellation = true;
  bool _includesBaggage = true;
  final List<String> _activities = [];
  bool _isLoading = false;

  final List<String> _tripTypes = [
    'Loisirs',
    'Affaires',
    'Études',
    'Sport',
    'Croisière',
    'Aventure',
    'Culturel',
    'Médical',
  ];

  final List<String> _activitiesOptions = [
    'Plongée',
    'Ski',
    'Randonnée',
    'Sports nautiques',
    'Escalade',
    'Parapente',
    'Golf',
    'Tennis',
    'Vélo',
    'Course à pied',
    'Yoga',
    'Méditation',
    'Photographie',
    'Peinture',
    'Autres',
  ];

  @override
  void initState() {
    super.initState();
    _updateTravelersList();
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _updateTravelersList() {
    _travelers = List.generate(_numberOfTravelers, (index) {
      if (index == 0) return 'Moi';
      return 'Voyageur ${index + 1}';
    });
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDeparture ? _departureDate : _returnDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departureDate = picked;
          if (_returnDate.isBefore(_departureDate)) {
            _returnDate = _departureDate.add(const Duration(days: 7));
          }
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  Future<void> _submitQuote(String userId) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final requestData = {
        'destination': _destinationController.text,
        'departureDate': _departureDate.toIso8601String(),
        'returnDate': _returnDate.toIso8601String(),
        'numberOfTravelers': _numberOfTravelers,
        'travelers': _travelers,
        'tripType': _tripType,
        'includesMedical': _includesMedical,
        'includesCancellation': _includesCancellation,
        'includesBaggage': _includesBaggage,
        'activities': _activities,
      };

      final request = QuoteRequest(
        userId: userId,
        insuranceType: InsuranceType.voyage,
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
          'Votre demande de cotation voyage a été envoyée avec succès. '
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
        title: const Text('Cotation Voyage'),
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
                        Icons.flight,
                        size: 48,
                        color: Colors.teal,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Cotation Assurance Voyage',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Voyagez en toute sérénité avec une couverture adaptée',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Informations du voyage
              Text(
                'Informations du voyage',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _destinationController,
                decoration: const InputDecoration(
                  labelText: 'Destination *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la destination';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Dates de voyage
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, true),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date de départ *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          '${_departureDate.day.toString().padLeft(2, '0')}/${_departureDate.month.toString().padLeft(2, '0')}/${_departureDate.year}',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context, false),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date de retour *',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          '${_returnDate.day.toString().padLeft(2, '0')}/${_returnDate.month.toString().padLeft(2, '0')}/${_returnDate.year}',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Type de voyage
              DropdownButtonFormField<String>(
                value: _tripType,
                decoration: const InputDecoration(
                  labelText: 'Type de voyage *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _tripTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _tripType = value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner le type de voyage';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Nombre de voyageurs
              DropdownButtonFormField<int>(
                value: _numberOfTravelers,
                decoration: const InputDecoration(
                  labelText: 'Nombre de voyageurs *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.people),
                ),
                items: List.generate(10, (index) {
                  return DropdownMenuItem(
                    value: index + 1,
                    child: Text('${index + 1} voyageur${index > 0 ? 's' : ''}'),
                  );
                }),
                onChanged: (value) {
                  setState(() {
                    _numberOfTravelers = value!;
                    _updateTravelersList();
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Veuillez sélectionner le nombre de voyageurs';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Couvertures
              Text(
                'Couvertures souhaitées',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              SwitchListTile(
                title: const Text('Couverture médicale'),
                subtitle: const Text('Frais médicaux et rapatriement'),
                value: _includesMedical,
                onChanged: (value) {
                  setState(() => _includesMedical = value);
                },
                secondary: const Icon(Icons.local_hospital),
              ),

              SwitchListTile(
                title: const Text('Annulation'),
                subtitle: const Text('Remboursement en cas d\'annulation'),
                value: _includesCancellation,
                onChanged: (value) {
                  setState(() => _includesCancellation = value);
                },
                secondary: const Icon(Icons.cancel),
              ),

              SwitchListTile(
                title: const Text('Bagages'),
                subtitle: const Text('Perte, vol ou dommages aux bagages'),
                value: _includesBaggage,
                onChanged: (value) {
                  setState(() => _includesBaggage = value);
                },
                secondary: const Icon(Icons.work),
              ),

              const SizedBox(height: 24),

              // Activités
              Text(
                'Activités prévues',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Sélectionnez les activités que vous prévoyez de pratiquer',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _activitiesOptions.map((activity) {
                  final isSelected = _activities.contains(activity);
                  return FilterChip(
                    label: Text(activity),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _activities.add(activity);
                        } else {
                          _activities.remove(activity);
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
                backgroundColor: Colors.teal,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

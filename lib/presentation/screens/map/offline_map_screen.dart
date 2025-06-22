import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_flutter_app/domain/entities/office.dart';
import 'package:my_flutter_app/services/map_service.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

final officesProvider =
    StateNotifierProvider<OfficesNotifier, AsyncValue<List<Office>>>((ref) {
  return OfficesNotifier(ref.watch(mapServiceProvider));
});

class OfficesNotifier extends StateNotifier<AsyncValue<List<Office>>> {
  final MapService _mapService;

  OfficesNotifier(this._mapService) : super(const AsyncValue.data([]));

  Future<void> loadOffices() async {
    try {
      state = const AsyncValue.loading();
      final offices = await _mapService.fetchOfficesFromAPI();
      await _mapService.cacheOffices(offices);
      state = AsyncValue.data(offices);
    } catch (error, stackTrace) {
      try {
        final cachedOffices = await _mapService.getCachedOffices();
        if (cachedOffices.isNotEmpty) {
          state = AsyncValue.data(cachedOffices);
        } else {
          state = AsyncValue.error(error, stackTrace);
        }
      } catch (e) {
        state = AsyncValue.error(error, stackTrace);
      }
    }
  }
}

// Debouncer pour éviter les refresh trop fréquents
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }
}

class OfficeMarker extends StatelessWidget {
  final Office office;
  final VoidCallback onTap;
  const OfficeMarker({super.key, required this.office, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on,
            color: office.isOpen ? Colors.green : Colors.red,
            size: 40,
          ),
          if (office.isOpen)
            Text(
              office.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}

class MapControls extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onResetRotation;
  final VoidCallback onMyLocationPressed;
  final bool isLocating;

  const MapControls({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onResetRotation,
    required this.onMyLocationPressed,
    required this.isLocating,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Boussole
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.compass_calibration),
            onPressed: onResetRotation,
          ),
        ),
        // Bouton de localisation
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: isLocating
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location),
            onPressed: isLocating ? null : onMyLocationPressed,
          ),
        ),
        // Contrôles de zoom
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: onZoomIn,
              ),
              Container(
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: onZoomOut,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OfflineMapScreen extends ConsumerStatefulWidget {
  const OfflineMapScreen({super.key});

  @override
  ConsumerState<OfflineMapScreen> createState() => _OfflineMapScreenState();
}

class _OfflineMapScreenState extends ConsumerState<OfflineMapScreen> {
  final MapController _mapController = MapController();
  static const LatLng _defaultLocation = LatLng(5.325226, -4.019603); // Abidjan
  LatLng? _userLocation;
  static const Distance distance = Distance();
  bool _isLocating = false;
  final _refreshDebouncer = Debouncer(delay: const Duration(seconds: 2));
  double _currentZoom = 12;
  LatLng _currentCenter = _defaultLocation;

  @override
  void initState() {
    super.initState();
    _initializeMapAndLoadOffices();
  }

  List<Office> _filterOffices(List<Office> offices, LatLng? userLocation) {
    if (userLocation == null) return offices;
    return offices.where((office) {
      final dist = distance(userLocation, office.location);
      return dist < 5000; // 5 km
    }).toList()
      ..sort((a, b) {
        final distA = distance(userLocation, a.location);
        final distB = distance(userLocation, b.location);
        return distA.compareTo(distB);
      });
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 1).clamp(1.0, 18.0);
    });
    _mapController.move(_currentCenter, _currentZoom);
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 1).clamp(1.0, 18.0);
    });
    _mapController.move(_currentCenter, _currentZoom);
  }

  void _resetRotation() {
    _mapController.rotate(0);
  }

  @override
  Widget build(BuildContext context) {
    final officesAsync = ref.watch(officesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: const Text('Bureaux'),
        actions: [
          if (_userLocation != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _refreshDebouncer.run(() {
                ref.read(officesProvider.notifier).loadOffices();
              }),
            ),
        ],
      ),
      body: _isLocating && _userLocation == null
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Recherche de votre position...'),
                ],
              ),
            )
          : officesAsync.when(
              data: (offices) {
                final filteredOffices = _filterOffices(offices, _userLocation);
                return Stack(
                  children: [
                    FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: _currentCenter,
                        initialZoom: _currentZoom,
                        onTap: (_, __) {},
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.my_flutter_app',
                          tileProvider: NetworkTileProvider(),
                          tileBuilder: (context, tileWidget, tile) {
                            final tileKey =
                                '${tile.coordinates.z}/${tile.coordinates.x}/${tile.coordinates.y}';
                            ref.read(mapServiceProvider).cacheTile(tileKey,
                                'https://tile.openstreetmap.org/${tile.coordinates.z}/${tile.coordinates.x}/${tile.coordinates.y}.png');
                            return tileWidget;
                          },
                        ),
                        MarkerLayer(
                          markers: [
                            ...filteredOffices.map((office) => Marker(
                                  point: office.location,
                                  width: 80,
                                  height: 80,
                                  child: OfficeMarker(
                                    office: office,
                                    onTap: () => _showOfficeDetails(office),
                                  ),
                                )),
                            if (_userLocation != null)
                              Marker(
                                point: _userLocation!,
                                width: 40,
                                height: 40,
                                child: const Icon(Icons.my_location,
                                    color: Colors.blue, size: 40),
                              ),
                          ],
                        ),
                      ],
                    ),
                    // Contrôles de la carte
                    Positioned(
                      right: 16,
                      top: 100,
                      child: MapControls(
                        onZoomIn: _zoomIn,
                        onZoomOut: _zoomOut,
                        onResetRotation: _resetRotation,
                        onMyLocationPressed: _initializeMapAndLoadOffices,
                        isLocating: _isLocating,
                      ),
                    ),
                    if (_userLocation != null &&
                        offices.isNotEmpty &&
                        filteredOffices.isEmpty)
                      Positioned(
                        top: 16,
                        left: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.white),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Aucun bureau trouvé à moins de 5km de votre position',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'Erreur de chargement',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: () => ref
                                .read(officesProvider.notifier)
                                .loadOffices(),
                            child: const Text('Réessayer'),
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton(
                            onPressed: () => _initializeMapAndLoadOffices(),
                            child: const Text('Actualiser la position'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _showOfficeDetails(Office office) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              office.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(office.address),
            const SizedBox(height: 4),
            Text('Tél: ${office.phone}'),
            const SizedBox(height: 4),
            Text('Email: ${office.email}'),
            const SizedBox(height: 8),
            Text(
              'Services:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children: office.services
                  .map((service) => Chip(label: Text(service)))
                  .toList(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  office.isOpen ? Icons.check_circle : Icons.cancel,
                  color: office.isOpen ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 8),
                Text(
                  office.isOpen ? 'Ouvert' : 'Fermé',
                  style: TextStyle(
                    color: office.isOpen ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _initializeMapAndLoadOffices() async {
    if (_isLocating) return;
    setState(() => _isLocating = true);
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Activez les services de localisation')),
          );
        }
        setState(() => _isLocating = false);
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLocating = false);
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Permission requise'),
              content:
                  const Text('Activez la localisation dans les paramètres'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Annuler'),
                ),
                TextButton(
                  onPressed: () => Geolocator.openAppSettings(),
                  child: const Text('Paramètres'),
                ),
              ],
            ),
          );
        }
        setState(() => _isLocating = false);
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(seconds: 10),
      );
      if (mounted) {
        setState(() {
          _userLocation = LatLng(position.latitude, position.longitude);
          _currentCenter = _userLocation!;
          _currentZoom = 14;
        });
        await ref.read(officesProvider.notifier).loadOffices();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de localisation: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLocating = false);
    }
  }
}

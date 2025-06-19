import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_flutter_app/domain/entities/office.dart';
import 'package:my_flutter_app/services/map_service.dart';

final officesProvider =
    StateNotifierProvider<OfficesNotifier, AsyncValue<List<Office>>>((ref) {
  return OfficesNotifier(ref.watch(mapServiceProvider));
});

class OfficesNotifier extends StateNotifier<AsyncValue<List<Office>>> {
  final MapService _mapService;

  OfficesNotifier(this._mapService) : super(const AsyncValue.loading()) {
    _loadOffices();
  }

  Future<void> _loadOffices() async {
    try {
      state = const AsyncValue.loading();
      final offices = await _mapService.getCachedOffices();
      state = AsyncValue.data(offices);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshOffices() async {
    // TODO: Implement API call to fetch offices
    // For now, we'll just use cached data
    await _loadOffices();
  }
}

class OfflineMapScreen extends ConsumerStatefulWidget {
  const OfflineMapScreen({super.key});

  @override
  ConsumerState<OfflineMapScreen> createState() => _OfflineMapScreenState();
}

class _OfflineMapScreenState extends ConsumerState<OfflineMapScreen> {
  final MapController _mapController = MapController();
  static const LatLng _defaultLocation = LatLng(48.8566, 2.3522); // Paris

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
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(officesProvider.notifier).refreshOffices(),
          ),
        ],
      ),
      body: officesAsync.when(
        data: (offices) => FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: _defaultLocation,
            initialZoom: 12,
            onTap: (_, __) {
              // Handle map tap
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.my_flutter_app',
              tileProvider: NetworkTileProvider(),
              tileBuilder: (context, tileWidget, tile) {
                // Check if tile is cached
                final tileKey =
                    '${tile.coordinates.z}/${tile.coordinates.x}/${tile.coordinates.y}';

                // Cache new tile asynchronously
                ref.read(mapServiceProvider).cacheTile(tileKey,
                    'https://tile.openstreetmap.org/${tile.coordinates.z}/${tile.coordinates.x}/${tile.coordinates.y}.png');

                return tileWidget;
              },
            ),
            MarkerLayer(
              markers: offices.map((office) {
                return Marker(
                  point: office.location,
                  width: 40,
                  height: 40,
                  child: GestureDetector(
                    onTap: () => _showOfficeDetails(office),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Erreur: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(officesProvider.notifier).refreshOffices(),
                child: const Text('Réessayer'),
              ),
            ],
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
}

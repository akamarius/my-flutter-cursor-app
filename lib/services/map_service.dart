import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/entities/office.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

final mapServiceProvider = Provider<MapService>((ref) => MapService());

class MapService {
  static const String _officesKey = 'cached_offices';
  static const String _tilesKey = 'cached_tiles';

  Future<void> initialize() async {
    // Initialisation simple sans Hive
    await _loadDefaultOffices();
  }

  Future<void> _loadDefaultOffices() async {
    // Données de démonstration
    final defaultOffices = [
      const Office(
        id: '1',
        name: 'Bureau Principal',
        services: ['Assurance', 'Réparation', 'Réclamation'],
        address: '123 Rue de la Paix, Paris',
        location: LatLng(48.8566, 2.3522),
        phone: '+33 1 23 45 67 89',
        email: 'contact@assurance.fr',
        description: 'Bureau principal de l\'assurance',
        isOpen: true,
      ),
      const Office(
        id: '2',
        name: 'Agence Lyon',
        services: ['Assurance', 'Réparation', 'Réclamation'],
        address: '456 Avenue des Champs, Lyon',
        location: LatLng(45.7578, 4.8320),
        phone: '+33 4 78 12 34 56',
        email: 'lyon@assurance.fr',
        description: 'Agence de Lyon',
        isOpen: true,
      ),
      const Office(
        id: '3',
        name: 'Agence Marseille',
        services: ['Assurance', 'Réparation', 'Réclamation'],
        address: '789 Boulevard du Port, Marseille',
        location: LatLng(43.2965, 5.3698),
        phone: '+33 4 91 23 45 67',
        email: 'marseille@assurance.fr',
        description: 'Agence de Marseille',
        isOpen: false,
      ),
    ];

    await _cacheOffices(defaultOffices);
  }

  Future<void> _cacheOffices(List<Office> offices) async {
    final prefs = await SharedPreferences.getInstance();
    final officesJson = offices.map((office) => office.toJson()).toList();
    await prefs.setString(_officesKey, jsonEncode(officesJson));
  }

  Future<List<Office>> getCachedOffices() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final officesJson = prefs.getString(_officesKey);
      if (officesJson != null) {
        final List<dynamic> officesList = jsonDecode(officesJson);
        return officesList.map((json) => Office.fromJson(json)).toList();
      }
    } catch (e) {
      // En cas d'erreur, retourner des données par défaut
    }
    
    // Retourner des données par défaut
    return [
      const Office(
        id: '1',
        name: 'Bureau Principal',
        services: ['Assurance', 'Réparation', 'Réclamation'],
        address: '123 Rue de la Paix, Paris',
        location: LatLng(48.8566, 2.3522),
        phone: '+33 1 23 45 67 89',
        email: 'contact@assurance.fr',
        description: 'Bureau principal de l\'assurance',
        isOpen: true,
      ),
    ];
  }

  Future<String?> getCachedTile(String tileKey) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('$_tilesKey$tileKey');
    } catch (e) {
      return null;
    }
  }

  Future<void> cacheTile(String tileKey, String tileUrl) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('$_tilesKey$tileKey', tileUrl);
    } catch (e) {
      // Ignorer les erreurs de cache
    }
  }

  Future<void> addOffice(Office office) async {
    final offices = await getCachedOffices();
    offices.add(office);
    await _cacheOffices(offices);
  }

  Future<void> removeOffice(String officeId) async {
    final offices = await getCachedOffices();
    offices.removeWhere((office) => office.id == officeId);
    await _cacheOffices(offices);
  }
} 
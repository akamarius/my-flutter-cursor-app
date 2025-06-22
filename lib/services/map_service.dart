import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/domain/entities/office.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      /*const Office(
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
      ),*/
      const Office(
        id: 'SAN-1',
        name: 'Siège Social Sanlam Côte d\'Ivoire',
        services: ['Assurance vie', 'Épargne', 'Retraite', 'Investissement'],
        address: 'Immeuble CCIA Plateau, Avenue Jean-Paul II, Abidjan',
        location: LatLng(5.3204, -4.0161),
        phone: '+225 20 30 40 50',
        email: 'contact@sanlam.ci',
        description: 'Bureau principal de Sanlam en Côte d\'Ivoire',
        isOpen: true,
      ),
      const Office(
        id: 'SAN-2',
        name: 'Agence Sanlam Cocody',
        services: ['Assurance vie', 'Épargne', 'Réclamation'],
        address: 'Rue des Jardins, Cocody, Abidjan',
        location: LatLng(5.3541, -3.9698),
        phone: '+225 20 31 41 51',
        email: 'cocody@sanlam.ci',
        description: 'Agence Sanlam Cocody',
        isOpen: true,
      ),
      const Office(
        id: 'SAN-3',
        name: 'Agence Sanlam Yopougon',
        services: ['Assurance vie', 'Épargne', 'Retraite'],
        address: 'Boulevard de la Paix, Yopougon, Abidjan',
        location: LatLng(5.3247, -4.0838),
        phone: '+225 20 32 42 52',
        email: 'yopougon@sanlam.ci',
        description: 'Agence Sanlam Yopougon',
        isOpen: true,
      ),
      const Office(
        id: 'ALL-1',
        name: 'Direction Générale Allianz Côte d\'Ivoire',
        services: ['Assurance auto', 'Assurance habitation', 'Santé', 'Voyage'],
        address: 'Immeuble Allianz, Boulevard Latrille, Plateau, Abidjan',
        location: LatLng(5.3188, -4.0176),
        phone: '+225 20 21 31 41',
        email: 'info@allianz.ci',
        description: 'Siège social d\'Allianz en Côte d\'Ivoire',
        isOpen: true,
      ),
      const Office(
        id: 'ALL-2',
        name: 'Agence Allianz Marcory',
        services: ['Assurance auto', 'Réclamation', 'Assurance entreprise'],
        address: 'Rue du Commerce, Marcory, Abidjan',
        location: LatLng(5.3097, -3.9883),
        phone: '+225 20 22 32 42',
        email: 'marcory@allianz.ci',
        description: 'Agence Allianz Marcory',
        isOpen: true,
      ),
      const Office(
        id: 'ALL-3',
        name: 'Agence Allianz Treichville',
        services: [
          'Assurance moto',
          'Assurance habitation',
          'Protection juridique'
        ],
        address: 'Avenue 12, Treichville, Abidjan',
        location: LatLng(5.2926, -4.0078),
        phone: '+225 20 23 33 43',
        email: 'treichville@allianz.ci',
        description: 'Agence Allianz Treichville',
        isOpen: false, // (Exemple de fermeture temporaire)
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
      /*const Office(
        id: '1',
        name: 'Bureau Principal',
        services: ['Assurance', 'Réparation', 'Réclamation'],
        address: '123 Rue de la Paix, Paris',
        location: LatLng(48.8566, 2.3522),
        phone: '+33 1 23 45 67 89',
        email: 'contact@assurance.fr',
        description: 'Bureau principal de l\'assurance',
        isOpen: true,
      ),*/
      const Office(
        id: 'SAN-1',
        name: 'Siège Social Sanlam Côte d\'Ivoire',
        services: ['Assurance vie', 'Épargne', 'Retraite', 'Investissement'],
        address: 'Immeuble CCIA Plateau, Avenue Jean-Paul II, Abidjan',
        location: LatLng(5.3204, -4.0161),
        phone: '+225 20 30 40 50',
        email: 'contact@sanlam.ci',
        description: 'Bureau principal de Sanlam en Côte d\'Ivoire',
        isOpen: true,
      ),
      const Office(
        id: 'SAN-2',
        name: 'Agence Sanlam Cocody',
        services: ['Assurance vie', 'Épargne', 'Réclamation'],
        address: 'Rue des Jardins, Cocody, Abidjan',
        location: LatLng(5.3541, -3.9698),
        phone: '+225 20 31 41 51',
        email: 'cocody@sanlam.ci',
        description: 'Agence Sanlam Cocody',
        isOpen: true,
      ),
      const Office(
        id: 'SAN-3',
        name: 'Agence Sanlam Yopougon',
        services: ['Assurance vie', 'Épargne', 'Retraite'],
        address: 'Boulevard de la Paix, Yopougon, Abidjan',
        location: LatLng(5.3247, -4.0838),
        phone: '+225 20 32 42 52',
        email: 'yopougon@sanlam.ci',
        description: 'Agence Sanlam Yopougon',
        isOpen: true,
      ),
      const Office(
        id: 'ALL-1',
        name: 'Direction Générale Allianz Côte d\'Ivoire',
        services: ['Assurance auto', 'Assurance habitation', 'Santé', 'Voyage'],
        address: 'Immeuble Allianz, Boulevard Latrille, Plateau, Abidjan',
        location: LatLng(5.3188, -4.0176),
        phone: '+225 20 21 31 41',
        email: 'info@allianz.ci',
        description: 'Siège social d\'Allianz en Côte d\'Ivoire',
        isOpen: true,
      ),
      const Office(
        id: 'ALL-2',
        name: 'Agence Allianz Marcory',
        services: ['Assurance auto', 'Réclamation', 'Assurance entreprise'],
        address: 'Rue du Commerce, Marcory, Abidjan',
        location: LatLng(5.3097, -3.9883),
        phone: '+225 20 22 32 42',
        email: 'marcory@allianz.ci',
        description: 'Agence Allianz Marcory',
        isOpen: true,
      ),
      const Office(
        id: 'ALL-3',
        name: 'Agence Allianz Treichville',
        services: [
          'Assurance moto',
          'Assurance habitation',
          'Protection juridique'
        ],
        address: 'Avenue 12, Treichville, Abidjan',
        location: LatLng(5.2926, -4.0078),
        phone: '+225 20 23 33 43',
        email: 'treichville@allianz.ci',
        description: 'Agence Allianz Treichville',
        isOpen: false, // (Exemple de fermeture temporaire)
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

  Future<List<Office>> fetchOfficesFromAPI() async {
    // Remplacez l'URL par celle de votre API réelle
    final url = Uri.parse('https://api.example.com/offices');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((json) => Office.fromJson(json)).toList();
    } else {
      throw Exception('Erreur lors du chargement des bureaux');
    }
  }

  Future<void> cacheOffices(List<Office> offices) async {
    final prefs = await SharedPreferences.getInstance();
    final officesJson = offices.map((office) => office.toJson()).toList();
    await prefs.setString(_officesKey, jsonEncode(officesJson));
  }
}

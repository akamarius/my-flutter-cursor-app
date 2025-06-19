import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_flutter_app/core/config/supabase_config.dart';

class SupabaseService {
  static SupabaseService? _instance;
  static SupabaseClient? _client;

  SupabaseService._();

  static SupabaseService get instance {
    _instance ??= SupabaseService._();
    return _instance!;
  }

  static SupabaseClient get client {
    if (_client == null) {
      throw Exception('Supabase not initialized. Call initialize() first.');
    }
    return _client!;
  }

  /// Initialise Supabase avec les clés de configuration
  static Future<void> initialize() async {
    try {
      await Supabase.initialize(
        url: SupabaseConfig.supabaseUrlConfig,
        anonKey: SupabaseConfig.supabaseAnonKeyConfig,
      );
      _client = Supabase.instance.client;
    } catch (e) {
      throw Exception('Failed to initialize Supabase: $e');
    }
  }

  /// Obtient l'instance du client Supabase
  static SupabaseClient get supabase => client;

  /// Obtient l'instance de l'authentification
  static GoTrueClient get auth => client.auth;

  /// Obtient l'instance de la base de données
  static SupabaseQueryBuilder get database => client.from('');

  /// Obtient l'instance du stockage
  static SupabaseStorageClient get storage => client.storage;

  /// Vérifie si l'utilisateur est connecté
  static bool get isAuthenticated => auth.currentUser != null;

  /// Obtient l'utilisateur actuel
  static User? get currentUser => auth.currentUser;

  /// Déconnexion
  static Future<void> signOut() async {
    await auth.signOut();
  }

  /// Écoute les changements d'authentification
  static Stream<AuthState> get authStateChanges => auth.onAuthStateChange;
}

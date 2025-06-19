import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_flutter_app/services/supabase_service.dart';

class SupabaseAuthRepository {
  final SupabaseClient _supabase = SupabaseService.supabase;

  /// Connexion avec email et mot de passe
  Future<AuthResponse> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  /// Inscription avec email et mot de passe
  Future<AuthResponse> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  /// Déconnexion
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  /// Obtient l'utilisateur actuel
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  /// Écoute les changements d'authentification
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  /// Vérifie si l'utilisateur est connecté
  bool get isAuthenticated => _supabase.auth.currentUser != null;
}

class SupabaseConfig {
  // Configuration par défaut pour le développement
  // En production, remplacez par vos vraies clés Supabase
  static const String supabaseUrl = 'https://yfmoanmgxbxkuynieeru.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlmbW9hbm1neGJ4a3V5bmllZXJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAyNDcwMjYsImV4cCI6MjA2NTgyMzAyNn0.gw5CtDuiEqSAGZQXrfCcURIfbtAfpCAagYRZdwRnH38';

  // Configuration pour différents environnements
  static const String devUrl = 'https://yfmoanmgxbxkuynieeru.supabase.co';
  static const String devAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlmbW9hbm1neGJ4a3V5bmllZXJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAyNDcwMjYsImV4cCI6MjA2NTgyMzAyNn0.gw5CtDuiEqSAGZQXrfCcURIfbtAfpCAagYRZdwRnH38';

  static const String prodUrl = 'https://yfmoanmgxbxkuynieeru.supabase.coo';
  static const String prodAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlmbW9hbm1neGJ4a3V5bmllZXJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAyNDcwMjYsImV4cCI6MjA2NTgyMzAyNn0.gw5CtDuiEqSAGZQXrfCcURIfbtAfpCAagYRZdwRnH38';

  // Méthode pour obtenir la configuration selon l'environnement
  static String get url {
    const environment =
        String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
    return environment == 'prod' ? prodUrl : devUrl;
  }

  static String get anonKey {
    const environment =
        String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
    return environment == 'prod' ? prodAnonKey : devAnonKey;
  }
}

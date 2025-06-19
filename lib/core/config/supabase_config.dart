class SupabaseConfig {
  // Remplacez ces valeurs par vos vraies clés Supabase
  static const String supabaseUrl = 'https://yfmoanmgxbxkuynieeru.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlmbW9hbm1neGJ4a3V5bmllZXJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAyNDcwMjYsImV4cCI6MjA2NTgyMzAyNn0.gw5CtDuiEqSAGZQXrfCcURIfbtAfpCAagYRZdwRnH38';

  // Configuration pour le développement
  static const String devSupabaseUrl =
      'https://yfmoanmgxbxkuynieeru.supabase.co';
  static const String devSupabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlmbW9hbm1neGJ4a3V5bmllZXJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAyNDcwMjYsImV4cCI6MjA2NTgyMzAyNn0.gw5CtDuiEqSAGZQXrfCcURIfbtAfpCAagYRZdwRnH38';

  // Configuration pour la production
  static const String prodSupabaseUrl =
      'https://yfmoanmgxbxkuynieeru.supabase.co';
  static const String prodSupabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlmbW9hbm1neGJ4a3V5bmllZXJ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTAyNDcwMjYsImV4cCI6MjA2NTgyMzAyNn0.gw5CtDuiEqSAGZQXrfCcURIfbtAfpCAagYRZdwRnH38';

  // Obtenir la configuration selon l'environnement
  static String get supabaseUrlConfig {
    const environment =
        String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
    return environment == 'prod' ? prodSupabaseUrl : devSupabaseUrl;
  }

  static String get supabaseAnonKeyConfig {
    const environment =
        String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
    return environment == 'prod' ? prodSupabaseAnonKey : devSupabaseAnonKey;
  }
}

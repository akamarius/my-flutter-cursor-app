# Configuration Supabase

## 1. Créer un projet Supabase

1. Allez sur [supabase.com](https://supabase.com)
2. Créez un nouveau projet
3. Notez votre URL et votre clé anonyme

## 2. Configurer les clés

Modifiez le fichier `lib/core/config/supabase_config.dart` :

```dart
class SupabaseConfig {
  // Remplacez par vos vraies clés
  static const String devSupabaseUrl = 'https://your-project.supabase.co';
  static const String devSupabaseAnonKey = 'your-anon-key';
  
  static const String prodSupabaseUrl = 'https://your-project.supabase.co';
  static const String prodSupabaseAnonKey = 'your-anon-key';
}
```

## 3. Initialisation

Supabase est automatiquement initialisé dans `main.dart` :

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialiser Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialiser Supabase
  await SupabaseService.initialize();
  
  runApp(const ProviderScope(child: MyApp()));
}
```

## 4. Utilisation

### Authentification
```dart
final authRepo = SupabaseAuthRepository();

// Connexion
await authRepo.signInWithEmailAndPassword(
  email: 'user@example.com',
  password: 'password',
);

// Inscription
await authRepo.signUpWithEmailAndPassword(
  email: 'user@example.com',
  password: 'password',
);
```

### Base de données
```dart
final supabase = SupabaseService.supabase;

// Lire des données
final data = await supabase
  .from('table_name')
  .select()
  .execute();

// Insérer des données
await supabase
  .from('table_name')
  .insert({'column': 'value'})
  .execute();
```

### Stockage
```dart
final storage = SupabaseService.storage;

// Uploader un fichier
await storage
  .from('bucket_name')
  .upload('path/to/file.jpg', fileBytes);
```

## 5. Variables d'environnement (Optionnel)

Pour utiliser des variables d'environnement :

```bash
# Développement
flutter run --dart-define=ENVIRONMENT=dev

# Production
flutter run --dart-define=ENVIRONMENT=prod
```

## 6. Sécurité

- Ne partagez jamais vos clés de service
- Utilisez Row Level Security (RLS) dans Supabase
- Validez les données côté serveur 
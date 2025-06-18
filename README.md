# Gestion Sinistres - Application Flutter

Application mobile professionnelle de gestion de sinistres développée avec Flutter et une architecture propre.

## 🚀 Fonctionnalités

### ✅ Fonctionnalités implémentées

- **Interface utilisateur moderne**
  - Design Material 3 avec thème sombre/clair
  - Animations fluides et transitions
  - Navigation intuitive avec Go Router
  - Interface responsive et accessible

- **Gestion des sinistres**
  - Déclaration de nouveaux sinistres avec photos
  - Liste des sinistres avec statuts (En attente, En cours, Résolu, Rejeté)
  - Détails complets des sinistres
  - Géolocalisation automatique
  - Notes et descriptions

- **Carte interactive**
  - Carte hors ligne avec cache local
  - Localisation des bureaux d'assurance
  - Géolocalisation utilisateur
  - Marqueurs interactifs

- **Demande de cotation**
  - Formulaire de demande personnalisé
  - Types d'assurance multiples (Auto, Habitation, Vie, Santé, Voyage)
  - Niveaux de couverture (Basic, Standard, Comprehensive, Premium)
  - Simulation de calcul de devis

- **Profil utilisateur**
  - Informations personnelles
  - Actions rapides vers les fonctionnalités principales
  - Paramètres de l'application
  - Gestion des notifications

- **Architecture propre**
  - Clean Architecture (Domain/Data/Presentation)
  - State Management avec Riverpod
  - Séparation des responsabilités
  - Code modulaire et maintenable

## 🛠️ Configuration

### Prérequis

- **Flutter SDK** : 3.2.3 ou supérieur
- **Dart SDK** : 3.2.3 ou supérieur
- **Android Studio** / **VS Code** avec extensions Flutter
- **Émulateur Android** ou **appareil physique**
- **Git** pour la gestion de version

### Installation rapide

1. **Cloner le projet**
   ```bash
   git clone <repository-url>
   cd my-flutter-cursor-app
   ```

2. **Installer les dépendances**
   ```bash
   flutter pub get
   ```

3. **Générer les fichiers de code**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Lancer l'application**
   ```bash
   flutter run
   ```

### Configuration pour Windows

Si vous rencontrez des problèmes de symlinks sur Windows :

1. **Activer le mode développeur**
   ```bash
   start ms-settings:developers
   ```
   Puis activer "Mode développeur" dans les paramètres Windows.

2. **Ou utiliser la configuration alternative**
   L'application est configurée pour fonctionner sans symlinks sur Windows.

## 🚀 Démarrage

### Mode développement (recommandé)

L'application fonctionne immédiatement avec des données de démonstration :

```bash
# Lancer l'application
flutter run

# Ou spécifier un device
flutter run -d <device-id>

# Mode debug avec hot reload
flutter run --hot
```

### Build pour production

```bash
# Build APK pour Android
flutter build apk --release

# Build App Bundle pour Google Play
flutter build appbundle --release

# Build pour iOS (macOS requis)
flutter build ios --release
```

### Tests

```bash
# Tests unitaires
flutter test

# Tests d'intégration
flutter test integration_test/

# Tests avec couverture
flutter test --coverage
```

## 📱 Utilisation

### Navigation principale

- **Accueil** : Vue d'ensemble et actions rapides
- **Mes Sinistres** : Consulter et déclarer des sinistres
- **Carte** : Localiser les bureaux d'assurance
- **Cotation** : Demander un devis personnalisé
- **Profil** : Gérer votre compte et paramètres

### Déclaration d'un sinistre

1. Accédez à "Nouveau Sinistre"
2. Remplissez la description du sinistre
3. Ajoutez des photos (jusqu'à 5)
4. Ajoutez des notes supplémentaires
5. La géolocalisation est automatique
6. Soumettez la déclaration

### Demande de cotation

1. Accédez à "Cotation"
2. Remplissez vos informations personnelles
3. Sélectionnez le type d'assurance
4. Choisissez le niveau de couverture
5. Soumettez votre demande

## 🏗️ Architecture

```
lib/
├── config/           # Configuration (router, thème)
│   ├── router.dart   # Navigation avec Go Router
│   └── theme.dart    # Thèmes Material 3
├── core/            # Code métier central
│   └── config/      # Configuration Firebase/Supabase
├── data/            # Couche données
│   ├── datasources/ # Sources de données (API, local)
│   └── repositories/# Implémentation des repositories
├── domain/          # Entités et interfaces
│   ├── entities/    # Modèles de données
│   └── repositories/# Interfaces des repositories
├── presentation/    # Interface utilisateur
│   ├── providers/   # State management avec Riverpod
│   ├── screens/     # Écrans de l'application
│   └── widgets/     # Composants réutilisables
└── services/        # Services externes (maps, notifications)
```

### Technologies utilisées

- **State Management** : Riverpod (Provider pattern)
- **Navigation** : Go Router (Déclarative)
- **UI** : Material 3 + Flutter Animate
- **Maps** : Flutter Map (OpenStreetMap)
- **Storage** : SharedPreferences (local)
- **Géolocalisation** : Geolocator
- **Images** : Image Picker + Cached Network Image

## 📦 Dépendances principales

### Production
- `flutter_riverpod` : Gestion d'état réactive
- `go_router` : Navigation déclarative
- `flutter_map` : Cartes interactives
- `geolocator` : Géolocalisation
- `image_picker` : Sélection d'images
- `shared_preferences` : Stockage local
- `flutter_animate` : Animations fluides

### Développement
- `build_runner` : Génération de code
- `freezed` : Classes immutables
- `json_serializable` : Sérialisation JSON
- `riverpod_generator` : Génération de providers

## 🔧 Développement

### Génération de code

Après modification des modèles ou annotations :

```bash
# Générer tous les fichiers
flutter packages pub run build_runner build --delete-conflicting-outputs

# Générer en mode watch (développement)
flutter packages pub run build_runner watch
```

### Linting et formatage

```bash
# Analyse statique
flutter analyze

# Formatage automatique
dart format lib/

# Vérification des dépendances
flutter pub outdated
```

### Structure des tests

```
test/
├── unit/           # Tests unitaires
├── widget/         # Tests de widgets
└── integration/    # Tests d'intégration
```

## 🚨 Résolution des problèmes

### Erreurs courantes

1. **Dépendances manquantes**
   ```bash
   flutter clean
   flutter pub get
   ```

2. **Fichiers générés manquants**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

3. **Problèmes de cache**
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

4. **Problèmes Windows (symlinks)**
   - Activer le mode développeur Windows
   - Ou utiliser la configuration alternative incluse

### Support

Pour toute question ou problème :
- Vérifiez les logs de l'application
- Consultez la documentation Flutter
- Vérifiez la console pour les erreurs détaillées

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
- Signaler des bugs
- Proposer des améliorations
- Soumettre des pull requests

## 🎯 Roadmap

### Fonctionnalités futures
- [ ] Authentification Firebase/Supabase
- [ ] Notifications push
- [ ] Mode hors ligne complet
- [ ] Synchronisation cloud
- [ ] Analytics et monitoring
- [ ] Tests automatisés complets

---

**Version** : 1.0.0  
**Dernière mise à jour** : Décembre 2024  
**Flutter** : 3.2.3+  
**Dart** : 3.2.3+  
**Statut** : ✅ Prêt pour la production

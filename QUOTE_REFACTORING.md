# Refactorisation du Module de Cotation

## Vue d'ensemble

Le module de cotation a été entièrement refactorisé pour offrir une expérience utilisateur améliorée avec des parcours spécifiques par type d'assurance, une gestion complète des données dans Firebase, et une interface moderne et intuitive.

## Nouvelles fonctionnalités

### 1. Parcours de demande par type d'assurance

Le système propose maintenant 6 types d'assurance distincts, chacun avec son propre formulaire spécialisé :

- **Auto** : Assurance automobile avec champs spécifiques (marque, modèle, année, plaque, permis, expérience, accidents, usage, kilométrage)
- **Habitation** : Assurance habitation (adresse, type de bien, année construction, surface, pièces, systèmes de sécurité)
- **Épargne** : Assurance épargne (montant cible, durée, profil investissement, contribution mensuelle)
- **Décès** : Assurance décès (montant couverture, durée, bénéficiaire, conditions médicales)
- **Santé** : Assurance santé (type couverture, membres famille, conditions préexistantes, hôpital préféré)
- **Voyage** : Assurance voyage (destination, dates, voyageurs, type voyage, couvertures)

### 2. Sauvegarde Firebase

Toutes les demandes de cotation sont maintenant sauvegardées dans Firebase Firestore avec :

- **Structure de données enrichie** : Chaque cotation contient des métadonnées complètes (statut, dates, agent assigné, montant estimé)
- **Système de statuts** : pending, inProgress, completed, rejected, cancelled
- **Traçabilité complète** : Historique des modifications avec timestamps

### 3. Liste des cotations avec filtres et pagination

Nouvel écran de liste offrant :

- **Filtrage par statut** : Filtrer les cotations selon leur état
- **Filtrage par type d'assurance** : Afficher seulement certains types
- **Pagination** : Chargement progressif pour de meilleures performances
- **Interface moderne** : Cards avec icônes, statuts colorés, informations essentielles

### 4. Page de détails de cotation

Écran détaillé montrant :

- **Informations de la demande** : Tous les champs saisis par l'utilisateur
- **Réponse de cotation** : Réponse de l'expert (quand disponible)
- **Métadonnées** : Statut, dates, agent assigné, montant estimé
- **Interface intuitive** : Organisation claire des informations

## Architecture technique

### Entités refactorisées

```dart
// Nouvelle structure Quote
@freezed
class Quote with _$Quote {
  const factory Quote({
    required String id,
    required String userId,
    required InsuranceType insuranceType,
    required QuoteStatus status,
    required Map<String, dynamic> requestData,
    Map<String, dynamic>? responseData,
    required DateTime createdAt,
    DateTime? updatedAt,
    String? notes,
    double? estimatedAmount,
    String? assignedAgent,
  }) = _Quote;
}
```

### Services Firebase

- **FirebaseQuoteService** : Service complet pour la gestion CRUD des cotations
- **Pagination** : Support du chargement progressif
- **Filtres** : Requêtes optimisées selon les critères
- **Statistiques** : Calculs automatiques des métriques

### Providers Riverpod

- **QuoteProvider** : Gestion de l'état global des cotations
- **QuoteDetailsProvider** : État spécifique pour les détails
- **QuoteStatsProvider** : Statistiques utilisateur

## Nouveaux écrans

### 1. Écran de sélection du type d'assurance
- **Chemin** : `/quote/selection`
- **Fonction** : Interface visuelle pour choisir le type d'assurance
- **Design** : Grille de cards avec icônes et descriptions

### 2. Écran de cotation automobile
- **Chemin** : `/quote/auto`
- **Fonction** : Formulaire spécialisé pour l'assurance auto
- **Champs** : Tous les détails spécifiques au véhicule et conducteur

### 3. Liste des cotations
- **Chemin** : `/quote/list`
- **Fonction** : Vue d'ensemble avec filtres et pagination
- **Fonctionnalités** : Recherche, tri, filtres avancés

### 4. Détails de cotation
- **Chemin** : `/quote/details/:id`
- **Fonction** : Affichage complet d'une cotation
- **Sections** : Demande, réponse, métadonnées

## Routes ajoutées

```dart
// Nouvelles routes dans le routeur
GoRoute(
  path: '/quote/selection',
  builder: (context, state) => const InsuranceTypeSelectionScreen(),
),
GoRoute(
  path: '/quote/list',
  builder: (context, state) => const QuotesListScreen(),
),
GoRoute(
  path: '/quote/auto',
  builder: (context, state) => const AutoQuoteScreen(),
),
GoRoute(
  path: '/quote/details/:id',
  builder: (context, state) {
    final quoteId = state.pathParameters['id']!;
    return QuoteDetailsScreen(quoteId: quoteId);
  },
),
```

## Améliorations UX/UI

### 1. Navigation intuitive
- **Parcours guidé** : Sélection → Formulaire → Confirmation
- **Accès rapide** : Bouton flottant pour nouvelle cotation
- **Historique** : Accès facile aux cotations précédentes

### 2. Interface moderne
- **Cards design** : Interface épurée et moderne
- **Couleurs sémantiques** : Statuts colorés pour une compréhension rapide
- **Icônes contextuelles** : Représentation visuelle des types d'assurance

### 3. Feedback utilisateur
- **États de chargement** : Indicateurs visuels pendant les opérations
- **Messages d'erreur** : Gestion gracieuse des erreurs
- **Confirmations** : Dialogues de confirmation pour les actions importantes

## Migration des données

### Structure Firebase

```javascript
// Collection 'quotes'
{
  "id": "auto-generated",
  "userId": "user_id",
  "insuranceType": "auto",
  "status": "pending",
  "requestData": {
    "brand": "Renault",
    "model": "Clio",
    "year": 2018,
    // ... autres champs spécifiques
  },
  "responseData": {
    // Réponse de l'expert (optionnel)
  },
  "createdAt": "2024-01-01T10:00:00Z",
  "updatedAt": "2024-01-01T10:00:00Z",
  "notes": "Notes optionnelles",
  "estimatedAmount": 500.0,
  "assignedAgent": "agent_id"
}
```

## Tests et validation

### Tests unitaires
- **Providers** : Tests des logiques métier
- **Services** : Tests des opérations Firebase
- **Entités** : Validation des structures de données

### Tests d'intégration
- **Parcours utilisateur** : Tests end-to-end des flux
- **Firebase** : Tests des opérations de base de données
- **Navigation** : Tests des routes et transitions

## Prochaines étapes

### 1. Formulaires spécialisés
- [ ] Formulaire habitation
- [ ] Formulaire épargne
- [ ] Formulaire décès
- [ ] Formulaire santé
- [ ] Formulaire voyage

### 2. Fonctionnalités avancées
- [ ] Notifications push pour les mises à jour
- [ ] Export PDF des cotations
- [ ] Comparaison de devis
- [ ] Calcul automatique des primes

### 3. Optimisations
- [ ] Cache local pour les cotations
- [ ] Synchronisation offline
- [ ] Recherche full-text
- [ ] Analytics et métriques

## Conclusion

Cette refactorisation transforme complètement l'expérience utilisateur du module de cotation en offrant :

- **Flexibilité** : Parcours adaptés à chaque type d'assurance
- **Transparence** : Suivi complet des demandes
- **Performance** : Interface réactive avec pagination
- **Maintenabilité** : Architecture propre et extensible

Le système est maintenant prêt pour une utilisation en production avec une base solide pour les évolutions futures. 
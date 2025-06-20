import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:my_flutter_app/presentation/screens/auth/login_screen.dart';
import 'package:my_flutter_app/presentation/screens/auth/register_screen.dart';
import 'package:my_flutter_app/presentation/screens/claim/claim_screen.dart';
import 'package:my_flutter_app/presentation/screens/claim/claims_list_screen.dart';
import 'package:my_flutter_app/presentation/screens/claim/claim_details_screen.dart';
import 'package:my_flutter_app/presentation/screens/map/offline_map_screen.dart';
import 'package:my_flutter_app/presentation/screens/profile/profile_screen.dart';
import 'package:my_flutter_app/presentation/screens/quote/quote_screen.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isAuthenticated = authState.value != null;
      final isOnAuthPage = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      // Si l'utilisateur n'est pas connecté et n'est pas sur une page d'auth
      if (!isAuthenticated && !isOnAuthPage) {
        return '/login';
      }

      // Si l'utilisateur est connecté et est sur une page d'auth
      if (isAuthenticated && isOnAuthPage) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      // Routes d'authentification
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      // Route d'accueil (redirige vers dashboard si connecté)
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),

      // Route dashboard
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

      // Routes des sinistres
      GoRoute(
        path: '/claims',
        builder: (context, state) => const ClaimsListScreen(),
      ),
      GoRoute(
        path: '/claims/new',
        builder: (context, state) => const ClaimScreen(),
      ),
      GoRoute(
        path: '/claims/:id',
        builder: (context, state) {
          final claimId = state.pathParameters['id']!;
          return ClaimDetailsScreen(claimId: claimId);
        },
      ),

      // Route de la carte
      GoRoute(
        path: '/map',
        builder: (context, state) => const OfflineMapScreen(),
      ),

      // Route du profil
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      // Route de cotation
      GoRoute(
        path: '/quote',
        builder: (context, state) => const QuoteScreen(),
      ),
    ],
  );
}

// Écrans temporaires pour les routes manquantes
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion Sinistres'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.security,
              size: 100,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'Bienvenue dans votre espace de gestion',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Gérez vos sinistres et suivez vos dossiers en toute simplicité',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => context.push('/claims'),
                  icon: const Icon(Icons.list),
                  label: const Text('Mes Sinistres'),
                ),
                ElevatedButton.icon(
                  onPressed: () => context.push('/claims/new'),
                  icon: const Icon(Icons.add),
                  label: const Text('Nouveau Sinistre'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => context.push('/map'),
                  icon: const Icon(Icons.map),
                  label: const Text('Carte'),
                ),
                ElevatedButton.icon(
                  onPressed: () => context.push('/quote'),
                  icon: const Icon(Icons.calculate),
                  label: const Text('Cotation'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/profile'),
          ),
        ],
      ),
      body: const Center(
        child: Text('Tableau de bord - En cours de développement'),
      ),
    );
  }
}

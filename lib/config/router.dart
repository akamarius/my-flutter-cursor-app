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
import 'package:my_flutter_app/presentation/screens/quote/insurance_type_selection_screen.dart';
import 'package:my_flutter_app/presentation/screens/quote/auto_quote_screen.dart';
import 'package:my_flutter_app/presentation/screens/quote/habitation_quote_screen.dart';
import 'package:my_flutter_app/presentation/screens/quote/voyage_quote_screen.dart';
import 'package:my_flutter_app/presentation/screens/quote/sante_quote_screen.dart';
import 'package:my_flutter_app/presentation/screens/quote/quotes_list_screen.dart';
import 'package:my_flutter_app/presentation/screens/quote/quote_details_screen.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_app/presentation/providers/notification_provider.dart';
import 'package:my_flutter_app/domain/entities/notification.dart';
import 'package:my_flutter_app/presentation/screens/notification/notifications_list_screen.dart';
import 'package:my_flutter_app/presentation/screens/notification/notification_detail_screen.dart';

part 'router.g.dart';

@riverpod
GoRouter router(Ref ref) {
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

      // Routes de cotation
      GoRoute(
        path: '/quote',
        builder: (context, state) => const QuoteScreen(),
      ),
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
        path: '/quote/habitation',
        builder: (context, state) => const HabitationQuoteScreen(),
      ),
      GoRoute(
        path: '/quote/voyage',
        builder: (context, state) => const VoyageQuoteScreen(),
      ),
      GoRoute(
        path: '/quote/sante',
        builder: (context, state) => const SanteQuoteScreen(),
      ),
      GoRoute(
        path: '/quote/details/:id',
        builder: (context, state) {
          final quoteId = state.pathParameters['id']!;
          return QuoteDetailsScreen(quoteId: quoteId);
        },
      ),

      // Route notifications
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsListScreen(),
      ),
      GoRoute(
        path: '/notifications/:id',
        builder: (context, state) {
          final notifId = state.pathParameters['id']!;
          return NotificationDetailScreen(notificationId: notifId);
        },
      ),
    ],
  );
}

// Écrans temporaires pour les routes manquantes
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final user = authState.value;
    final userId = user?.id ?? '';
    final unreadCountAsync = ref.watch(unreadCountProvider(userId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                //onPressed: () => _showNotificationsDialog(context, ref, userId),
                onPressed: () => context.push('/notifications'),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: unreadCountAsync.when(
                  data: (count) => count > 0
                      ? Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 15,
                            minHeight: 15,
                          ),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : const SizedBox.shrink(),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),
            ],
          ),
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
                  onPressed: () => {},
                  icon: const Icon(Icons.article),
                  label: const Text('Mes Contrats'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(175, 40),
                    maximumSize: const Size(175, 40),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => context.push('/claims'),
                  icon: const Icon(Icons.list),
                  label: const Text('Mes Sinistres'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(175, 40),
                    maximumSize: const Size(175, 40),
                  ),
                ),
                //ElevatedButton.icon(
                //  onPressed: () => context.push('/claims/new'),
                //  icon: const Icon(Icons.add),
                //  label: const Text('Nouveau Sinistre'),
                //  style: ElevatedButton.styleFrom(
                //    minimumSize: const Size(175, 40),
                //    maximumSize: const Size(175, 40),
                //  ),
                //),
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(175, 40),
                    maximumSize: const Size(175, 40),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () => context.push('/quote'),
                  icon: const Icon(Icons.calculate),
                  label: const Text('Cotation'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(175, 40),
                    maximumSize: const Size(175, 40),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationsDialog(
      BuildContext context, WidgetRef ref, String userId) {
    showDialog(
      context: context,
      builder: (context) {
        final recentNotificationsAsync =
            ref.watch(recentNotificationsProvider(userId));
        return AlertDialog(
          title: const Text('Notifications'),
          content: SizedBox(
            width: 350,
            child: recentNotificationsAsync.when(
              data: (notifications) => notifications.isEmpty
                  ? const Text('Aucune notification')
                  : ListView.separated(
                      shrinkWrap: true,
                      itemCount: notifications.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final notif = notifications[index];
                        return ListTile(
                          leading: notif.status == NotificationStatus.unread
                              ? const Icon(Icons.markunread, color: Colors.blue)
                              : const Icon(Icons.drafts, color: Colors.grey),
                          title: Text(notif.title),
                          subtitle: Text(
                            notif.message,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: notif.status == NotificationStatus.unread
                              ? const Icon(Icons.circle,
                                  color: Colors.red, size: 10)
                              : null,
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context)
                                .pushNamed('/notifications/${notif.id}');
                          },
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Erreur: $e'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fermer'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/notifications');
              },
              child: const Text('Voir plus'),
            ),
          ],
        );
      },
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

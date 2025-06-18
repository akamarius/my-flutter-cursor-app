import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter_app/domain/entities/user.dart';
import 'package:my_flutter_app/presentation/providers/auth_provider.dart';
import 'package:my_flutter_app/presentation/screens/auth/login_screen.dart';
import 'package:my_flutter_app/presentation/screens/auth/register_screen.dart';
import 'package:my_flutter_app/presentation/screens/profile/profile_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isAuthRoute = state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isLoggedIn && !isAuthRoute) {
        return '/login';
      }

      if (isLoggedIn && isAuthRoute) {
        final user = authState.value!;
        return user.role == UserRole.assure ? '/dashboard' : '/cotation';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Dashboard (Assuré)')),
        ),
      ),
      GoRoute(
        path: '/cotation',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Cotation (Prospect)')),
        ),
      ),
    ],
  );
}); 
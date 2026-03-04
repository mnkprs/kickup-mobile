import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/auth_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/auth/success_screen.dart';
import 'app.dart'; // To get HomeScreen, wait we will move HomeScreen to its own file or keep in app.dart for now

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      final session = Supabase.instance.client.auth.currentSession;
      final isAuthenticated = session != null;
      
      final isGoingToAuth = state.matchedLocation.startsWith('/auth');

      if (isLoading) return null;

      if (!isAuthenticated && !isGoingToAuth) {
        return '/auth/login';
      }

      if (isAuthenticated && isGoingToAuth) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/sign-up',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/auth/sign-up-success',
        builder: (context, state) => const SuccessScreen(),
      ),
    ],
  );
});

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mockai/core/router/app_routes.dart';
import 'package:mockai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mockai/features/auth/presentation/bloc/auth_state.dart';
import 'package:mockai/features/auth/presentation/pages/login_pages.dart';
import 'package:mockai/features/auth/presentation/pages/splash_screen_page.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';
import 'package:mockai/features/recipes/presentation/pages/recipe_detail_page.dart';

import 'package:mockai/features/recipes/presentation/pages/favorites_list_page.dart';
import 'package:mockai/features/recipes/presentation/pages/recipe_list_page.dart';

class AppRouter {
  final AuthBloc _authBloc;

  AppRouter(this._authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: GoRouterRefreshStream(_authBloc.stream),
    redirect: (BuildContext context, GoRouterState state) {
      final authState = _authBloc.state;
      final currentLocation = state.matchedLocation;

      final isSplash = currentLocation == AppRoutes.splash;
      final isLoggingIn = currentLocation == AppRoutes.login;
      final isFavorites = currentLocation.startsWith(AppRoutes.favorites);

      // Allow offline favorites access anytime
      if (isFavorites) {
        return null;
      }

      // 1. Initial app boot -> Stay on splash
      if (authState is AuthInitial) {
        return AppRoutes.splash;
      }

      // 2. Authenticated -> Prevent accessing login/splash and navigate to recipes
      if (authState is AuthAuthenticated) {
        if (isLoggingIn || isSplash) {
          return AppRoutes.recipes;
        }
        return null;
      }

      // 3. Unauthenticated -> Redirect to login if not already there
      if (authState is AuthUnauthenticated || authState is AuthFailure) {
        return isLoggingIn ? null : AppRoutes.login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.favorites,
        builder: (context, state) => const FavoritesListPage(),
      ),
      GoRoute(
        path: AppRoutes.recipes,
        builder: (context, state) => const RecipeListPage(),
        routes: [
          GoRoute(
            path: AppRoutes.recipeDetails,
            builder: (context, state) {
              final recipeId = int.parse(state.pathParameters['id']!);
              final recipe = state.extra as Recipe?;
              return RecipeDetailPage(recipeId: recipeId, initialRecipe: recipe);
            },
          ),
        ],
      ),
    ],
  );
}

/// Converts a Stream into a Listenable ChangeNotifier for GoRouter
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

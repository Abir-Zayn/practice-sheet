import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mockai/features/auth/presentation/bloc/auth_state.dart';
import 'package:mockai/features/auth/presentation/pages/login_pages.dart';
import 'package:mockai/features/auth/presentation/pages/splash_screen_page.dart';
import 'package:mockai/features/recipes/presentation/pages/recipe_list_page.dart';

class GateWayPage extends StatelessWidget {
  const GateWayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated && state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
              backgroundColor: Colors.orange.shade800,
            ),
          );
        }
      },
      builder: (context, state) {
        return switch (state) {
          AuthInitial() => const SplashPage(),
          AuthAuthenticated() => const RecipeListPage(),
          AuthUnauthenticated() || AuthFailure() => const LoginPage(),
          AuthLoading() => const SplashPage(),
        };
      },
    );
  }
}

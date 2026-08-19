import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockai/core/di/injector.dart';
import 'package:mockai/core/router/app_router.dart';
import 'package:mockai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mockai/features/auth/presentation/bloc/auth_event.dart';
import 'package:mockai/features/auth/presentation/bloc/auth_state.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize dependencies
  await initInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AuthBloc>()..add(const AuthStarted()),
      child: BlocListener<AuthBloc, AuthState>(
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
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
          routerConfig: sl<AppRouter>().router,
        ),
      ),
    );
  }
}

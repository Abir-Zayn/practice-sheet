import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockai/core/errors/failure.dart' hide AuthFailure;
import 'package:mockai/core/network/auth_interceptor.dart';
import 'package:mockai/core/usecase/usecases.dart';
import 'package:mockai/features/auth/domain/entities/user.dart';
import 'package:mockai/features/auth/domain/usecases/check_auth_status_usecase.dart';
import 'package:mockai/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:mockai/features/auth/domain/usecases/login_usecase.dart';
import 'package:mockai/features/auth/domain/usecases/logout_usecase.dart';
import 'package:mockai/features/auth/presentation/bloc/auth_event.dart';
import 'package:mockai/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CheckAuthStatusUseCase checkAuthStatusUseCase;
  final AuthInterceptor authInterceptor;

  StreamSubscription<void>? _sessionSubscription;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.checkAuthStatusUseCase,
    required this.authInterceptor,
  }) : super(const AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthSessionExpired>(_onAuthSessionExpired);

    // Listen to 401 unrecoverable session expiry from interceptor
    _sessionSubscription = authInterceptor.onSessionExpired.listen((_) {
      add(const AuthSessionExpired());
    });
  }

  Future<void> _onAuthStarted(
    AuthStarted event,
    Emitter<AuthState> emit,
  ) async {
    final statusResult = await checkAuthStatusUseCase(const NoParams());

    await statusResult.fold(
      (failure) async => emit(const AuthUnauthenticated()),
      (isLoggedIn) async {
        if (!isLoggedIn) {
          emit(const AuthUnauthenticated());
          return;
        }

        // Validate token by hitting /auth/me
        final userResult = await getCurrentUserUseCase(const NoParams());
        userResult.fold(
          (failure) {
            // If offline, preserve session so user can access local favorites
            if (failure is NetworkFailure) {
              emit(
                const AuthAuthenticated(
                  User(
                    id: 0,
                    username: 'offline_user',
                    email: '',
                    firstName: 'Offline',
                    lastName: 'User',
                  ),
                ),
              );
            } else {
              emit(const AuthUnauthenticated());
            }
          },
          (user) => emit(AuthAuthenticated(user)),
        );
      },
    );
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final result = await loginUseCase(
      LoginParams(username: event.username, password: event.password),
    );

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await logoutUseCase(const NoParams());
    emit(const AuthUnauthenticated());
  }

  Future<void> _onAuthSessionExpired(
    AuthSessionExpired event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      const AuthUnauthenticated(
        message: 'Your session has expired. Please log in again.',
      ),
    );
  }

  @override
  Future<void> close() {
    _sessionSubscription?.cancel();
    return super.close();
  }
}

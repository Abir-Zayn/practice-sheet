import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  ResultFuture<User> login({
    required String username,
    required String password,
  });
  ResultFuture<void> logout();
  ResultFuture<User> getCurrentUser();
  ResultFuture<bool> isLoggedIn();
}

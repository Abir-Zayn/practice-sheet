import 'package:dartz/dartz.dart';
import 'package:mockai/core/errors/exceptions.dart';
import 'package:mockai/core/errors/failure.dart';
import 'package:mockai/core/storage/secure_storage_service.dart';
import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:mockai/features/auth/data/models/login_request_model.dart';
import 'package:mockai/features/auth/domain/entities/user.dart';
import 'package:mockai/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorageService _secureStorageService;

  AuthRepositoryImpl(this._remoteDataSource, this._secureStorageService);

  @override
  ResultFuture<User> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(
        LoginRequestModel(
          username: username,
          password: password,
          expiresInMins: 30,
        ),
      );
      // Persist tokens securely
      await _secureStorageService.saveTokens(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
      final user = response.toEntity();
      if (user == null) {
        return const Left(
          AuthFailure(message: 'Failed to parse user data from login response'),
        );
      }
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  ResultFuture<void> logout() async {
    try {
      await _secureStorageService.clear();
      return const Right(null);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  ResultFuture<User> getCurrentUser() async {
    try {
      final userModel = await _remoteDataSource.getMe();
      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> isLoggedIn() async {
    try {
      final refreshToken = await _secureStorageService.getRefreshToken();
      return Right(refreshToken != null && refreshToken.isNotEmpty);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }
}

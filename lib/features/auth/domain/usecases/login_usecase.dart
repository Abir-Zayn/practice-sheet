import 'package:equatable/equatable.dart';
import 'package:mockai/core/usecase/usecases.dart';
import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/auth/domain/entities/user.dart';
import 'package:mockai/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements Usecases<User, LoginParams> {
  final AuthRepository _repository;

  const LoginUseCase(this._repository);

  @override
  ResultFuture<User> call(LoginParams params) async {
    return await _repository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

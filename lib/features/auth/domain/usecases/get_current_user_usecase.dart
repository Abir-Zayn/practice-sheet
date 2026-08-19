import 'package:mockai/core/usecase/usecases.dart';
import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/auth/domain/entities/user.dart';
import 'package:mockai/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase implements Usecases<User, NoParams> {
  final AuthRepository _repository;

  const GetCurrentUserUseCase(this._repository);

  @override
  ResultFuture<User> call(NoParams params) async {
    return await _repository.getCurrentUser();
  }
}

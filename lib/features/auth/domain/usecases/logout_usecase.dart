import 'package:mockai/core/usecase/usecases.dart';
import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase implements Usecases<void, NoParams> {
  final AuthRepository _repository;

  const LogoutUseCase(this._repository);

  @override
  ResultFuture<void> call(NoParams params) async {
    return await _repository.logout();
  }
}

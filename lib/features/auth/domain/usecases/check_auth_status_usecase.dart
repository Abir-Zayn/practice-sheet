import 'package:mockai/core/usecase/usecases.dart';
import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/auth/domain/repositories/auth_repository.dart';

class CheckAuthStatusUseCase implements Usecases<bool, NoParams> {
  final AuthRepository _repository;

  const CheckAuthStatusUseCase(this._repository);

  @override
  ResultFuture<bool> call(NoParams params) async {
    return await _repository.isLoggedIn();
  }
}

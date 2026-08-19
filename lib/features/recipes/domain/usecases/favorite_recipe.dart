import 'package:mockai/core/usecase/usecases.dart';
import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/recipes/domain/repositories/recipe_repositories.dart';

class IsRecipeFavorite implements Usecases<bool, int> {
  final RecipeRepository _repository;

  const IsRecipeFavorite(this._repository);

  @override
  ResultFuture<bool> call(int id) async {
    return await _repository.isFavorite(id);
  }

  Stream<bool> watch(int id) {
    return _repository.watchIsFavorite(id);
  }
}

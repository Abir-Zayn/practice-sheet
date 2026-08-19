import 'package:mockai/core/usecase/usecases.dart';
import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';
import 'package:mockai/features/recipes/domain/repositories/recipe_repositories.dart';

class GetFavoriteRecipes implements Usecases<List<Recipe>, NoParams> {
  final RecipeRepository _repository;

  const GetFavoriteRecipes(this._repository);

  @override
  ResultFuture<List<Recipe>> call(NoParams params) async {
    return await _repository.getFavoriteRecipes();
  }

  Stream<List<Recipe>> watch() {
    return _repository.watchFavoriteRecipes();
  }
}

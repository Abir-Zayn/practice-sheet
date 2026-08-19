import 'package:mockai/core/usecase/usecases.dart';
import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';
import 'package:mockai/features/recipes/domain/repositories/recipe_repositories.dart';

class ToggleFavoriteRecipe implements Usecases<void, Recipe> {
  final RecipeRepository _repository;

  const ToggleFavoriteRecipe(this._repository);

  @override
  ResultFuture<void> call(Recipe recipe) async {
    return await _repository.toggleFavorite(recipe);
  }
}

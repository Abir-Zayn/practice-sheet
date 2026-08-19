import 'package:mockai/core/usecase/usecases.dart';
import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';
import 'package:mockai/features/recipes/domain/repositories/recipe_repositories.dart';

class GetRecipeById implements Usecases<Recipe, int> {
  final RecipeRepository _repository;

  const GetRecipeById(this._repository);

  @override
  ResultFuture<Recipe> call(int id) async {
    return await _repository.getRecipeById(id);
  }
}

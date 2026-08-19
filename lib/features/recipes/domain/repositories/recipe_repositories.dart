import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';

abstract interface class RecipeRepository {
  ResultFuture<List<Recipe>> getRecipes({int limit, int skip});
  ResultFuture<List<Recipe>> searchRecipes(String query, {int limit, int skip});
  ResultFuture<Recipe> getRecipeById(int id);

  // Favorites (Local Storage)
  ResultFuture<List<Recipe>> getFavoriteRecipes();
  ResultFuture<bool> isFavorite(int id);
  ResultFuture<void> toggleFavorite(Recipe recipe);
  Stream<bool> watchIsFavorite(int id);
  Stream<List<Recipe>> watchFavoriteRecipes();
}

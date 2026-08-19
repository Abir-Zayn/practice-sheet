import 'package:drift/drift.dart';
import 'package:mockai/core/database/app_database.dart';
import 'package:mockai/core/database/daos/favorite_dao.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';

abstract interface class RecipeLocalDataSource {
  Future<List<Recipe>> getFavoriteRecipes();
  Stream<List<Recipe>> watchFavoriteRecipes();
  Future<bool> isFavorite(int recipeId);
  Stream<bool> watchIsFavorite(int recipeId);
  Future<void> saveFavorite(Recipe recipe);
  Future<void> removeFavorite(int recipeId);
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final FavoritesDao _favoritesDao;

  const RecipeLocalDataSourceImpl(this._favoritesDao);

  @override
  Future<List<Recipe>> getFavoriteRecipes() async {
    final entries = await _favoritesDao.getAllFavorites();
    return entries.map(_entryToEntity).toList();
  }

  @override
  Stream<List<Recipe>> watchFavoriteRecipes() {
    return _favoritesDao.watchAllFavorites().map(
      (entries) => entries.map(_entryToEntity).toList(),
    );
  }

  @override
  Future<bool> isFavorite(int recipeId) {
    return _favoritesDao.isFavorite(recipeId);
  }

  @override
  Stream<bool> watchIsFavorite(int recipeId) {
    return _favoritesDao.watchIsFavorite(recipeId);
  }

  @override
  Future<void> saveFavorite(Recipe recipe) {
    final companion = FavoriteRecipesCompanion(
      id: Value(recipe.id),
      name: Value(recipe.name),
      imageUrl: Value(recipe.imageUrl),
      ingredients: Value(recipe.ingredients),
      instructions: Value(recipe.instructions),
      prepTimeMin: Value(recipe.preptimeMin),
      cookTimeMin: Value(recipe.cookTimeMin),
      servings: Value(recipe.servings),
      difficulty: Value(recipe.difficulty),
      cuisine: Value(recipe.cuisine),
      caloriesPerServing: Value(recipe.caloriesPerServing),
      mealTypes: Value(recipe.mealTypes),
      rating: Value(recipe.rating),
      savedAt: Value(DateTime.now()),
    );
    return _favoritesDao.insertOrUpdateFavorite(companion);
  }

  @override
  Future<void> removeFavorite(int recipeId) {
    return _favoritesDao.deleteFavorite(recipeId);
  }

  Recipe _entryToEntity(FavoriteRecipeEntry entry) {
    return Recipe(
      id: entry.id,
      name: entry.name,
      imageUrl: entry.imageUrl,
      ingredients: entry.ingredients,
      instructions: entry.instructions,
      preptimeMin: entry.prepTimeMin,
      cookTimeMin: entry.cookTimeMin,
      servings: entry.servings,
      difficulty: entry.difficulty,
      cuisine: entry.cuisine,
      caloriesPerServing: entry.caloriesPerServing,
      mealTypes: entry.mealTypes,
      rating: entry.rating,
    );
  }
}

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:mockai/core/database/converters/list_string_converter.dart';
import 'package:mockai/core/database/tables/favorite_recipes_table.dart';

part 'app_database.g.dart';

@DriftAccessor(tables: [FavoriteRecipes])
class FavoritesDao extends DatabaseAccessor<AppDatabase> with _$FavoritesDaoMixin {
  FavoritesDao(super.db);

  /// Reactive stream of all saved favorites
  Stream<List<FavoriteRecipeEntry>> watchAllFavorites() {
    return (select(favoriteRecipes)
          ..orderBy([(t) => OrderingTerm.desc(t.savedAt)]))
        .watch();
  }

  /// One-time fetch of all saved favorites
  Future<List<FavoriteRecipeEntry>> getAllFavorites() {
    return (select(favoriteRecipes)
          ..orderBy([(t) => OrderingTerm.desc(t.savedAt)]))
        .get();
  }

  /// Reactive stream checking if a specific recipe is favorited
  Stream<bool> watchIsFavorite(int recipeId) {
    return (select(favoriteRecipes)..where((t) => t.id.equals(recipeId)))
        .watch()
        .map((list) => list.isNotEmpty);
  }

  /// Check if recipe is favorited
  Future<bool> isFavorite(int recipeId) async {
    final entry = await (select(favoriteRecipes)
          ..where((t) => t.id.equals(recipeId)))
        .getSingleOrNull();
    return entry != null;
  }

  /// Insert or update favorite
  Future<void> insertOrUpdateFavorite(FavoriteRecipesCompanion entry) {
    return into(favoriteRecipes).insertOnConflictUpdate(entry);
  }

  /// Delete recipe from favorites
  Future<int> deleteFavorite(int recipeId) {
    return (delete(favoriteRecipes)..where((t) => t.id.equals(recipeId))).go();
  }
}

@DriftDatabase(tables: [FavoriteRecipes], daos: [FavoritesDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'recipe_app_db',
      native: const DriftNativeOptions(shareAcrossIsolates: true),
    );
  }
}

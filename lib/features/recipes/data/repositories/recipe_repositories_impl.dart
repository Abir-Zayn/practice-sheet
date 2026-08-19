import 'package:dartz/dartz.dart';
import 'package:mockai/core/errors/exceptions.dart';
import 'package:mockai/core/errors/failure.dart';
import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/recipes/data/datasource/remote/recipe_remote_data_src.dart';
import 'package:mockai/features/recipes/data/datasource/local/recipe_local_data_source.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';
import 'package:mockai/features/recipes/domain/repositories/recipe_repositories.dart';

class RecipeRepositoriesImpl implements RecipeRepository {
  final RecipeRemoteDataSource _remoteDataSource;
  final RecipeLocalDataSource _localDataSource;

  const RecipeRepositoriesImpl(this._remoteDataSource, this._localDataSource);

  @override
  ResultFuture<List<Recipe>> getRecipes({int limit = 20, int skip = 0}) async {
    try {
      final result = await _remoteDataSource.getRecipes(
        limit: limit,
        skip: skip,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return left(Failure.fromException(e));
    }
  }

  @override
  ResultFuture<Recipe> getRecipeById(int id) async {
    try {
      final result = await _remoteDataSource.getRecipeById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return left(Failure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Recipe>> searchRecipes(
    String query, {
    int limit = 20,
    int skip = 0,
  }) async {
    try {
      final result = await _remoteDataSource.searchRecipes(
        query,
        limit: limit,
        skip: skip,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } catch (e) {
      return left(Failure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Recipe>> getFavoriteRecipes() async {
    try {
      final result = await _localDataSource.getFavoriteRecipes();
      return Right(result);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> isFavorite(int id) async {
    try {
      final result = await _localDataSource.isFavorite(id);
      return Right(result);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  ResultFuture<void> toggleFavorite(Recipe recipe) async {
    try {
      final isFav = await _localDataSource.isFavorite(recipe.id);
      if (isFav) {
        await _localDataSource.removeFavorite(recipe.id);
      } else {
        await _localDataSource.saveFavorite(recipe);
      }
      return const Right(null);
    } catch (e) {
      return Left(Failure.fromException(e));
    }
  }

  @override
  Stream<bool> watchIsFavorite(int id) {
    return _localDataSource.watchIsFavorite(id);
  }

  @override
  Stream<List<Recipe>> watchFavoriteRecipes() {
    return _localDataSource.watchFavoriteRecipes();
  }
}

typedef RecipeRepositoryImpl = RecipeRepositoriesImpl;


import 'package:dio/dio.dart';
import 'package:mockai/core/errors/exceptions.dart';
import 'package:mockai/features/recipes/data/datasource/remote/recipe_api_service.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';

abstract interface class RecipeRemoteDataSource {
  Future<List<Recipe>> getRecipes({int limit = 20, int skip = 0});
  Future<List<Recipe>> searchRecipes(String query, {int limit = 20, int skip = 0});
  Future<Recipe> getRecipeById(int id);
  Future<List<Recipe>> getRecipesByTag(String tag);
}

class RecipeRemoteDataSrcImpl implements RecipeRemoteDataSource {
  final RecipeApiService _api;

  const RecipeRemoteDataSrcImpl(this._api);

  @override
  Future<List<Recipe>> getRecipes({int limit = 20, int skip = 0}) async {
    try {
      final response = await _api.getRecipes(limit: limit, skip: skip);
      return response.recipes;
    } on DioException catch (e) {
      _mapDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<Recipe>> searchRecipes(String query, {int limit = 20, int skip = 0}) async {
    try {
      final response = await _api.searchRecipes(query: query);
      return response.recipes;
    } on DioException catch (e) {
      _mapDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Recipe> getRecipeById(int id) async {
    try {
      final response = await _api.getRecipeById(id: id);
      return response;
    } on DioException catch (e) {
      _mapDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<Recipe>> getRecipesByTag(String tag) async {
    try {
      final response = await _api.getRecipesByTag(tag: tag);
      return response.recipes;
    } on DioException catch (e) {
      _mapDioException(e);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Never _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        throw NetworkException(
          message: 'Network connection error. Please check your internet connection.',
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.statusMessage ??
            (e.response?.data is Map ? e.response?.data['message']?.toString() : null) ??
            'Server returned status code $statusCode';
        if (statusCode == 401 || statusCode == 403) {
          throw UnauthorizedException(message: message);
        }
        throw ServerException(
          message: message,
          statusCode: statusCode,
        );
      case DioExceptionType.cancel:
        throw ServerException(message: 'Request was cancelled.');
      case DioExceptionType.unknown:
      default:
        if (e.error != null && e.error.toString().contains('SocketException')) {
          throw NetworkException(message: 'No Internet Connection established.');
        }
        throw ServerException(
          message: e.message ?? 'An unexpected network error occurred.',
          statusCode: e.response?.statusCode,
        );
    }
  }
}

typedef RecipeRemoteDataSourceImpl = RecipeRemoteDataSrcImpl;
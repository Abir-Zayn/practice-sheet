

  
import 'package:dio/dio.dart';
import 'package:mockai/core/network/api_endpoints.dart';
import 'package:mockai/features/recipes/data/models/recipe_list_response.dart';
import 'package:mockai/features/recipes/data/models/recipe_model.dart';
import 'package:retrofit/error_logger.dart';

import 'package:retrofit/http.dart';

part 'recipe_api_service.g.dart';

@RestApi(baseUrl: ApiEndpoints.baseUrl)
abstract class RecipeApiService {
  factory  RecipeApiService (Dio dio, {String? baseUrl}) = _RecipeApiService;

  //list all recipes
  @GET(ApiEndpoints.recipes)
  Future<RecipeListResponse> getRecipes({
    @Query('limit') int limit = 20,
    @Query('skip') int skip =0,
  });

  
  //search recipes
  @GET(ApiEndpoints.recipeSearch)
  Future<RecipeListResponse> searchRecipes({
    @Query('q') required String query,
  });


  //get single recipes
  @GET('${ApiEndpoints.recipes}/{id}')
  Future<RecipeModel> getRecipeById({
    @Path('id') required int id,
  });

  // Fetches recipes by tag (`/recipes/tag/{tag}`)
  @GET('${ApiEndpoints.recipes}/tag/{tag}')
  Future<RecipeListResponse> getRecipesByTag({
    @Path('tag') required String tag,
  });
  

}
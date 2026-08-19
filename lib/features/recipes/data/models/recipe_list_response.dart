import 'package:json_annotation/json_annotation.dart';
import 'package:mockai/features/recipes/data/models/recipe_model.dart';

part 'recipe_list_response.g.dart';

@JsonSerializable()
class RecipeListResponse {
  final List<RecipeModel> recipes;
  final int total;
  final int skip;
  final int limit;

  const RecipeListResponse({
    required this.recipes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory RecipeListResponse.fromJson(Map<String, dynamic> json) =>
      _$RecipeListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeListResponseToJson(this);
}

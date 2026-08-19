import 'package:json_annotation/json_annotation.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel extends Recipe {
  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'prepTimeMinutes')
  final int prepTimeMinutes;

  @JsonKey(name: 'cookTimeMinutes')
  final int cookTimeMinutes;

  @JsonKey(name: 'difficulty')
  final String recipeDifficulty;

  @JsonKey(name: 'mealType')
  final List<String> mealType;

  const RecipeModel({
    required super.id,
    required super.name,
    required this.image,
    required super.ingredients,
    required super.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required super.servings,
    required this.recipeDifficulty,
    required super.cuisine,
    required this.mealType,
    required super.caloriesPerServing,
    required super.rating,
  }) : super(
         imageUrl: image,
         preptimeMin: prepTimeMinutes,
         cookTimeMin: cookTimeMinutes,
         difficulty: recipeDifficulty,
         mealTypes: mealType,
       );

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}

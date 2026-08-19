// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  image: json['image'] as String,
  ingredients: (json['ingredients'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  instructions: (json['instructions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  prepTimeMinutes: (json['prepTimeMinutes'] as num).toInt(),
  cookTimeMinutes: (json['cookTimeMinutes'] as num).toInt(),
  servings: (json['servings'] as num).toInt(),
  recipeDifficulty: json['difficulty'] as String,
  cuisine: json['cuisine'] as String,
  mealType: (json['mealType'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  caloriesPerServing: (json['caloriesPerServing'] as num).toInt(),
  rating: (json['rating'] as num).toDouble(),
);

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'servings': instance.servings,
      'cuisine': instance.cuisine,
      'caloriesPerServing': instance.caloriesPerServing,
      'rating': instance.rating,
      'image': instance.image,
      'prepTimeMinutes': instance.prepTimeMinutes,
      'cookTimeMinutes': instance.cookTimeMinutes,
      'difficulty': instance.recipeDifficulty,
      'mealType': instance.mealType,
    };

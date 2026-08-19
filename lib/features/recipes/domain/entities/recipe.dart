import 'package:equatable/equatable.dart';

class Recipe extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> instructions;
  final int preptimeMin;
  final int cookTimeMin;
  final int servings;
  final String difficulty;
  final String cuisine;
  final int caloriesPerServing;
  final List<String> mealTypes;
  final double rating;

  const Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.ingredients,
    required this.instructions,
    required this.preptimeMin,
    required this.cookTimeMin,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.mealTypes,
    required this.rating,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        ingredients,
        instructions,
        preptimeMin,
        cookTimeMin,
        servings,
        difficulty,
        cuisine,
        caloriesPerServing,
        mealTypes,
        rating,
      ];
}

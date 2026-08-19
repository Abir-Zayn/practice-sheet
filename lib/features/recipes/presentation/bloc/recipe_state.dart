import 'package:equatable/equatable.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';

abstract class RecipeState extends Equatable{
  const RecipeState();

  @override  
  List<Object> get props => [];
}

class RecipesInitial extends RecipeState {}

class RecipesLoading extends RecipeState {}

class RecipesLoaded extends RecipeState {
  final List<Recipe> recipes;
  const RecipesLoaded(this.recipes);

  @override  
  List<Object> get props => [recipes];
}

class RecipesError extends RecipeState {
  final String message;
  const RecipesError(this.message);

  @override  
  List<Object> get props => [message];
}
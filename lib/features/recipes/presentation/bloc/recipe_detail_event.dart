import 'package:equatable/equatable.dart';

abstract class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();

  @override
  List<Object?> get props => [];
}

class RecipeDetailRequested extends RecipeDetailEvent {
  final int recipeId;

  const RecipeDetailRequested(this.recipeId);

  @override
  List<Object?> get props => [recipeId];
}

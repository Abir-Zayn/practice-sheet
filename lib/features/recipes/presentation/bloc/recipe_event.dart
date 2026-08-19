
import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable{
  const RecipeEvent();

  @override  
  List<Object> get props => [];

}

class RecipesRequested extends RecipeEvent {
  const RecipesRequested();
}
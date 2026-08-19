import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockai/features/recipes/domain/usecases/get_recipes.dart';
import 'package:mockai/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:mockai/features/recipes/presentation/bloc/recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final ListRecipes getRecipes;

  RecipeBloc({required this.getRecipes}) : super(RecipesInitial()) {
    on<RecipesRequested>(_onRecipesRequested);
  }

  Future<void> _onRecipesRequested(
    RecipesRequested event,
    Emitter<RecipeState> emit,
  ) async {
    emit(RecipesLoading());
    final result = await getRecipes(const PaginationParams());
    result.fold(
      (failure) => emit(RecipesError(failure.message)),
      (recipes) => emit(RecipesLoaded(recipes)),
    );
  }
}

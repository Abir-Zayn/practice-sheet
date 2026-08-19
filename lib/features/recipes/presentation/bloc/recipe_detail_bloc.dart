import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockai/features/recipes/domain/usecases/get_recipe_by_id.dart';
import 'package:mockai/features/recipes/presentation/bloc/recipe_detail_event.dart';
import 'package:mockai/features/recipes/presentation/bloc/recipe_detail_state.event';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final GetRecipeById getRecipeById;

  RecipeDetailBloc({required this.getRecipeById})
    : super(RecipeDetailInitial()) {
    on<RecipeDetailRequested>(_onRecipeDetailRequested);
  }

  Future<void> _onRecipeDetailRequested(
    RecipeDetailRequested event,
    Emitter<RecipeDetailState> emit,
  ) async {
    emit(RecipeDetailLoading());
    final result = await getRecipeById(event.recipeId);
    result.fold(
      (failure) => emit(RecipeDetailError(failure.message)),
      (recipe) => emit(RecipeDetailLoaded(recipe)),
    );
  }
}

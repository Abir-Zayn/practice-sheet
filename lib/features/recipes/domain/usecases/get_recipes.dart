import 'package:equatable/equatable.dart';
import 'package:mockai/core/usecase/usecases.dart';
import 'package:mockai/core/utils/typedefs.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';
import 'package:mockai/features/recipes/domain/repositories/recipe_repositories.dart';

class ListRecipes implements Usecases<List<Recipe>, PaginationParams> {
  final RecipeRepository _repository;

  const ListRecipes(this._repository);

  @override
  ResultFuture<List<Recipe>> call(PaginationParams params) async {
    return await _repository.getRecipes(limit: params.limit, skip: params.skip);
  }
}

class PaginationParams extends Equatable {
  final int limit;
  final int skip;

  const PaginationParams({this.limit = 20, this.skip = 0});

  @override
  List<Object?> get props => [limit, skip];
}

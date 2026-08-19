import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mockai/core/di/injector.dart';
import 'package:mockai/features/recipes/presentation/bloc/recipe_bloc.dart';
import 'package:mockai/features/recipes/presentation/bloc/recipe_event.dart';
import 'package:mockai/features/recipes/presentation/bloc/recipe_state.dart';

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RecipeBloc>()..add(const RecipesRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Recipes"),
          actions: [
            IconButton(
              tooltip: 'Saved Favorites',
              icon: const Icon(Icons.favorite, color: Colors.redAccent),
              onPressed: () {
                context.push('/favorites');
              },
            ),
          ],
        ),
        body: BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, state) {
            // loading state
            if (state is RecipesLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // error state
            else if (state is RecipesError) {
              return Center(
                child: Text(state.message, style: TextStyle(color: Colors.red)),
              );
            }
            // loaded state
            else if (state is RecipesLoaded) {
              // loaded but empty
              if (state.recipes.isEmpty) {
                return const Center(child: Text("No Recipes Found"));
              }

              // loaded with data
              return ListView.builder(
                itemCount: state.recipes.length,
                itemBuilder: (context, index) {
                  final recipe = state.recipes[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: ListTile(
                      onTap: () {
                        context.push('/recipes/${recipe.id}', extra: recipe);
                      },
                      contentPadding: EdgeInsets.all(8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: recipe.imageUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: recipe.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                      Icons.broken_image_rounded,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                              )
                            : const Icon(Icons.fastfood, size: 40),
                      ),
                      title: Text(recipe.name),
                      subtitle: Text(
                        "${recipe.cuisine} min | ${recipe.servings} servings | ${recipe.preptimeMin} min | ${recipe.caloriesPerServing} calories",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            recipe.rating.toString(),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

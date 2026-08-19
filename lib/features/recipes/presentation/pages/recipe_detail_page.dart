import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockai/core/di/injector.dart';
import 'package:mockai/features/recipes/domain/entities/recipe.dart';
import 'package:mockai/features/recipes/domain/usecases/favorite_recipe.dart';
import 'package:mockai/features/recipes/domain/usecases/toggle_favorite_recipe.dart';
import 'package:mockai/features/recipes/presentation/bloc/recipe_detail_bloc.dart';
import 'package:mockai/features/recipes/presentation/bloc/recipe_detail_event.dart';
import 'package:mockai/features/recipes/presentation/bloc/recipe_detail_state.event';

class RecipeDetailPage extends StatelessWidget {
  final int recipeId;
  final Recipe? initialRecipe;

  const RecipeDetailPage({
    super.key,
    required this.recipeId,
    this.initialRecipe,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<RecipeDetailBloc>()..add(RecipeDetailRequested(recipeId)),
      child: Scaffold(
        body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
          builder: (context, state) {
            if (state is RecipeDetailLoading) {
              // If we already had partial recipe data passed from list, display placeholder preview
              if (initialRecipe != null) {
                return _RecipeDetailContent(recipe: initialRecipe!);
              }
              return const Center(child: CircularProgressIndicator());
            } else if (state is RecipeDetailError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 60,
                        color: Colors.redAccent,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<RecipeDetailBloc>().add(
                            RecipeDetailRequested(recipeId),
                          );
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is RecipeDetailLoaded) {
              return _RecipeDetailContent(recipe: state.recipe);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _RecipeDetailContent extends StatelessWidget {
  final Recipe recipe;

  const _RecipeDetailContent({required this.recipe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        // App Bar with Image
        SliverAppBar(
          expandedHeight: 280.0,
          pinned: true,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            StreamBuilder<bool>(
              stream: sl<IsRecipeFavorite>().watch(recipe.id),
              initialData: false,
              builder: (context, snapshot) {
                final isFav = snapshot.data ?? false;
                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: isFav ? Colors.redAccent : Colors.white,
                  ),
                  onPressed: () {
                    sl<ToggleFavoriteRecipe>()(recipe);
                  },
                );
              },
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              recipe.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                shadows: [Shadow(color: Colors.black54, blurRadius: 8)],
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                if (recipe.imageUrl.isNotEmpty)
                  CachedNetworkImage(
                    imageUrl: recipe.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.broken_image, size: 60),
                    ),
                  )
                else
                  Container(
                    color: theme.primaryColor.withValues(alpha: 0.1),
                    child: const Icon(Icons.restaurant, size: 80),
                  ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black54],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Body Info
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quick info chips
                _buildQuickInfoGrid(context),
                const SizedBox(height: 24),

                // Tags / Meal Types
                if (recipe.mealTypes.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: recipe.mealTypes
                        .map(
                          (type) => Chip(
                            label: Text(type),
                            backgroundColor: theme.colorScheme.primaryContainer,
                            labelStyle: TextStyle(
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                ],

                // Ingredients Section
                Text(
                  'Ingredients',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: recipe.ingredients.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        leading: const Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 20,
                        ),
                        title: Text(recipe.ingredients[index]),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Instructions Section
                Text(
                  'Instructions',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recipe.instructions.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: theme.colorScheme.primary,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              recipe.instructions[index],
                              style: const TextStyle(fontSize: 15, height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickInfoGrid(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoItem(Icons.schedule, '${recipe.cookTimeMin} min', 'Cook Time'),
          _infoItem(Icons.timelapse, '${recipe.preptimeMin} min', 'Prep Time'),
          _infoItem(Icons.people_outline, '${recipe.servings}', 'Servings'),
          _infoItem(
            Icons.local_fire_department_outlined,
            '${recipe.caloriesPerServing}',
            'Calories',
          ),
          _infoItem(
            Icons.star,
            '${recipe.rating}',
            'Rating',
            iconColor: Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget _infoItem(
    IconData icon,
    String value,
    String label, {
    Color? iconColor,
  }) {
    return Column(
      children: [
        Icon(icon, size: 22, color: iconColor ?? Colors.grey.shade700),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_huto_test/core/constants/size.dart';
import 'package:recipe_huto_test/features/recipes/presentation/providers/recipe_providers.dart';
import 'package:recipe_huto_test/features/recipes/presentation/widgets/error_widget.dart';
import 'package:recipe_huto_test/features/recipes/presentation/widgets/loading_widget.dart';
import 'package:recipe_huto_test/features/recipes/presentation/widgets/recipe_card.dart';
import 'package:recipe_huto_test/features/recipes/presentation/widgets/recipe_search_bar.dart';

class RecipeSearchPage extends ConsumerWidget {
  const RecipeSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the search state for changes
    final searchState = ref.watch(searchNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Finder'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          const RecipeSearchBar(),
       // Expanded widget to fill remaining space with search results or error/loading widgets
          Expanded(child: _buildBody(context, searchState, ref)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, SearchState state, WidgetRef ref) {
    if (state.isLoading) {
      return const LoadingWidget();
    }

    if (state.failure != null) {
      return CustomErrorWidget(
        failure: state.failure!,
        onRetry: () {
          // if there's an error it allows the user to retry the search
          // this is useful for network errors or server errors
          ref.read(searchNotifierProvider.notifier).searchRecipes(state.query);
        },
      );
    }
    // Show 'No recipes found" message when search returns empty results
    if (state.recipes.isEmpty && state.query.isNotEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            VerticalSpacing(16),
            Text(
              'No recipes found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // Show initial state message when no search has been performed
    if (state.recipes.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, size: 64, color: Colors.grey),
            VerticalSpacing(16),
            Text(
              'Search for delicious recipes',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }
    // Display list of recipe cards when recipes are available
    return ListView.builder(
      itemCount: state.recipes.length,
      itemBuilder: (context, index) {
        return RecipeCard(recipe: state.recipes[index]);
      },
    );
  }
}

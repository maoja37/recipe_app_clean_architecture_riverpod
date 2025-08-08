import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_huto_test/features/recipes/presentation/providers/recipe_providers.dart';



class RecipeSearchBar extends ConsumerStatefulWidget {
  const RecipeSearchBar({super.key});

  @override
  ConsumerState<RecipeSearchBar> createState() => _RecipeSearchBarState();
}

class _RecipeSearchBarState extends ConsumerState<RecipeSearchBar> {
  final TextEditingController _searchController = TextEditingController();
    // timer for implementing debounce functionality to limit API calls
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

//implemt debounce for api calls instead of calling it on every stroke or waiting to submit the text with keyboard
  void _performRecipeSearch(String query) {
    _debounce?.cancel();
    if (query.isEmpty) {
      //if the query is empty, clear the search results which emits an empty list basically
      ref.read(searchNotifierProvider.notifier).clearSearch();
      return;
    }
    _debounce = Timer(const Duration(seconds: 1), () async {
      if (query.isNotEmpty) {
        ref.read(searchNotifierProvider.notifier).searchRecipes(query);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search recipes...',
          prefixIcon: const Icon(Icons.search),
          //clear button to clear the search field, for better UX sha
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              ref.read(searchNotifierProvider.notifier).clearSearch();
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
        //this is here in case the user wants to submit the query using the keyboard, in case for any reason
        //the debounce mchanism doesnt work properly
        //or the user prefers to submit the query using the keyboard
        onSubmitted: (query) {
          ref.read(searchNotifierProvider.notifier).searchRecipes(query);
        },
        // Handles search as user types (with debounce of course)
        onChanged: (query) => _performRecipeSearch(query),
        textInputAction: TextInputAction.search,
      ),
    );
  }
}

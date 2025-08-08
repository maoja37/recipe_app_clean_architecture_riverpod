import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_huto_test/core/errors/failures.dart';
import 'package:recipe_huto_test/core/network/network_provider.dart';
import 'package:recipe_huto_test/features/recipes/data/datasources/recipe_remote_datasource.dart';
import 'package:recipe_huto_test/features/recipes/data/repository_impl/recipe_repository_impl.dart';
import 'package:recipe_huto_test/features/recipes/domain/entities/recipe_entity.dart';
import 'package:recipe_huto_test/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:recipe_huto_test/features/recipes/domain/usecases/search_recipes_usecase.dart';

final networkProvider = Provider<NetworkProvider>(
  (ref) => NetworkProviderImpl(),
);

final recipeRemoteDataSourceProvider = Provider<RecipeRemoteDataSource>(
  (ref) =>
      RecipeRemoteDataSourceImpl(networkProvider: ref.watch(networkProvider)),
);

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return RecipeRepositoryImpl(
    remoteDataSource: ref.watch(recipeRemoteDataSourceProvider),
  );
});

final searchRecipesUseCaseProvider = Provider<SearchRecipesUseCase>((ref) {
  return SearchRecipesUseCase(ref.watch(recipeRepositoryProvider));
});

class SearchState {
  final String query;
  final bool isLoading;
  final List<RecipeEntity> recipes;
  final Failure? failure;

  SearchState({
    //the value of an optional parameter must be const thats why this is here
    this.recipes = const [],
    this.isLoading = false,
    this.query = '',
    this.failure,
  });

  SearchState copyWith({
    List<RecipeEntity>? recipes,
    bool? isLoading,
    Failure? failure,
    String? query,
  }) {
    return SearchState(
      recipes: recipes ?? this.recipes,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      query: query ?? this.query,
    );
  }
}

class SearchNotifier extends StateNotifier<SearchState> {
  SearchRecipesUseCase searchRecipesUseCase;

  SearchNotifier(this.searchRecipesUseCase) : super(SearchState());

  Future<void> searchRecipes(String query) async {
    if (query.trim().isEmpty) {
      //just return the intital state as is
      state = SearchState();
      return;
    }

    //emit te loading state
    state = state.copyWith(isLoading: true, query: query, failure: null);
    final result = await searchRecipesUseCase(query);

    result.fold(
      (failure) => state = state.copyWith(isLoading: false, failure: failure),
      (recipes) =>
          state = state.copyWith(
            isLoading: false,
            recipes: recipes,
            failure: null,
          ),
    );
  }

  void clearSearch() {
    state = SearchState();
  }
}

final searchNotifierProvider =
    StateNotifierProvider<SearchNotifier, SearchState>(
      (ref) => SearchNotifier(ref.watch(searchRecipesUseCaseProvider)),
    );

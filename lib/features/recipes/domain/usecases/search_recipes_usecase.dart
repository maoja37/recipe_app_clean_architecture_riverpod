
import 'package:dartz/dartz.dart';
import 'package:recipe_huto_test/core/errors/failures.dart';
import 'package:recipe_huto_test/features/recipes/domain/entities/recipe_entity.dart';
import 'package:recipe_huto_test/features/recipes/domain/repositories/recipe_repository.dart';

/// Use case class that handles the business logic for searching recipes
/// Follows clean architecture principles by depending on abstractions (repository)
/// it is basicallly what they call a callable class in clean architecure and dart suppports it
class SearchRecipesUseCase {
  final RecipeRepository repository;
  
  SearchRecipesUseCase(this.repository);
  
    /// Callable class method that executes the search
  /// Returns Either type which can be either a Failure or List of RecipeEntity
  Future<Either<Failure, List<RecipeEntity>>> call(String query) async {
    return await repository.searchRecipes(query);
  }
}
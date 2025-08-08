// lib/features/recipes/domain/repositories/recipe_repository.dart
import 'package:dartz/dartz.dart';
import 'package:recipe_huto_test/core/errors/failures.dart';
import 'package:recipe_huto_test/features/recipes/domain/entities/recipe_entity.dart';



abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeEntity>>> searchRecipes(String query);
}
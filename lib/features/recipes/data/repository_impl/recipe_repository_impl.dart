// lib/features/recipes/data/repositories/recipe_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:recipe_huto_test/core/errors/failures.dart';
import 'package:recipe_huto_test/features/recipes/data/datasources/recipe_remote_datasource.dart';
import 'package:recipe_huto_test/features/recipes/domain/entities/recipe_entity.dart';
import 'package:recipe_huto_test/features/recipes/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;
  
  RecipeRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<Either<Failure, List<RecipeEntity>>> searchRecipes(String query) async {
    try {
      final recipes = await remoteDataSource.searchRecipes(query);
      return Right(recipes);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } on NetworkFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
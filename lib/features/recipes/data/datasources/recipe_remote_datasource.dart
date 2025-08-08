
import 'package:recipe_huto_test/core/api_constants/endpoints.dart';
import 'package:recipe_huto_test/core/network/network_provider.dart';
import 'package:recipe_huto_test/features/recipes/data/models/recipe_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> searchRecipes(String query);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final NetworkProvider networkProvider;
  RecipeRemoteDataSourceImpl({
    required this.networkProvider,
  });

  @override
  Future<List<RecipeModel>> searchRecipes(String query) async {
    final response = await networkProvider.call(
      path: Endpoints.searchEndpoint,
      method: RequestMethod.get,
      queryParams: {'s': query},
    );

    final meals = response?.data['meals'] as List<dynamic>?;
    if (meals == null) return [];

    return meals.map((meal)=> RecipeModel.fromJson(meal as Map<String, dynamic>)).toList();

 
  }
}

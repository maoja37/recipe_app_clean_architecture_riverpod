import 'package:recipe_huto_test/features/recipes/domain/entities/recipe_entity.dart';

// RecipeModel extends RecipeEntity to provide JSON serialization capabilities
// This class handles the data layer representation of a recipe and can be change to anything later
// without affection the domain layer
class RecipeModel extends RecipeEntity {
  // Constructor that maps all properties to the parent entity
  const RecipeModel({
    required super.idMeal,
    required super.strMeal,
    super.strMealAlternate,
    super.strCategory,
    super.strArea,
    super.strInstructions,
    super.strMealThumb,
    super.strTags,
    super.strYoutube,
    required super.ingredients,
    required super.measures,
    super.strSource,
    super.strImageSource,
    super.strCreativeCommonsConfirmed,
    super.dateModified,
  });

  // Factory constructor to create a RecipeModel instance from JSON data
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    // Initialize lists to store ingredients and their measures because it's plenty
    List<String> ingredients = [];
    List<String> measures = [];

    //the api provides up to 20 ingredients and measures pairs, this could be two different for loops
    //but i opted to use a single loop for simplicity and performance
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];

        // Only add non-empty ingredients and their corresponding measures
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add(ingredient);
        if (measure != null && measure.toString().trim().isNotEmpty) {
          measures.add(measure);
        } else {
          // Add empty string if measure is null or empty
          measures.add('');
        }
      }
    }

    // Create and return a new RecipeModel instance with parsed data
    return RecipeModel(
      idMeal: json['idMeal'] as String,
      strMeal: json['strMeal'] as String,
      strMealAlternate: json['strMealAlternate'] as String?,
      strCategory: json['strCategory'] as String?,
      strArea: json['strArea'] as String?,
      strInstructions: json['strInstructions'] as String?,
      strMealThumb: json['strMealThumb'] as String?,
      strTags: json['strTags'] as String?,
      strYoutube: json['strYoutube'] as String?,
      ingredients: ingredients,
      measures: measures,
      strSource: json['strSource'] as String?,
      strImageSource: json['strImageSource'] as String?,
      strCreativeCommonsConfirmed:
          json['strCreativeCommonsConfirmed'] as String?,
      dateModified: json['dateModified'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
        // Initialize the base JSON map with primary properties
    final Map<String, dynamic> json = {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealAlternate': strMealAlternate,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strMealThumb': strMealThumb,
      'strTags': strTags,
      'strYoutube': strYoutube,
      'strSource': strSource,
      'strImageSource': strImageSource,
      'strCreativeCommonsConfirmed': strCreativeCommonsConfirmed,
      'dateModified': dateModified,
    };

    // Add ingredients and measures back to the format expected by the API
    //i dont think we would ever need to convert this back to json but it's here for completeness
    for (int i = 1; i <= 20; i++) {
      json['strIngredient$i'] =
          i <= ingredients.length ? ingredients[i - 1] : '';
      json['strMeasure$i'] = i <= measures.length ? measures[i - 1] : '';
    }

    return json;
  }
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Recipe Finder';

  @override
  String get searchRecipes => 'Search recipes...';

  @override
  String get searchForDeliciousRecipes => 'Search for delicious recipes';

  @override
  String get searchingRecipes => 'Searching recipes...';

  @override
  String get noRecipesFound => 'No recipes found';

  @override
  String get tryDifferentKeywords => 'Try different keywords';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get clear => 'Clear';

  @override
  String get category => 'Category';

  @override
  String get origin => 'Origin';

  @override
  String get tags => 'Tags';

  @override
  String get ingredients => 'Ingredients';

  @override
  String get instructions => 'Instructions';

  @override
  String get links => 'Links';

  @override
  String get watchOnYoutube => 'Watch on YouTube';

  @override
  String get viewSource => 'View Source';

  @override
  String foundRecipes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Found $count recipes',
      one: 'Found 1 recipe',
      zero: 'No recipes found',
    );
    return '$_temp0';
  }

  @override
  String ingredientWithMeasure(String measure, String ingredient) {
    return '$measure $ingredient';
  }

  @override
  String recipeFrom(String area) {
    return 'Recipe from $area';
  }

  @override
  String originFrom(String area) {
    return 'Origin $area';
  }

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get cancel => 'Cancel';
}

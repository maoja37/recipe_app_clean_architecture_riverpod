// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Recherche de Recettes';

  @override
  String get searchRecipes => 'Rechercher des recettes...';

  @override
  String get searchForDeliciousRecipes => 'Recherchez de délicieuses recettes';

  @override
  String get searchingRecipes => 'Recherche de recettes...';

  @override
  String get noRecipesFound => 'Aucune recette trouvée';

  @override
  String get tryDifferentKeywords => 'Essayez des mots-clés différents';

  @override
  String get somethingWentWrong => 'Quelque chose s\'est mal passé';

  @override
  String get noInternetConnection => 'Pas de connexion internet';

  @override
  String get tryAgain => 'Réessayer';

  @override
  String get clear => 'Effacer';

  @override
  String get category => 'Catégorie';

  @override
  String get origin => 'Origine';

  @override
  String get tags => 'Étiquettes';

  @override
  String get ingredients => 'Ingrédients';

  @override
  String get instructions => 'Instructions';

  @override
  String get links => 'Liens';

  @override
  String get watchOnYoutube => 'Regarder sur YouTube';

  @override
  String get viewSource => 'Voir la Source';

  @override
  String foundRecipes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count recettes trouvées',
      one: '1 recette trouvée',
      zero: 'Aucune recette trouvée',
    );
    return '$_temp0';
  }

  @override
  String ingredientWithMeasure(String measure, String ingredient) {
    return '$measure $ingredient';
  }

  @override
  String recipeFrom(String area) {
    return 'Recette de $area';
  }

  @override
  String originFrom(String area) {
    return 'Origine $area';
  }

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get selectLanguage => 'Sélectionner la Langue';

  @override
  String get cancel => 'Annuler';
}

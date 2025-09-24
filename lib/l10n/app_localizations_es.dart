// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Buscador de Recetas';

  @override
  String get searchRecipes => 'Buscar recetas...';

  @override
  String get searchForDeliciousRecipes => 'Busca recetas deliciosas';

  @override
  String get searchingRecipes => 'Buscando recetas...';

  @override
  String get noRecipesFound => 'No se encontraron recetas';

  @override
  String get tryDifferentKeywords => 'Prueba con palabras clave diferentes';

  @override
  String get somethingWentWrong => 'Algo salió mal';

  @override
  String get noInternetConnection => 'Sin conexión a internet';

  @override
  String get tryAgain => 'Intentar de Nuevo';

  @override
  String get clear => 'Limpiar';

  @override
  String get category => 'Categoría';

  @override
  String get origin => 'Origen';

  @override
  String get tags => 'Etiquetas';

  @override
  String get ingredients => 'Ingredientes';

  @override
  String get instructions => 'Instrucciones';

  @override
  String get links => 'Enlaces';

  @override
  String get watchOnYoutube => 'Ver en YouTube';

  @override
  String get viewSource => 'Ver Fuente';

  @override
  String foundRecipes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Se encontraron $count recetas',
      one: 'Se encontró 1 receta',
      zero: 'No se encontraron recetas',
    );
    return '$_temp0';
  }

  @override
  String ingredientWithMeasure(String measure, String ingredient) {
    return '$measure $ingredient';
  }

  @override
  String recipeFrom(String area) {
    return 'Receta de $area';
  }

  @override
  String originFrom(String area) {
    return 'Origen $area';
  }

  @override
  String get settings => 'Configuración';

  @override
  String get language => 'Idioma';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String get cancel => 'Cancelar';
}

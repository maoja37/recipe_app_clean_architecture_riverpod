// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_huto_test/features/recipes/presentation/providers/locale_provider.dart';
import 'package:recipe_huto_test/l10n/app_localizations.dart';

import 'features/recipes/presentation/pages/recipe_search_page.dart';

void main() {
  runApp(
    //this is for wrapping the entire app to enable riverpod state management
    //ProviderScope is basicaly  the root widget that provides the state management capabilities
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          //i set orange as the seed color for both light and dark themes because idk what else to put for now
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const RecipeSearchPage(),
    );
  }
}

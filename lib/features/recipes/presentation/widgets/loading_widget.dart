import 'package:flutter/material.dart';
import 'package:recipe_huto_test/core/constants/size.dart';
import 'package:recipe_huto_test/l10n/app_localizations.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          VerticalSpacing(16),
          Text(l10n.searchingRecipes),
        ],
      ),
    );
  }
}

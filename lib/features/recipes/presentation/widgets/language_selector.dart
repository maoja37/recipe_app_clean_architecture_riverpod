import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_huto_test/features/recipes/presentation/providers/locale_provider.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentLocale = ref.watch(localeProvider);
    final l10n = AppLocalizations.of(context);

    return PopupMenuButton<Locale>(
      tooltip: l10n.selectLanguage,
      onSelected: (value) {
        ref.read(localeProvider.notifier).setLocale(value);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
            value: Locale('en'),
            child: Row(
              children: [
                const Text('🇺🇸'),
                const SizedBox(width: 8),
                const Text('English'),
                if (currentLocale.languageCode == 'en') ...[
                  Spacer(),
                  const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ]
              ],
            )),
        PopupMenuItem(
          value: const Locale('es'),
          child: Row(
            children: [
              const Text('🇪🇸'),
              const SizedBox(width: 8),
              const Text('Español'),
              if (currentLocale.languageCode == 'es') ...[
                const Spacer(),
                const Icon(Icons.check, color: Colors.green),
              ]
            ],
          ),
        ),
        PopupMenuItem(
          value: const Locale('fr'),
          child: Row(
            children: [
              const Text('🇫🇷'),
              const SizedBox(width: 8),
              const Text('Français'),
              if (currentLocale.languageCode == 'fr') ...[
                const Spacer(),
                const Icon(Icons.check, color: Colors.green),
              ]
            ],
          ),
        ),
      ],
    );
  }
}

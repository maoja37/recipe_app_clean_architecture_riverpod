import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(Locale('en')) {
    loadLocale();
  }

  static String appLocale = 'app_locale';

  Future<void> loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final localeString = prefs.getString(appLocale);

      if (localeString != null) {
        state = Locale(localeString);
      }
    } catch (e) {
      // handle error
    }
  }

  Future<void> setLocale(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      prefs.setString(appLocale, locale.languageCode);
      state = locale;
    } catch (e) {
      //
    }
  }
}

final localeProvider =
    StateNotifierProvider<LocaleNotifier, Locale>((notifier) => LocaleNotifier());

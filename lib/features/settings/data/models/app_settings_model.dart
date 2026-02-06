import 'package:flutter/material.dart';
import '../../domain/entities/app_settings.dart';

class AppSettingsModel extends AppSettings {
  const AppSettingsModel({
    required super.themeMode,
    required super.categoryADelay,
    required super.categoryBDelay,
    required super.categoryCDelay,
    required super.categoryDDelay,
    required super.timeFormat,
    required super.locale,
  });

  factory AppSettingsModel.fromPreferences({
    required String? themeModeString,
    required int? categoryADelay,
    required int? categoryBDelay,
    required int? categoryCDelay,
    required int? categoryDDelay,
    required String? timeFormat,
    required String? localeString,
  }) {
    ThemeMode themeMode;
    switch (themeModeString) {
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'system':
        themeMode = ThemeMode.system;
        break;
      default:
        themeMode = ThemeMode.dark;
    }

    return AppSettingsModel(
      themeMode: themeMode,
      categoryADelay: categoryADelay ?? 0,
      categoryBDelay: categoryBDelay ?? 3,
      categoryCDelay: categoryCDelay ?? 10,
      categoryDDelay: categoryDDelay ?? 120,
      timeFormat: timeFormat ?? 'Hm',
      locale: _parseLocale(localeString),
    );
  }

  static String themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.system:
        return 'system';
    }
  }

  static String localeToString(Locale locale) {
    if (locale.countryCode != null && locale.countryCode!.isNotEmpty) {
      return '${locale.languageCode}_${locale.countryCode}';
    }
    return locale.languageCode;
  }

  static Locale _parseLocale(String? localeString) {
    if (localeString == null || localeString.isEmpty) {
      return const Locale('en');
    }

    final parts = localeString.split('_');
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    }
    return Locale(localeString);
  }
}

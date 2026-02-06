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
  });

  factory AppSettingsModel.fromPreferences({
    required String? themeModeString,
    required int? categoryADelay,
    required int? categoryBDelay,
    required int? categoryCDelay,
    required int? categoryDDelay,
    required String? timeFormat,
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
}

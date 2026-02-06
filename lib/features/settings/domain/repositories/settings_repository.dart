import 'package:flutter/material.dart';
import '../entities/app_settings.dart';

abstract class SettingsRepository {
  Future<AppSettings> getSettings();
  Future<void> updateThemeMode(ThemeMode themeMode);
  Future<void> updateCategoryDelay(String category, int value);
  Future<void> updateTimeFormat(String format);
  Future<void> updateLocale(Locale locale);
}

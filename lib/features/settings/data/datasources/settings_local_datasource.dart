import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<AppSettingsModel> getSettings();
  Future<void> updateThemeMode(ThemeMode themeMode);
  Future<void> updateCategoryDelay(String category, int value);
  Future<void> updateTimeFormat(String format);
  Future<void> updateLocale(Locale locale);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<AppSettingsModel> getSettings() async {
    return AppSettingsModel.fromPreferences(
      themeModeString: sharedPreferences.getString('ThemeMode'),
      categoryADelay: sharedPreferences.getInt('CategoryADalay'),
      categoryBDelay: sharedPreferences.getInt('CategoryBDalay'),
      categoryCDelay: sharedPreferences.getInt('CategoryCDalay'),
      categoryDDelay: sharedPreferences.getInt('CategoryDDalay'),
      timeFormat: sharedPreferences.getString('format'),
      localeString: sharedPreferences.getString('locale'),
    );
  }

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    final themeModeString = AppSettingsModel.themeModeToString(themeMode);
    await sharedPreferences.setString('ThemeMode', themeModeString);
  }

  @override
  Future<void> updateCategoryDelay(String category, int value) async {
    await sharedPreferences.setInt(category, value);
  }

  @override
  Future<void> updateTimeFormat(String format) async {
    await sharedPreferences.setString('format', format);
  }

  @override
  Future<void> updateLocale(Locale locale) async {
    final localeString = AppSettingsModel.localeToString(locale);
    await sharedPreferences.setString('locale', localeString);
  }
}

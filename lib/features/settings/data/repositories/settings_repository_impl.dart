import 'package:flutter/material.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

  @override
  Future<AppSettings> getSettings() async {
    return await localDataSource.getSettings();
  }

  @override
  Future<void> updateThemeMode(ThemeMode themeMode) async {
    await localDataSource.updateThemeMode(themeMode);
  }

  @override
  Future<void> updateCategoryDelay(String category, int value) async {
    await localDataSource.updateCategoryDelay(category, value);
  }

  @override
  Future<void> updateTimeFormat(String format) async {
    await localDataSource.updateTimeFormat(format);
  }

  @override
  Future<void> updateLocale(Locale locale) async {
    await localDataSource.updateLocale(locale);
  }
}

import 'package:flutter/material.dart';
import '../repositories/settings_repository.dart';

class UpdateThemeMode {
  final SettingsRepository repository;

  UpdateThemeMode(this.repository);

  Future<void> call(ThemeMode themeMode) async {
    await repository.updateThemeMode(themeMode);
  }
}

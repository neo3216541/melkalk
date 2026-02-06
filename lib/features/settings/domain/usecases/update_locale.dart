import 'package:flutter/material.dart';
import '../repositories/settings_repository.dart';

class UpdateLocale {
  final SettingsRepository repository;

  UpdateLocale(this.repository);

  Future<void> call(Locale locale) async {
    await repository.updateLocale(locale);
  }
}

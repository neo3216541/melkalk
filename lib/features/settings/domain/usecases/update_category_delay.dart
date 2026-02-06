import '../repositories/settings_repository.dart';

class UpdateCategoryDelay {
  final SettingsRepository repository;

  UpdateCategoryDelay(this.repository);

  Future<void> call(String category, int value) async {
    await repository.updateCategoryDelay(category, value);
  }
}

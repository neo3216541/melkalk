import '../repositories/settings_repository.dart';

class UpdateTimeFormat {
  final SettingsRepository repository;

  UpdateTimeFormat(this.repository);

  Future<void> call(String format) async {
    await repository.updateTimeFormat(format);
  }
}

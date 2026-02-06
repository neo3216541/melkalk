import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/update_category_delay.dart';
import '../../domain/usecases/update_theme_mode.dart';
import '../../domain/usecases/update_time_format.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings getSettings;
  final UpdateThemeMode updateThemeMode;
  final UpdateCategoryDelay updateCategoryDelay;
  final UpdateTimeFormat updateTimeFormat;

  SettingsBloc({
    required this.getSettings,
    required this.updateThemeMode,
    required this.updateCategoryDelay,
    required this.updateTimeFormat,
  }) : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateThemeModeEvent>(_onUpdateThemeMode);
    on<UpdateCategoryDelayEvent>(_onUpdateCategoryDelay);
    on<UpdateTimeFormatEvent>(_onUpdateTimeFormat);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());
    try {
      final settings = await getSettings();
      emit(SettingsLoaded(settings));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _onUpdateThemeMode(
    UpdateThemeModeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      try {
        await updateThemeMode(event.themeMode);
        final updatedSettings = currentSettings.copyWith(
          themeMode: event.themeMode,
        );
        emit(SettingsLoaded(updatedSettings));
      } catch (e) {
        emit(SettingsError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateCategoryDelay(
    UpdateCategoryDelayEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      try {
        await updateCategoryDelay(event.category, event.value);
        int? categoryADelay = currentSettings.categoryADelay;
        int? categoryBDelay = currentSettings.categoryBDelay;
        int? categoryCDelay = currentSettings.categoryCDelay;
        int? categoryDDelay = currentSettings.categoryDDelay;

        switch (event.category) {
          case 'CategoryADalay':
            categoryADelay = event.value;
            break;
          case 'CategoryBDalay':
            categoryBDelay = event.value;
            break;
          case 'CategoryCDalay':
            categoryCDelay = event.value;
            break;
          case 'CategoryDDalay':
            categoryDDelay = event.value;
            break;
        }

        final updatedSettings = currentSettings.copyWith(
          categoryADelay: categoryADelay,
          categoryBDelay: categoryBDelay,
          categoryCDelay: categoryCDelay,
          categoryDDelay: categoryDDelay,
        );
        emit(SettingsLoaded(updatedSettings));
      } catch (e) {
        emit(SettingsError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateTimeFormat(
    UpdateTimeFormatEvent event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      try {
        await updateTimeFormat(event.format);
        final updatedSettings = currentSettings.copyWith(
          timeFormat: event.format,
        );
        emit(SettingsLoaded(updatedSettings));
      } catch (e) {
        emit(SettingsError(e.toString()));
      }
    }
  }
}

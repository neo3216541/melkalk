import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/mel_calculator/domain/usecases/calculate_mel_dates.dart';
import '../../features/mel_calculator/presentation/bloc/mel_calculator_bloc.dart';
import '../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/get_settings.dart';
import '../../features/settings/domain/usecases/update_category_delay.dart';
import '../../features/settings/domain/usecases/update_locale.dart';
import '../../features/settings/domain/usecases/update_theme_mode.dart';
import '../../features/settings/domain/usecases/update_time_format.dart';
import '../../features/settings/presentation/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoCs
  sl.registerFactory(
    () => SettingsBloc(
      getSettings: sl(),
      updateThemeMode: sl(),
      updateCategoryDelay: sl(),
      updateTimeFormat: sl(),
      updateLocale: sl(),
    ),
  );

  sl.registerFactory(
    () => MelCalculatorBloc(
      calculateMelDates: sl(),
    ),
  );

  // Use cases - Settings
  sl.registerLazySingleton(() => GetSettings(sl()));
  sl.registerLazySingleton(() => UpdateThemeMode(sl()));
  sl.registerLazySingleton(() => UpdateCategoryDelay(sl()));
  sl.registerLazySingleton(() => UpdateTimeFormat(sl()));
  sl.registerLazySingleton(() => UpdateLocale(sl()));

  // Use cases - MEL Calculator
  sl.registerLazySingleton(() => CalculateMelDates());

  // Repository
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/di/injection_container.dart' as di;
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'features/settings/presentation/bloc/settings_event.dart';
import 'features/settings/presentation/bloc/settings_state.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<SettingsBloc>()..add(LoadSettings()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          ThemeMode themeMode = ThemeMode.dark;

          if (state is SettingsLoaded) {
            themeMode = state.settings.themeMode;
          }

          return MaterialApp.router(
            title: 'MEL Calculator',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: themeMode,
            routerConfig: AppRouter.router,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('de'),
              Locale('es'),
              Locale('fr'),
              Locale('it'),
              Locale('pt'),
              Locale('pt', 'BR'),
              Locale('ru'),
              Locale('uk'),
              Locale('zh'),
              Locale('zh', 'TW'),
              Locale('ja'),
              Locale('ko'),
              Locale('ar'),
              Locale('nl'),
              Locale('pl'),
              Locale('tr'),
              Locale('sv'),
              Locale('da'),
              Locale('no'),
              Locale('fi'),
              Locale('cs'),
              Locale('hu'),
              Locale('ro'),
              Locale('el'),
              Locale('he'),
              Locale('th'),
              Locale('vi'),
              Locale('id'),
              Locale('hi'),
            ],
          );
        },
      ),
    );
  }
}

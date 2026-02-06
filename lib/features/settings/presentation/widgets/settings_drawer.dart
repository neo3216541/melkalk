import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/services/yandex_interstitial_ad_service.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

enum TimeType { t12, t24 }

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key});

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  late TextEditingController _categoryAController;
  late TextEditingController _categoryBController;
  late TextEditingController _categoryCController;
  late TextEditingController _categoryDController;

  static const List<Locale> _supportedLocales = [
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
  ];

  static String _getLanguageName(Locale locale) {
    final Map<String, String> languageNames = {
      'en': 'English',
      'de': 'Deutsch',
      'es': 'Español',
      'fr': 'Français',
      'it': 'Italiano',
      'pt': 'Português',
      'ru': 'Русский',
      'uk': 'Українська',
      'zh': '中文',
      'ja': '日本語',
      'ko': '한국어',
      'ar': 'العربية',
      'nl': 'Nederlands',
      'pl': 'Polski',
      'tr': 'Türkçe',
      'sv': 'Svenska',
      'da': 'Dansk',
      'no': 'Norsk',
      'fi': 'Suomi',
      'cs': 'Čeština',
      'hu': 'Magyar',
      'ro': 'Română',
      'el': 'Ελληνικά',
      'he': 'עברית',
      'th': 'ไทย',
      'vi': 'Tiếng Việt',
      'id': 'Bahasa Indonesia',
      'hi': 'हिन्दी',
    };

    final key = locale.countryCode != null && locale.countryCode!.isNotEmpty
        ? '${locale.languageCode}_${locale.countryCode}'
        : locale.languageCode;
    return languageNames[key] ??
        languageNames[locale.languageCode] ??
        locale.languageCode;
  }

  @override
  void initState() {
    super.initState();
    _categoryAController = TextEditingController();
    _categoryBController = TextEditingController();
    _categoryCController = TextEditingController();
    _categoryDController = TextEditingController();
  }

  @override
  void dispose() {
    _categoryAController.dispose();
    _categoryBController.dispose();
    _categoryCController.dispose();
    _categoryDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is SettingsLoaded) {
          final settings = state.settings;

          if (_categoryAController.text.isEmpty) {
            _categoryAController.text = settings.categoryADelay.toString();
            _categoryBController.text = settings.categoryBDelay.toString();
            _categoryCController.text = settings.categoryCDelay.toString();
            _categoryDController.text = settings.categoryDDelay.toString();
          }

          TimeType timeType =
              settings.timeFormat == 'jm' ? TimeType.t12 : TimeType.t24;

          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 26.0,
                    horizontal: 16,
                  ),
                  child: Text(
                    l10n.appTitle,
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(height: 1, thickness: 1),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(l10n.customizeCategories),
                ),
                _buildCategoryField(
                  context,
                  l10n.categoryA,
                  _categoryAController,
                  'CategoryADalay',
                ),
                _buildCategoryField(
                  context,
                  l10n.categoryB,
                  _categoryBController,
                  'CategoryBDalay',
                ),
                _buildCategoryField(
                  context,
                  l10n.categoryC,
                  _categoryCController,
                  'CategoryCDalay',
                ),
                _buildCategoryField(
                  context,
                  l10n.categoryD,
                  _categoryDController,
                  'CategoryDDalay',
                ),
                const Divider(height: 1, thickness: 1),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(l10n.timeFormat),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(l10n.format12),
                        leading: Radio<TimeType>(
                          value: TimeType.t12,
                          groupValue: timeType,
                          onChanged: (TimeType? value) {
                            context.read<SettingsBloc>().add(
                                  const UpdateTimeFormatEvent('jm'),
                                );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(l10n.format24),
                        leading: Radio<TimeType>(
                          value: TimeType.t24,
                          groupValue: timeType,
                          onChanged: (TimeType? value) {
                            context.read<SettingsBloc>().add(
                                  const UpdateTimeFormatEvent('Hm'),
                                );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(height: 1, thickness: 1),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(l10n.language),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: DropdownButton<Locale>(
                    value: settings.locale,
                    isExpanded: true,
                    onChanged: (Locale? newLocale) {
                      if (newLocale != null) {
                        context.read<SettingsBloc>().add(
                              UpdateLocaleEvent(newLocale),
                            );
                      }
                    },
                    items: _supportedLocales.map((locale) {
                      return DropdownMenuItem(
                        value: locale,
                        child: Text(_getLanguageName(locale)),
                      );
                    }).toList(),
                  ),
                ),
                const Divider(height: 1, thickness: 1),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: DropdownButton<ThemeMode>(
                    value: settings.themeMode,
                    isExpanded: true,
                    onChanged: (ThemeMode? newThemeMode) {
                      if (newThemeMode != null) {
                        context.read<SettingsBloc>().add(
                              UpdateThemeModeEvent(newThemeMode),
                            );
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text(l10n.systemTheme),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text(l10n.lightTheme),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text(l10n.darkTheme),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(l10n.thanksMessage),
                ),
              ],
            ),
          );
        }

        return const Drawer(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildCategoryField(
    BuildContext context,
    String label,
    TextEditingController controller,
    String categoryKey,
  ) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: () async {
          final value = int.tryParse(controller.text) ?? 0;
          context.read<SettingsBloc>().add(
                UpdateCategoryDelayEvent(categoryKey, value),
              );

          // Увеличиваем счётчик и показываем рекламу если нужно
          final adService = sl<YandexInterstitialAdService>();
          await adService.onSaveAction();

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.categorySaved(label)),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
      ),
      title: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

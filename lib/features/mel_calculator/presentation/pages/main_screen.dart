import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/months.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/presentation/bloc/settings_state.dart';
import '../../../settings/presentation/widgets/settings_drawer.dart';
import '../bloc/mel_calculator_bloc.dart';
import '../bloc/mel_calculator_event.dart';
import '../bloc/mel_calculator_state.dart';
import '../widgets/yandex_banner_ad.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final bloc = sl<MelCalculatorBloc>();
            final settingsState = context.read<SettingsBloc>().state;
            if (settingsState is SettingsLoaded) {
              bloc.add(
                CalculateMelDatesEvent(
                  categoryADelay: settingsState.settings.categoryADelay,
                  categoryBDelay: settingsState.settings.categoryBDelay,
                  categoryCDelay: settingsState.settings.categoryCDelay,
                  categoryDDelay: settingsState.settings.categoryDDelay,
                ),
              );
            }
            return bloc;
          },
        ),
      ],
      child: const MainScreenContent(),
    );
  }
}

class MainScreenContent extends StatelessWidget {
  const MainScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, settingsState) {
        if (settingsState is SettingsLoaded) {
          context.read<MelCalculatorBloc>().add(
                CalculateMelDatesEvent(
                  categoryADelay: settingsState.settings.categoryADelay,
                  categoryBDelay: settingsState.settings.categoryBDelay,
                  categoryCDelay: settingsState.settings.categoryCDelay,
                  categoryDDelay: settingsState.settings.categoryDDelay,
                ),
              );
        }
      },
      child: Scaffold(
        drawer: const SettingsDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppLocalizations.of(context)!.appTitle),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<SettingsBloc, SettingsState>(
                              builder: (context, settingsState) {
                                if (settingsState is SettingsLoaded) {
                                  return BlocBuilder<MelCalculatorBloc,
                                      MelCalculatorState>(
                                    builder: (context, melState) {
                                      if (melState is MelCalculatorLoaded) {
                                        return _buildDataCard(
                                          context,
                                          melState.categories,
                                          settingsState.settings.timeFormat,
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  );
                                }
                                return const CircularProgressIndicator();
                              },
                            ),
                            const SizedBox(height: 10),
                            _buildInfoCard(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Баннерная реклама внизу экрана
              const YandexBannerAd(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataCard(
    BuildContext context,
    List<dynamic> categories,
    String timeFormat,
  ) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    final newFormat = DateFormat(timeFormat);
    final l10n = AppLocalizations.of(context)!;
    final monthStrings = getMonthStrings(context);

    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 51, 204, 255),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: categories.map((category) {
                final date = category.calculatedDate;
                final formattedDate =
                    "${monthStrings[date.month]}  ${date.day}, ${date.year} at ${newFormat.format(date)}";

                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        l10n.categoryWithDays(
                          category.name,
                          category.delayDays,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        Positioned(
          left: 50,
          top: 12,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              color: color,
            ),
            child: Text(
              l10n.aircraftOnGround,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 51, 204, 255),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.infoDescription,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 50,
          top: 12,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              color: color,
            ),
            child: Text(
              l10n.info,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}

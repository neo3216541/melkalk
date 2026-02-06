import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

          TimeType timeType = settings.timeFormat == 'jm'
              ? TimeType.t12
              : TimeType.t24;

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
                    'MEL calculator',
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(height: 1, thickness: 1),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Customize categories'),
                ),
                _buildCategoryField(
                  context,
                  'Category A',
                  _categoryAController,
                  'CategoryADalay',
                ),
                _buildCategoryField(
                  context,
                  'Category B',
                  _categoryBController,
                  'CategoryBDalay',
                ),
                _buildCategoryField(
                  context,
                  'Category C',
                  _categoryCController,
                  'CategoryCDalay',
                ),
                _buildCategoryField(
                  context,
                  'Category D',
                  _categoryDController,
                  'CategoryDDalay',
                ),
                const Divider(height: 1, thickness: 1),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Time format'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('12'),
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
                        title: const Text('24'),
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
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('System Theme'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Light Theme'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Dark Theme'),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Many thanks to my friend Dmitry Gordeev for his ideas, support and encouragement.",
                  ),
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
    return ListTile(
      trailing: IconButton(
        icon: const Icon(Icons.save),
        onPressed: () {
          final value = int.tryParse(controller.text) ?? 0;
          context.read<SettingsBloc>().add(
                UpdateCategoryDelayEvent(categoryKey, value),
              );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label saved'),
              duration: const Duration(seconds: 1),
            ),
          );
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

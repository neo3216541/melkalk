import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppSettings extends Equatable {
  final ThemeMode themeMode;
  final int categoryADelay;
  final int categoryBDelay;
  final int categoryCDelay;
  final int categoryDDelay;
  final String timeFormat;
  final Locale locale;

  const AppSettings({
    required this.themeMode,
    required this.categoryADelay,
    required this.categoryBDelay,
    required this.categoryCDelay,
    required this.categoryDDelay,
    required this.timeFormat,
    required this.locale,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    int? categoryADelay,
    int? categoryBDelay,
    int? categoryCDelay,
    int? categoryDDelay,
    String? timeFormat,
    Locale? locale,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      categoryADelay: categoryADelay ?? this.categoryADelay,
      categoryBDelay: categoryBDelay ?? this.categoryBDelay,
      categoryCDelay: categoryCDelay ?? this.categoryCDelay,
      categoryDDelay: categoryDDelay ?? this.categoryDDelay,
      timeFormat: timeFormat ?? this.timeFormat,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        categoryADelay,
        categoryBDelay,
        categoryCDelay,
        categoryDDelay,
        timeFormat,
        locale,
      ];
}

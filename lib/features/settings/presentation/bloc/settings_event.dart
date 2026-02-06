import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class UpdateThemeModeEvent extends SettingsEvent {
  final ThemeMode themeMode;

  const UpdateThemeModeEvent(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

class UpdateCategoryDelayEvent extends SettingsEvent {
  final String category;
  final int value;

  const UpdateCategoryDelayEvent(this.category, this.value);

  @override
  List<Object?> get props => [category, value];
}

class UpdateTimeFormatEvent extends SettingsEvent {
  final String format;

  const UpdateTimeFormatEvent(this.format);

  @override
  List<Object?> get props => [format];
}

class UpdateLocaleEvent extends SettingsEvent {
  final Locale locale;

  const UpdateLocaleEvent(this.locale);

  @override
  List<Object?> get props => [locale];
}

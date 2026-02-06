import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      brightness: Brightness.dark,
      radioTheme: ThemeData.dark().radioTheme.copyWith(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (!states.contains(WidgetState.disabled)) {
            return Colors.blue;
          } else {
            return Colors.blue.withOpacity(.25);
          }
        }),
      ),
    );
  }
}

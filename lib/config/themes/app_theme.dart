import 'package:flutter/material.dart';
import 'widgets_theme/elevated_button_theme.dart';
import 'widgets_theme/text_theme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData getApplicationLightTheme() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        textTheme: AppTextTheme.lightTextTheme,
        elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonLightTheme);
  }

  static ThemeData getApplicationDarkTheme() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: AppTextTheme.darkTextTheme,
        elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonDarkTheme);
  }
}

import 'package:baraneq/config/themes/widgets_theme/tab_bar_theme.dart';

import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';
import 'widgets_theme/elevated_button_theme.dart';
import 'widgets_theme/text_theme.dart';

class AppTheme {
  AppTheme._();
  static ThemeData getApplicationLightTheme() {
    return ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        fontFamily: 'Cairo',
        brightness: Brightness.light,
        textTheme: AppTextTheme.lightTextTheme,
        tabBarTheme: AppTapBarTheme.tabBarLightTheme,
        elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonLightTheme);
  }

  static ThemeData getApplicationDarkTheme() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        textTheme: AppTextTheme.darkTextTheme,
        tabBarTheme: AppTapBarTheme.tabBarDarkTheme,
        elevatedButtonTheme: AppElevatedButtonTheme.elevatedButtonDarkTheme);
  }
}

import 'package:flutter/material.dart';


import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_values.dart';
import 'text_theme.dart';

class AppElevatedButtonTheme {
  static ElevatedButtonThemeData elevatedButtonLightTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: AppTextTheme.darkTextTheme.labelLarge!.copyWith(
        fontSize: AppValues.font*24
      ),
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppValues.radius * 15,
        ),
      ),
    ),
  );

  static ElevatedButtonThemeData elevatedButtonDarkTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: AppTextTheme.lightTextTheme.labelLarge,
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppValues.radius * 15,
        ),
      ),
    ),
  );
}

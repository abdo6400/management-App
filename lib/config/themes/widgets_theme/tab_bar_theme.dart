import 'package:baraneq/core/utils/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/utils/app_colors.dart';

class AppTapBarTheme {
  static TabBarTheme tabBarLightTheme = TabBarTheme(
    labelColor: AppColors.black,
    unselectedLabelColor: AppColors.grey,
    labelPadding: EdgeInsets.symmetric(horizontal: AppValues.paddingWidth * 5),
    indicator: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppColors.primary,
          width: 2.0,
        ),
      ),
    ),
  );

  static TabBarTheme tabBarDarkTheme = TabBarTheme(
    labelColor: AppColors.white,
    unselectedLabelColor: AppColors.grey,
    labelPadding: EdgeInsets.symmetric(horizontal: AppValues.paddingWidth * 5),
    indicator: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppColors.primary,
          width: 2.0,
        ),
      ),
    ),
  );
}

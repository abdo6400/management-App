import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/app_colors.dart';

class AppTextTheme {
  static TextTheme lightTextTheme = GoogleFonts.cairoTextTheme(TextTheme(
    displayLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.black), // Page titles
    bodyLarge:
        TextStyle(fontSize: 14.sp, color: AppColors.black), // Paragraph text
    titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black), // List titles
    titleSmall: TextStyle(
        fontSize: 16.sp,
        color: AppColors.black), // List item titles, Important text snippets
    bodySmall: TextStyle(
        fontSize: 14.sp, color: Colors.grey), // Secondary text, Captions
    labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black), // Buttons, Tabs
  ));
  static TextTheme darkTextTheme = GoogleFonts.cairoTextTheme(TextTheme(
    displayLarge: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.normal,
        color: AppColors.white), // Page titles
    bodyLarge:
        TextStyle(fontSize: 14.sp, color: AppColors.white), // Paragraph text
    titleMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white), // List titles
    titleSmall: TextStyle(
        fontSize: 16.sp,
        color: AppColors.white), // List item titles, Important text snippets
    bodySmall: TextStyle(
        fontSize: 14.sp, color: Colors.grey), // Secondary text, Captions
    labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white), // Buttons, Tabs
  ));
}

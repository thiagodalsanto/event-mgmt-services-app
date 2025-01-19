// res/theme/themes.dart
import 'package:calendar_mgmt_services_app/res/colors/app_colors.dart';
import 'package:calendar_mgmt_services_app/res/theme/font_themes.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      surface: AppColors.backgroundColor,
    ),
    textTheme: const TextTheme(
      headlineLarge: FontThemes.headlineLarge,
      headlineMedium: FontThemes.headlineMedium,
      bodyLarge: FontThemes.bodyLarge,
      bodySmall: FontThemes.bodySmall,
    ),
    useMaterial3: true,
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      surface: Colors.black,
    ),
    textTheme: TextTheme(
      headlineLarge: FontThemes.headlineLarge.copyWith(color: Colors.white),
      headlineMedium: FontThemes.headlineMedium.copyWith(color: Colors.white),
      bodyLarge: FontThemes.bodyLarge.copyWith(color: Colors.white),
      bodySmall: FontThemes.bodySmall.copyWith(color: Colors.white),
    ),
    useMaterial3: true,
  );
}

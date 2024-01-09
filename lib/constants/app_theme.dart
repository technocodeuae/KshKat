
import 'package:flutter/material.dart';
import 'app_constants.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: FontFamily.productSans,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme(brightness: Brightness.light, primary: AppColors.primaryColor, onPrimary: AppColors.primaryColor, secondary: AppColors.primaryColor, onSecondary: AppColors.primaryColor, error: AppColors.primaryColor, onError: AppColors.primaryColor, background: AppColors.primaryColor, onBackground: AppColors.primaryColor, surface: AppColors.primaryColor, onSurface: AppColors.primaryColor),
    // AppColors.primaryColor
    // accentColor: AppColors.primaryColor,
    // accentColorBrightness: Brightness.light
);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme(brightness: Brightness.dark, primary: AppColors.primaryColor, onPrimary: AppColors.primaryColor, secondary: AppColors.primaryColor, onSecondary: AppColors.primaryColor, error: AppColors.primaryColor, onError: AppColors.primaryColor, background: AppColors.primaryColor, onBackground: AppColors.primaryColor, surface: AppColors.primaryColor, onSurface: AppColors.primaryColor),

  // primaryColorBrightness: Brightness.dark,
  // accentColor: AppColors.primaryColor,
  // accentColorBrightness: Brightness.dark,
);
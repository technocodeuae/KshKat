
import 'package:flutter/material.dart';
import 'app_constants.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: FontFamily.productSans,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.primaryColor,
    accentColorBrightness: Brightness.light
);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.productSans,
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryColor,
  primaryColorBrightness: Brightness.dark,
  accentColor: AppColors.primaryColor,
  accentColorBrightness: Brightness.dark,
);
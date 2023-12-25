import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

enum TextFontType { lato, ptSans, Raleway, Roboto, Cairo, pcifico }

class AppConfigs {
  AppConfigs._();

  static const bool isDebugMode = true;

  static const double zoomTextSize = 1.15;

  ///
  /// if you need change font family just change type parameters that passed to getFont Function.
  ///
  static var baseFont = _getFont(type: TextFontType.Cairo);

  static TextStyle _getFont({required TextFontType type}) {
    switch (type) {
      case TextFontType.lato:
        return GoogleFonts.lato();
      case TextFontType.ptSans:
        return GoogleFonts.ptSans();
      case TextFontType.Raleway:
        return GoogleFonts.raleway();
      case TextFontType.Roboto:
        return GoogleFonts.roboto();
      case TextFontType.Cairo:
        return GoogleFonts.cairo();
      case TextFontType.pcifico:
        return GoogleFonts.pacifico();
      default:
        return GoogleFonts.cairo();
    }
  }

  static bool isEqualDate(DateTime dateTime, DateTime dateTime2) {
    return dateTime.day == dateTime2.day &&
        dateTime.month == dateTime2.month &&
        dateTime.year == dateTime2.year;
  }
}

import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const primaryColor = Color(0xff094a85);
  static const secondaryColor = Color(0xff4367bc);
  static const lightSecondaryColor = Color(0xff678be0);

  static const white = Colors.white;
  static const black = Colors.black;
  static const purple = Color(0xff894993);
  static const light_purple = Color(0xffA676AD);
  static const dark_green = Color(0xff1c397d);
  static const gray = Color(0xff4E4E4E);
  static const light_gray = Color(0xffF6F7FB);
  static const transparent = Colors.transparent;

  static const Color mainColor = Color(0xff39569a);
  static const Color linkedinButBorder = Color(0xff0A66C2);
  static const Color mainRed = Color(0xffc61c06);
  static const Color darkRed = Color(0xffb90504);
  static const Color mainGray = Color(0xff707070);
  static const Color lightGrey = Color(0xffE3E3E3);
  static const Color chartGray = Color(0xff979797);
  static const Color mainOrange = Color(0xffEBAC2D);
  static const Color darkOrange = Color(0xffFDA12C);
  static const Color mainYellow = Color(0xffFDC71F);
  static const Color mainGreen = Color(0xff244289);
  static const Color darkGreen = Color(0xff4367bc);
  static const Color secondaryGreen = Color(0xff678be0);
  static const Color indicatorBGColor = Color(0xff15166f);

  static const Color scaffoldBGColor = Color(0xf1bb0ce);
  static const Color appBarBGColor = Color(0xf1bb0ce);
  static const Color darkGrayColor = Color(0xff362f2f);
  static const Color mainContainColor = Color(0xf1bb0ce);
  static const Color pinkContainColor = Color(0xffe6d5c1);
  static const Color secondaryContainColor = Color(0x801bb0ce);
  static const Color textMainColor = Color(0xff4f8699);
  static const Color textNaveColor = Color(0xff15166f);
  static const Color borderColor = Color(0xff707070);
  static const Color buttonColor = Color(0x8c1bb0ce);

}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

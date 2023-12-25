import 'package:flutter/material.dart';

import 'app_constants.dart';

class AppTextStyle {
  /// BEGINNING OF THE STANDARD TEXT STYLES ---------------------------------
  final headline1 = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.headline1,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingH1,
    fontWeight: AppFontWeight.light,
  );

  final headline2 = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.headline2,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingH2,
    fontWeight: AppFontWeight.light,
  );

  final headline3 = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.headline3,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingH3,
    fontWeight: AppFontWeight.light,
  );

  final headline4 = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.headline4,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingH4,
    fontWeight: AppFontWeight.regular,
  );

  final headline5 = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.headline5,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingH5,
    fontWeight: AppFontWeight.regular,
  );

  final headline6 = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.headline6,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingH6,
    fontWeight: AppFontWeight.medium,
  );

  final subTitle1 = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.subtitle1,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingSub1,
    fontWeight: AppFontWeight.bold,
  );

  final subTitle2 = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.subtitle2,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingSub2,
    fontWeight: AppFontWeight.medium,
  );

  final body1 = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.body1,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingBody1,
    fontWeight: AppFontWeight.regular,
  );

  final body2 = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.body2,
    fontFamily: FontFamily.productSans,
    fontWeight: AppFontWeight.bold,
  );

  final button = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.body2,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingButton,
    fontWeight: AppFontWeight.medium,
  );

  final caption = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.caption,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingCaption,
    fontWeight: AppFontWeight.regular,
  );

  final overLine = TextStyle(
    color: AppColors.black,
    fontSize: AppTextSize.overLine,
    fontFamily: FontFamily.productSans,
    letterSpacing: appLetterSpacing.letterSpacingOverLine,
    fontWeight: AppFontWeight.regular,
  );

  /// END OF THE STANDARD TEXT STYLES ---------------------------------

  final hugeTSBasic = TextStyle(
    fontSize: AppTextSize.huge,
    fontFamily: FontFamily.productSans,
    color: AppColors.black,
  );

  final largestTSBasic = TextStyle(
    fontSize: AppTextSize.largest,
    fontFamily: FontFamily.productSans,
    color: AppColors.black,
  );

  final largerTSBasic = TextStyle(
    fontSize: AppTextSize.larger,
    fontFamily: FontFamily.productSans,
    color: AppColors.black,
  );
  final subLargeTSBasic = TextStyle(
    fontSize: AppTextSize.subLarge,
    fontFamily: FontFamily.productSans,
    color: AppColors.black,
  );

  final bigTSBasic = TextStyle(
    fontSize: AppTextSize.big,
    fontFamily: FontFamily.productSans,
  );

  //========================subBig======================================

  final subBigTSBasic = TextStyle(
    fontSize: AppTextSize.subBig,
    fontFamily: FontFamily.productSans,
  );

  final subBigTSBasicBold = TextStyle(
    fontSize: AppTextSize.subBig,
    fontFamily: FontFamily.productSans,
      fontWeight: FontWeight.bold
  );

  //========================normal======================================

  final normalTSBasic = TextStyle(
    fontSize: AppTextSize.normal,
    fontFamily: FontFamily.productSans,
  );

  final normalTSBasicBold = TextStyle(
      fontSize: AppTextSize.normal,
      fontFamily: FontFamily.productSans,
      fontWeight: FontWeight.bold
  );

//=========================middle======================================

  final middleTSBasic = TextStyle(
    fontSize: AppTextSize.middle,
    fontFamily: FontFamily.productSans,
      fontWeight: FontWeight.bold

  );

  TextStyle titleHeaderStyle = TextStyle(
    color: AppColors.mainColor,
    fontSize: AppTextSize.small,
  );

  StrutStyle titleHeaderStrutStyle= StrutStyle(
    fontSize: AppTextSize.small,
    forceStrutHeight: true,
  );

  //=========================small======================================

  final smallTSBasic = TextStyle(
    fontSize: AppTextSize.small,
    fontFamily: FontFamily.productSans,
      fontWeight: FontWeight.bold
  );

  //========================min======================================
  final minTSBasic = TextStyle(
    fontSize: AppTextSize.min,
    fontFamily: FontFamily.productSans,
    fontWeight: FontWeight.bold
  );


  final midSmallTSBasic = TextStyle(
      fontSize: AppTextSize.middleSmall,
      fontFamily: FontFamily.productSans,
      fontWeight: FontWeight.bold
  );

  //========================sub-min======================================

  final subMinTSBasic = TextStyle(
    fontSize: AppTextSize.subMin,
    fontFamily: FontFamily.productSans,
    fontWeight: FontWeight. bold
  );

  final subBigBasic = TextStyle(
      fontSize: AppTextSize.normal,
      fontFamily: FontFamily.productSans,
      fontWeight: FontWeight. bold
  );

  //========================sub-2-min======================================

  final sub2MinTSBasic = TextStyle(
    fontSize: AppTextSize.sub2Min,
    fontFamily: FontFamily.productSans,
  );

  //========================sub-3-min======================================

  final sub3MinTSBasic = TextStyle(
    fontSize: AppTextSize.sub3Min,
    fontFamily: FontFamily.productSans,
  );

//================================================================================//

}

AppTextStyle appTextStyle = AppTextStyle();

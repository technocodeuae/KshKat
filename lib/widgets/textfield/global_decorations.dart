import 'package:flutter/material.dart';
import 'package:erp/constants/app_constants.dart';


abstract class GlobalDecorations {
  static InputDecoration get kNormalFieldInputDecoration => InputDecoration(
      labelStyle: appTextStyle.smallTSBasic.copyWith(color: AppColors.black),
      errorStyle: appTextStyle.subMinTSBasic.copyWith(
        color: Colors.red,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.mainGray),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.mainGray),
      ));

  static InputDecoration get normalFieldUerManagementNInputDecoration =>
      InputDecoration(
        hintStyle: TextStyle(color: AppColors.mainGray),
        alignLabelWithHint: true,
        fillColor: AppColors.white,
        filled: true,
        labelStyle: appTextStyle.smallTSBasic.copyWith(color: AppColors.black),
        errorStyle: appTextStyle.subMinTSBasic.copyWith(
          color: Colors.red,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.radius16)),
          borderSide: BorderSide(color: AppColors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppRadius.radius16),
          ),
        ),
      );

  static InputDecoration get kBorderFieldInputDecoration => InputDecoration(
        alignLabelWithHint: false,
        labelStyle: appTextStyle.normalTSBasic,
        errorStyle: appTextStyle.subMinTSBasic.copyWith(
          color: Colors.red,
        ),
        filled: false,
      );

  static InputDecoration get underLineVerificationCOdeFieldInputDecoration =>
      InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 4),
          borderRadius: BorderRadius.only(),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor, width: 4),
          borderRadius: BorderRadius.only(),
        ),
        filled: false,
        errorStyle: appTextStyle.middleTSBasic.copyWith(
          color: Colors.red,
        ),
      );
}

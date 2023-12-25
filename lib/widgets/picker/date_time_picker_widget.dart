import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:erp/constants/app_constants.dart';

class SelectDateTimePickerHelper {
  selectDate(
      {required BuildContext context,
      required DateTime initialDate,
      required int firstDate,
      required int lastDate,
      required Function(DateTime) onPick}) async {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return _buildMaterialDatePicker(
            context: context,
            firstDate: firstDate,
            initialDate: initialDate,
            lastDate: lastDate,
            onPick: onPick);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return _buildCupertinoDatePicker(
            context: context,
            firstDate: firstDate,
            initialDate: initialDate,
            lastDate: lastDate,
            onPick: onPick);
    }
  }

  /// This builds material date picker in Android
  _buildMaterialDatePicker(
      {required BuildContext context,
      required DateTime initialDate,
      required int firstDate,
      required int lastDate,
      required Function(DateTime) onPick}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(firstDate),
      lastDate: DateTime(lastDate),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.mainColor,
              onPrimary: Colors.white,
              surface: AppColors.lightGrey,
              onSurface: AppColors.mainColor,
              background: AppColors.lightGrey,
            ),
            dialogBackgroundColor:Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) onPick(picked);
  }

  /// This builds cupertion date picker in iOS
  _buildCupertinoDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required int firstDate,
    required int lastDate,
    required Function(DateTime) onPick,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != null) onPick(picked);
              },
              initialDateTime: initialDate,
              minimumYear: firstDate,
              maximumYear: lastDate,
            ),
          );
        });
  }


  
}

SelectDateTimePickerHelper selectDateTimePickerHelper = SelectDateTimePickerHelper();

import 'package:flutter/material.dart';
import 'package:erp/constants/app_constants.dart';


class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T?> onChanged;
  final T value;
  final bool isEnabled;
  final String hint;
  final double borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Color? iconColor;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final Color? fillColor;
  final DropdownButtonBuilder selectedItemBuilder;


  CustomDropdown({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    required this.value,
    required this.selectedItemBuilder,
    this.isEnabled = true,
    this.borderRadius = 0.0,
    this.hint = '',
    this.iconColor,
    this.padding,
    this.iconSize,
    this.borderColor,
    this.borderWidth,
    this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: Container(
        padding:padding?? null,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            border: Border.all(
              color: borderColor ?? AppColors.transparent,
              style: BorderStyle.solid,
              width: borderWidth??1.0,
            ),
            color: isEnabled
                ? fillColor ?? Colors.white
                : Colors.grey.withAlpha(100)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            dropdownColor: AppColors.white,
            // itemHeight: 50.0,
            style: appTextStyle.smallTSBasic.copyWith(
                color: AppColors.mainColor,
                decorationThickness: 0,),
            icon: Icon(
              Icons.arrow_back_ios,
              size: iconSize??25,
              color: iconColor ?? AppColors.mainColor,
            ),
            items: dropdownMenuItemList,
            onChanged: onChanged,
            elevation: 2,
            hint: Container(
              padding: EdgeInsets.only(
                  left: AppDimens.space6, right: AppDimens.space6),
              child: Text(
                '$hint',
                style: appTextStyle.smallTSBasic.copyWith(color: AppColors.mainGray),
              ),
            ),

            value: value,
            selectedItemBuilder: selectedItemBuilder,
          ),
        ),
      ),
    );
  }
}

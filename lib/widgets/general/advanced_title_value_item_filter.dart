import 'package:flutter/material.dart';
import 'package:erp/constants/app_constants.dart';

class AdvancedTitleValueItemFilter extends StatelessWidget {
  final String title;
  final String? value;
  final VoidCallback onPressed;
  const AdvancedTitleValueItemFilter({required this.title,this.value, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.space8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                title,
                style: appTextStyle.smallTSBasic.copyWith(
                    color: AppColors.black, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              child: Text(
                value ?? "",
                style: appTextStyle.minTSBasic.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterDividerWidget extends StatelessWidget {
  final double? height;
  final Color? color;

  const FilterDividerWidget({this.height, this.color});
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 5.0,
      thickness: .5,
      color: color ?? Colors.grey,
    );
  }
}


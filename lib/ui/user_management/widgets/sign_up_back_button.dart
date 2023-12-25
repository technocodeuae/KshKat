import 'package:flutter/material.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/utils/locale/app_localization.dart';

class SignUpBackButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const SignUpBackButton({required this.title,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap:
          onPressed,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: AppColors.mainColor,
              ),
              Text(
                AppLocalizations.of(context).translate('back_to'),
                style: appTextStyle.smallTSBasic
                    .copyWith(color: AppColors.mainColor),
              ),
              HorizontalPadding(
                percentage: .01,
              ),
              Text(
                title,
                style: appTextStyle.smallTSBasic.copyWith(
                    color: AppColors.mainColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

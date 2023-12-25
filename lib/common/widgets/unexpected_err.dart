import 'package:flutter/material.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/constants/text_style.dart';
import 'package:erp/utils/locale/app_localization.dart';

class UnexpectedError extends StatelessWidget {
  final VoidCallback onPressed;

  const UnexpectedError({Key? key, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   Assets.unexpectedError,
              //   width: 240,
              //   height: 240,
              // ),
              Text(
                AppLocalizations.of(context).translate('unexpected_err'),
                style: appTextStyle.smallTSBasic,
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppRadius.radius6),
                      ),
                    )
                ),
                child: Text(
                  AppLocalizations.of(context).translate('retry'),
                  style: appTextStyle.smallTSBasic
                      .copyWith(color: AppColors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

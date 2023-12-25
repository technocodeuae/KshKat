import 'package:flutter/material.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';

import 'user_management_text_title_widget.dart';

class TopUserManagementSectionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double widthC = DeviceUtils.getScaledWidth(context, 1);
    double heightC = DeviceUtils.getScaledHeight(context, 1);
    return Container(
      child: Column(
        children: [
          Container(
            width: widthC,
            child: Row(
               crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    // AppAssets.main_logo,
                    width: 150,
                    height: 150,
                  ),
                ),
                HorizontalPadding(percentage: .03,),
              /*  Container(
                  child: Text(
                    AppLocalizations.of(context).translate("erp"),
                    style: appTextStyle.largerTSBasic.copyWith(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold,
                        height: 1.4
                    ),
                  ),
                )*/
              ],
            ),
          ),

          VerticalPadding(
            percentage: 0.05,
          ),

          UserManagementTextTitleWidget(
            title: AppLocalizations.of(context).translate("login_text_1"),
          ),
         /* UserManagementTextTitleWidget(
            title: AppLocalizations.of(context).translate("login_text_2"),
            style: appTextStyle.bigTSBasic.copyWith(
                color: AppColors.mainColor,
                height: 1.4,
                fontWeight: FontWeight.bold),
          ),*/
        ],
      ),
    );
  }
}

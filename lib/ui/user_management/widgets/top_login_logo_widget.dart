import 'package:flutter/material.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/constants/app_constants.dart';

class TopLoginLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AppAssets.appbar_icon,
              width: 35,
              height: 35,
            ),
            HorizontalPadding(percentage: .02,),

            Text("erp",
              style: appTextStyle.bigTSBasic.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white
              ),
            )

          ],
        ));
  }
}

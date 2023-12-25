import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';

class ItemOtherCardWidget extends StatelessWidget {
  final String title;
  final String svgIcon;
  final VoidCallback onPressed;
  const ItemOtherCardWidget({required this.title,required this.svgIcon,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onPressed,
        child: Card(
          color: AppColors.white,
          shadowColor: AppColors.mainGray.withOpacity(0.8),
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppRadius.radiusDefault))),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimens.space8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                VerticalPadding(percentage: 0.05,),
                Container(
                    width: 25,
                    height: 25,
                  child: SvgPicture.asset(
                    svgIcon,
                    width: 25,
                    height: 25,
                  )
                ),
                VerticalPadding(
                  percentage: 0.04,
                ),
                Container(
                    child: Text(
                      title,
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.mainColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                VerticalPadding(percentage: 0.05,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';

class ItemProfileCardWidget extends StatelessWidget {
  final String title;
  final IconData? svgIcon;
  final VoidCallback onPressed;
  const ItemProfileCardWidget({required this.title,required this.svgIcon,required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.space20,vertical: AppDimens.space2),
      child: InkWell(
        onTap: onPressed,
        child: Card(
          color: AppColors.white,
          shadowColor: AppColors.mainGray.withOpacity(0.6),
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppRadius.radius10))),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimens.space16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Container(
                    width: 40,
                    height: 40,
                  color: AppColors.light_gray,
                  child:
                  Icon(
                    svgIcon,
                    color:  AppColors.mainColor,
                    size: 20,
                  ),
                ),
                HorizontalPadding(
                  percentage: 0.035,
                ),
                Container(
                    child: Text(
                      title,
                      style: appTextStyle.smallTSBasic
                          .copyWith(color: AppColors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color:  AppColors.black,
                  size: 20,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

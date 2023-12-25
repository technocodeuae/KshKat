import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';

class ItemOtherQuickActionWidget extends StatelessWidget {
  final String title;
  final String description;
  final String svgIcon;
  final VoidCallback onPressed;
  const ItemOtherQuickActionWidget({required this.title,required this.svgIcon,required this.onPressed,required this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimens.space8),
          child: Row(
            children: [
              Container(
                  width: 22,
                  height: 22,
                  child: SvgPicture.asset(
                    svgIcon,
                    width: 22,
                    height: 22,
                  )
              ),

              HorizontalPadding(percentage: 0.05,),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                          title,
                          style: appTextStyle.middleTSBasic
                              .copyWith(color: AppColors.mainColor,fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                    VerticalPadding(percentage: 0.015,),
                    Container(
                        child: Text(
                          description,
                          style: appTextStyle.smallTSBasic
                              .copyWith(color: AppColors.mainGray),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

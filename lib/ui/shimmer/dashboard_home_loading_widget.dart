import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/widgets/base_shimmer.dart';

import 'icon_title_shimmer_widget.dart';


class DashboardHomeLoadingWidget extends StatelessWidget {
  final double width;
  final double height;
  const DashboardHomeLoadingWidget({required this.width,required this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: BaseShimmerWidget(
        child: Container(
          padding: const EdgeInsets.only(right: AppDimens.space8),
          child: Container(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 500),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [

                      Container(
                         width: double.infinity,
                        child: IconTitleShimmerWidget(
                          width: double.infinity,

                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),

        ),
      ),
    );
  }


  Widget _buildTop2Shimmer({required double width}){
    return Container(
      margin: const EdgeInsets.only(left: AppDimens.space4,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: AlignmentDirectional.centerStart,
            color: AppColors.white,
            width: width / 2.2,
            height: 15,
          ),
          VerticalPadding(
            percentage: 0.02,
          ),
          Container(
            width: width,
            height: 2,
            color: AppColors.white,

          ),
        ],
      ),
    );
  }
}

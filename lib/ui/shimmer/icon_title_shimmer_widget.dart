import 'package:flutter/material.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/widgets/base_shimmer.dart';

class IconTitleShimmerWidget extends StatelessWidget {

  final double width;
  final double? height;



  const IconTitleShimmerWidget({
    Key? key,
    required this.width,
    this.height,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: BaseShimmerWidget(
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.radiusDefault)),
              side: BorderSide(
                width: 1.5,
                color:AppColors.white,
              )
          ),
          child: Container(
            width: width,
            height: height ?? 150,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.all(Radius.circular(AppRadius.radiusDefault)),

            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: AppColors.white,
                    width: 45,
                    height: 45,
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: AppColors.white,
                        width: 90,
                        height: 10,
                      ),
                      VerticalPadding(percentage: 0.001,),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: AppColors.white,
                        width: 60,
                        height: 10,
                      ),
                      VerticalPadding(percentage: 0.01,),
                      Container(
                        alignment: AlignmentDirectional.center,
                        color: AppColors.white,
                        width: 60,
                        height: 10,
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

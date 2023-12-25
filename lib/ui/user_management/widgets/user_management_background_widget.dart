import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

class UserManagementBackgroundWidget extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final String lang;

  const UserManagementBackgroundWidget({Key? key,required this.child,required this.width, required this.height,required this.lang}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible){
          print("isKeyboardVisible $isKeyboardVisible");
        return Container(
          width: width,
          height: height,
          color: AppColors.white,
          child: Stack(
            fit: StackFit.expand,
            children: [
              isKeyboardVisible?Positioned(
                  top: -100,
                  left:lang=="Arabic"?0:width * .55,
                  right:lang=="Arabic"?width * .55:0 ,
                  child: ZoomOut(
                    delay: Duration(milliseconds: 500),
                    duration: Duration(milliseconds: 1500),
                    child: Container(
                      child: SvgPicture.asset(
                        lang=="Arabic"?AppAssets.user_management_background_ar:AppAssets.user_management_background,
                        color: AppColors.mainColor.withOpacity(0.8),
                        width: width,
                        height: height,
                      ),
                    ),
                  )) :

              lang=="Arabic"?Positioned(
                  top: -100,
                  right:width * .55,
                  child: FadeInUp(
                    delay: Duration(milliseconds: 500),
                    duration: Duration(milliseconds: 1500),
                    child: Container(
                      child: SvgPicture.asset(
                        AppAssets.user_management_background_ar,
                        width: width,
                        height: height,
                        color: AppColors.mainColor.withOpacity(0.8),
                      ),
                    ),
                  )):
              Positioned(
                  top: -100,
                  left:width * .55,
                  child: FadeInUp(
                    delay: Duration(milliseconds: 500),
                    duration: Duration(milliseconds: 1500),
                    child: Container(
                      child: SvgPicture.asset(
                        AppAssets.user_management_background,
                        color: AppColors.mainColor.withOpacity(0.8),
                        width: width,
                        height: height,
                      ),
                    ),
                  )),
              child
            ],
          ),
        );
      }
    );
  }
}

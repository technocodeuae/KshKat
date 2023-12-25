import 'package:erp/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AccountIcon extends StatelessWidget {
  final Color? color;
  final double? width;
  final double? height;

  const AccountIcon({Key? key, this.color, this.width,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SvgPicture.asset(
        "assets/icons/profile/account.svg",
        color: color ?? AppColors.secondaryContainColor,
        width: width ?? 0.06.sw,
        height: height ?? 0.06.sw,
        fit: BoxFit.fill,
      ),
    );
  }
}

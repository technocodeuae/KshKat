import 'package:flutter/material.dart';
import 'package:erp/constants/app_constants.dart';

class CircleIconWithBackground extends StatelessWidget {
  final double radius;
  final double iconSize;
  final IconData iconData;
  final Color iconColor;
  final Color backgroundColor;

  const CircleIconWithBackground(
      {required this.iconData, required this.iconSize, required this.radius, this.iconColor = AppColors
          .white, this.backgroundColor = AppColors.mainColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle
      ),
      child: Center(
        child: Icon(
          iconData,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}

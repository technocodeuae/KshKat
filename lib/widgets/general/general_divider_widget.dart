import 'package:flutter/material.dart';

class GeneralDividerWidget extends StatelessWidget {
  final double? height;
  final Color? color;

  const GeneralDividerWidget({this.height, this.color});
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 5.0,
      thickness: .5,
      color: color ?? Colors.grey,
    );
  }
}
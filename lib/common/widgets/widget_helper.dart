import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetHelper {
  static LinearGradient buildGradient(
      {required Color firstColor,
      required Color secondColor,
      Color? thirdColor}) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomRight,
      stops: [0.22, 0.55, 0.99],
      colors: [
        firstColor,
        secondColor,
        thirdColor ?? secondColor.withOpacity(0.7)
      ],
    );
  }
}

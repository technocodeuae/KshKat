import 'package:flutter/material.dart';

import '../constants/colors.dart';

class RoundedButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const RoundedButtonWidget({
    Key? key,
    required this.buttonText,
    required this.buttonColor,
    this.textColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: AppColors.primaryColor,
          shape: StadiumBorder()
          ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.button!.copyWith(color: textColor),
      ),
    );
  }
}

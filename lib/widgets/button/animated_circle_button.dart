import 'package:flutter/material.dart';
import 'package:erp/constants/app_constants.dart';

class AnimatedCircleButton extends StatefulWidget {
  final Function(bool) onPressed;
  final double radius;
  final double iconSize;
  final bool initializeIsOpen;
  const AnimatedCircleButton({required this.onPressed,required this.iconSize, required this.radius,this.initializeIsOpen=false});
  @override
  _AnimatedCircleButtonState createState() => _AnimatedCircleButtonState();
}

class _AnimatedCircleButtonState extends State<AnimatedCircleButton>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
 late AnimationController _animationController;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;

  @override
  initState() {

    isOpened =widget.initializeIsOpen;
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 800))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: AppColors.mainColor,
      end: AppColors.mainGray,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
    widget.onPressed(isOpened);
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: _animateColor.value,
      onPressed: animate,
      tooltip: 'Toggle',

      child: Icon(
        !isOpened ? Icons.add : Icons.close,
        color: AppColors.white,
        size: widget.iconSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.radius,
        height: widget.radius,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color:!isOpened ? AppColors.mainColor : AppColors.mainGray
          ),
          shape: BoxShape.circle
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.space2),
          child: toggle(),
        ));
  }

}
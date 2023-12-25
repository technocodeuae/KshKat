import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/constants/app_constants.dart';

class SwipeButton extends StatefulWidget {
  final double width;

  final double height;

  final String title;
  final VoidCallback onSwipe;
  const SwipeButton({required this.width,this.height =75 , required this.title, required this.onSwipe});
  @override
  _SwipeButtonState createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> {
  double left = 0;

  AnimationController? animateController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: widget.width,
      child: SizedBox.expand(
        child: GestureDetector(

          onPanUpdate: (details) {
            // Swiping in right direction.
            if (details.delta.dx > 0) {
              print("Swiping in right direction!");

            }

            // Swiping in left direction.
            if (details.delta.dx < 0) {
              print("Swiping in left direction!");


              // animateController!.forward();
              // animateController!.reverse();
              // animateController!.repeat(min:0,max: 1,reverse: true );
              if(!animateController!.isAnimating){
                animateController!.forward(from: 0);
                widget.onSwipe();
              }

            }
          },
          child: Container(
            height: 75,
            color: Colors.white,
            width: widget.width,
            child: SlideInLeft(
              manualTrigger: true,
              //(optional, but mandatory if you use manualTrigger:true) This callback exposes the AnimationController used for the selected animation. Then you can call animationController.forward() to trigger the animation wherever you like manually.
              controller: ( controller ) => animateController = controller,
              child: Container(
                height: 75,
                width: widget.width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RotatedBox(
                        quarterTurns: 0,
                        child: SvgPicture.asset(
                          AppAssets.group_of_arrow_left,
                          width: 30,
                        ),
                      ),
                      HorizontalPadding(
                        percentage: .04,
                      ),
                      Text(
                        widget.title,
                        style: appTextStyle.middleTSBasic
                            .copyWith(color: AppColors.mainColor),
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
}

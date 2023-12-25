import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:erp/constants/app_constants.dart';

class TagSingleSelectedCheckBoxWidget extends StatefulWidget {
  final Function(int) onChange;
  final String label;
  final int id;
  final bool isActive;
  final double circleBorder;
  final double checkBoxWidth;
  final double checkBoxHeight;
  final double iconCheckSize;
  final TextStyle? style;
  final Color? activeColor;
  final Color? inActiveColor;
  final Color? borderColor;

  const TagSingleSelectedCheckBoxWidget({
    Key? key,
    required this.onChange,
    required this.isActive,
    required this.id,
    required this.label,
    this.style,
    this.circleBorder = 0,
    this.checkBoxHeight = 18,
    this.checkBoxWidth = 18,
    this.iconCheckSize = 14,
    this.activeColor,
    this.inActiveColor,
    this.borderColor,
  }) : super(key: key);

  @override
  _TagSingleSelectedCheckBoxWidgetState createState() =>
      _TagSingleSelectedCheckBoxWidgetState();
}

class _TagSingleSelectedCheckBoxWidgetState
    extends State<TagSingleSelectedCheckBoxWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              widget.onChange(widget.id);
            },
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.space8),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    widget.circleBorder,
                  ),
                ),
                child: Container(
                  width: widget.checkBoxWidth,
                  height: widget.checkBoxHeight,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: widget.activeColor ??
                            widget.borderColor ??
                            AppColors.black,
                        width: .5),
                    borderRadius: BorderRadius.all(Radius.circular(widget
                            .circleBorder) //                 <--- border radius here
                        ),
                  ),
                  child: Center(
                    child: widget.isActive
                        ? Icon(
                            Icons.circle,
                            size: widget.iconCheckSize,
                            color: AppColors.mainColor,
                          )
                        : Container(height: 18, width: 18),
                  ),
                ),
              ),
            ),
          ),
          // HorizontalPadding(
          //   percentage: 0.01,
          // ),
          Column(
            children: [
              Container(
                child: Text(
                  widget.label,
                  style: widget.style ??
                      appTextStyle.minTSBasic.copyWith(
                          color: AppColors.mainGray,
                          fontWeight: FontWeight.w300),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// class RoundCheckBoxTermAndPolicyWidget extends StatefulWidget {
//   final ValueChanged<bool> onChange;
//   final double circleBorder;
//   final double width;
//   final Widget? label;
//
//   final Color? activeColor;
//   final Color? inActiveColor;
//   final Color? borderColor;
//
//   const RoundCheckBoxTermAndPolicyWidget(
//       {Key? key,
//       required this.onChange,
//       required this.width,
//       this.circleBorder = 0,
//       this.activeColor,
//       this.inActiveColor,
//       this.borderColor,
//       this.label})
//       : super(key: key);
//
//   @override
//   _RoundCheckBoxTermAndPolicyWidgetState createState() =>
//       _RoundCheckBoxTermAndPolicyWidgetState();
// }
//
// class _RoundCheckBoxTermAndPolicyWidgetState
//     extends State<RoundCheckBoxTermAndPolicyWidget> {
//   bool _value = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           HorizontalPadding(
//             percentage: 4.0,
//           ),
//           InkWell(
//             onTap: () {
//               setState(() {
//                 _value = !_value;
//               });
//               widget.onChange(_value);
//             },
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(
//                   widget.circleBorder,
//                 ),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: _value
//                       ? widget.activeColor ?? globalColor.indicatorColor3
//                       : widget.inActiveColor ?? globalColor.white,
//                   border: Border.all(
//                       color: widget.activeColor ??
//                           widget.borderColor ??
//                           globalColor.indicatorColor3,
//                       width: 1.5),
//                   borderRadius: BorderRadius.all(Radius.circular(widget
//                           .circleBorder) //                 <--- border radius here
//                       ),
//                 ),
//                 child: _value
//                     ? Icon(
//                         Icons.check,
//                         size: 18.w,
//                         color: globalColor.white,
//                       )
//                     : Icon(Icons.check_box_outline_blank, size: 18.w),
//               ),
//             ),
//           ),
//           HorizontalPadding(
//             percentage: 2.0,
//           ),
//           Expanded(
//             child: Container(child: widget.label ?? Container()),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/constants/app_constants.dart';


class FilterTitleCheckBoxWidget extends StatefulWidget {
  final ValueChanged<bool> onChange;
  final double circleBorder;
  final double checkBoxWidth;
  final double checkBoxHeight;
  final double iconCheckSize;
  final String? label;
  final TextStyle? style;
  final Color? activeColor;
  final Color? inActiveColor;
  final Color? borderColor;

  const FilterTitleCheckBoxWidget(
      {Key? key,
      required this.onChange,
      this.circleBorder = 0,
      this.style,
      this.checkBoxHeight = 18,
      this.checkBoxWidth = 18,
      this.iconCheckSize = 14,
      this.activeColor,
      this.inActiveColor,
      this.borderColor,
      this.label})
      : super(key: key);

  @override
  _FilterTitleCheckBoxWidgetState createState() => _FilterTitleCheckBoxWidgetState();
}

class _FilterTitleCheckBoxWidgetState extends State<FilterTitleCheckBoxWidget> {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.space8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    widget.label ?? '',
                    style: appTextStyle.middleTSBasic
                        .copyWith(color: AppColors.mainGray),
                  ),
                ),
              ],
            ),
          ),
          HorizontalPadding(
            percentage: 0.01,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _value = !_value;
              });
              widget.onChange(_value);
            },
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.space6),
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
                    color: _value
                        ? widget.activeColor ?? AppColors.mainColor
                        : widget.inActiveColor ?? AppColors.white,
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
                    child: _value
                        ? Icon(
                            Icons.check,
                            size: widget.iconCheckSize,
                            color: AppColors.white,
                          )
                        : Container(height: 18, width: 18),
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}



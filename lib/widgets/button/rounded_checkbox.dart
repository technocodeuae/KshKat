import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:erp/constants/app_constants.dart';


class RoundCheckBoxWidget extends StatefulWidget {
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
  final bool? initializeValue;

  const RoundCheckBoxWidget(
      {Key? key,
      required this.onChange,
      this.circleBorder = 0,
      this.initializeValue = false,
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
  _RoundCheckBoxWidgetState createState() => _RoundCheckBoxWidgetState();
}

class _RoundCheckBoxWidgetState extends State<RoundCheckBoxWidget> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    if(widget.initializeValue!=null)
      _value = widget.initializeValue!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _value = !_value;
              });
              widget.onChange(_value);
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
          // HorizontalPadding(
          //   percentage: 0.01,
          // ),
          Column(
            children: [
              Container(
                child: Text(
                  widget.label ?? '',
                  style: widget.style ??
                      appTextStyle.minTSBasic
                          .copyWith(color: AppColors.mainGray,fontWeight: FontWeight.w300),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


class RoundTitleCheckBoxWidget extends StatefulWidget {
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
  final bool? initializeValue;
  final bool isRadioButton;

  const RoundTitleCheckBoxWidget(
      {Key? key,
      required this.onChange,
      this.circleBorder = 0,
      this.initializeValue = false,
      this.isRadioButton = false,
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
  _RoundTitleCheckBoxWidgetState createState() => _RoundTitleCheckBoxWidgetState();
}

class _RoundTitleCheckBoxWidgetState extends State<RoundTitleCheckBoxWidget> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    if(widget.initializeValue!=null)
      _value = widget.initializeValue!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _value = !_value;
              });
              widget.onChange(_value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.space8,vertical: AppDimens.space1),
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
                        ?  widget.isRadioButton ? Container(
                      decoration: BoxDecoration(
                        color: _value
                            ? widget.activeColor ?? AppColors.mainColor
                            : widget.inActiveColor ?? AppColors.white,
                        border: Border.all(
                            color: AppColors.white,
                            width: .5),
                        borderRadius: BorderRadius.all(Radius.circular(widget
                            .circleBorder) //                 <--- border radius here
                        ),
                      ),
                    ) : Icon(
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
          // HorizontalPadding(
          //   percentage: 0.01,
          // ),
          Flexible(
            child: Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                widget.label ?? '',
                style: widget.style ??
                    appTextStyle.minTSBasic
                        .copyWith(color: AppColors.mainGray,fontWeight: FontWeight.w300),
              ),
            ),
          ),

        ],
      ),
    );
  }
}


class RadioButtonWithTitle extends StatelessWidget {
  final Function() onChange;
  final double circleBorder;
  final double checkBoxWidth;
  final double checkBoxHeight;
  final double iconCheckSize;
  final String? label;
  final TextStyle? style;
  final Color? activeColor;
  final Color? inActiveColor;
  final Color? borderColor;
  final bool value;
  final bool isRadioButton;

  const RadioButtonWithTitle(
      {Key? key,
        required this.onChange,
        this.circleBorder = 0,
        this.value = false,
        this.isRadioButton = false,
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
  Widget build(BuildContext context) {
    return Container(

      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              onChange();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.space8,vertical: AppDimens.space1),
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    circleBorder,
                  ),
                ),
                child: Container(
                  width: checkBoxWidth,
                  height: checkBoxHeight,
                  decoration: BoxDecoration(
                    color: value
                        ? activeColor ?? AppColors.mainColor
                        : inActiveColor ?? AppColors.white,
                    border: Border.all(
                        color: activeColor ??
                            borderColor ??
                            AppColors.black,
                        width: .5),
                    borderRadius: BorderRadius.all(Radius.circular(circleBorder)),
                  ),
                  child: Center(
                    child: value
                        ? isRadioButton ? Container(
                      decoration: BoxDecoration(
                        color: value
                            ? activeColor ?? AppColors.mainColor
                            : inActiveColor ?? AppColors.white,
                        border: Border.all(
                            color: AppColors.white,
                            width: .5),
                        borderRadius: BorderRadius.all(Radius.circular(circleBorder)),
                      ),
                    ) : Icon(
                            Icons.check,
                            size: iconCheckSize,
                            color: AppColors.white,
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
          Flexible(
            child: Container(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                label ?? '',
                style: style ??
                    appTextStyle.minTSBasic
                        .copyWith(color: AppColors.mainGray,fontWeight: FontWeight.w300),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
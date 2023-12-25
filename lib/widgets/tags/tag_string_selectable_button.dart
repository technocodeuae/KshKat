import 'package:flutter/material.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/constants/app_constants.dart';

class TagStringSelectableButton extends StatefulWidget {
  final Function(bool, String) onChange;
  final double radius;
  final String item;
  final TextStyle? style;
  final Color? activeColor;
  final Color? inActiveColor;
  final Color? borderColor;
  final bool isActive;

  const TagStringSelectableButton(
      {Key? key,
      required this.onChange,
      this.radius = 0,
      this.style,
      this.activeColor,
      this.inActiveColor,
      this.borderColor,
      this.isActive = false,
      required this.item})
      : super(key: key);

  @override
  _TagStringSelectableButtonState createState() =>
      _TagStringSelectableButtonState();
}

class _TagStringSelectableButtonState extends State<TagStringSelectableButton> {
  bool _value = false;

  @override
  void initState() {
    super.initState();
    _value = widget.isActive;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _value = widget.isActive;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _value = !_value;
            });
            widget.onChange(_value, widget.item);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(
                widget.radius,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimens.space4, horizontal: AppDimens.space16),
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
                        .radius) //                 <--- border radius here
                    ),
              ),
              child: Center(
                child: Text(
                  widget.item,
                  style: appTextStyle.smallTSBasic.copyWith(
                    color: _value ? AppColors.white : AppColors.mainGray,
                  ),
                ),
              ),
            ),
          ),
        ),
        HorizontalPadding(
          percentage: 0.02,
        ),
      ],
    );
  }
}

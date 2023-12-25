import 'package:erp/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class NormalLineFormField extends StatelessWidget {
    final FocusNode? focusNode;
    final FocusNode? nextNode;
    final ValueChanged<String>? onChanged;
    final TextInputAction? textInputAction;
    final FormFieldValidator<String>? validator;
    final List<TextInputFormatter>? inputFormat;
    final TextInputType? keyboardType;
    final double borderRadius;
    final String hintText;
    final String labelText;
    final TextEditingController? controller;
    final int? maxLines;
    final int? minLines;
    final bool isEnableFocusOnTextField;
    final bool readOnly;
    final bool filled;
    final bool isSecure;
    final bool isDense;
    final Color? fillColor;
    final Function? onTap;
    final Widget? prefixIcon;
    final BoxConstraints? prefixConstraints;
    final BoxConstraints? suffixConstraints;
    final Widget? suffixIcon;
    final Color? borderColor;
    final ValueChanged<String>? onFieldSubmitted;
    final EdgeInsetsGeometry? contentPadding;
    final int? maxLength;

    final InputCounterWidgetBuilder? buildCounter;
    final TextStyle? style;
    final TextStyle? hintStyle;
    final TextAlign? textAlign;

    const NormalLineFormField(
        {Key? key,
            this.validator,
            this.isEnableFocusOnTextField = true,
            this.inputFormat,
            this.controller,
            this.keyboardType,
            this.onChanged,
            this.focusNode,
            this.nextNode,
            required this.labelText,
            this.textInputAction,
            this.prefixConstraints,
            this.suffixConstraints,
            this.onTap,
            this.readOnly = false,
            this.isSecure = false,
            this.filled = false,
            this.isDense = false,
            this.fillColor,
            this.textAlign,
            this.maxLines = 1,
            this.minLines,
            this.onFieldSubmitted,
            this.prefixIcon,
            this.suffixIcon,

            this.borderColor,
            this.style,
            this.contentPadding,
            this.maxLength,
            this.buildCounter,
            this.hintStyle,
            required this.hintText,
            this.borderRadius = 0})
        : super(key: key);

    @override
    Widget build(BuildContext context) {
        return TextFormField(
            controller: controller,
            style: style ??
                appTextStyle.subMinTSBasic.copyWith(
                    color: AppColors.black,
                    decorationThickness: 0,
                    wordSpacing: 1.0),
            cursorColor: borderColor ?? AppColors.mainColor,
            textCapitalization: TextCapitalization.sentences,
            cursorWidth: 1.5,
            textInputAction: textInputAction,
            maxLength: maxLength ?? null,
            // minLines: minLines??1,
            buildCounter: buildCounter ?? null,
            textAlignVertical: TextAlignVertical.center,
            textAlign: textAlign ?? TextAlign.start,
            decoration: InputDecoration(
                labelStyle: new TextStyle(color: AppColors.mainColor),
                errorStyle: appTextStyle.subMinTSBasic.copyWith(
                    color: Colors.red,
                ),
                counterStyle:
                appTextStyle.subMinTSBasic.copyWith(color: AppColors.black),
                contentPadding: contentPadding,
                // focusedBorder: generalBoarder(
                //     borderRadius: borderRadius, borderColor: borderColor),
                // enabledBorder: generalBoarder(
                //     borderRadius: borderRadius, borderColor: borderColor),
                // errorBorder: generalBoarder(
                //     isError: true,
                //     borderRadius: borderRadius,
                //     borderColor: borderColor),
                // border: generalBoarder(
                //     borderRadius: borderRadius, borderColor: borderColor),
                // focusedErrorBorder: generalBoarder(
                //     isError: true,
                //     borderRadius: borderRadius,
                //     borderColor: borderColor),
                hintText: hintText,
                labelText: labelText,
                prefixIcon: prefixIcon ?? null,
                prefixIconConstraints:prefixConstraints?? BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                ),
                suffixIconConstraints:suffixConstraints?? BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                ),
                suffixIcon: suffixIcon ?? null,
                //   labelText: hintText??'',
                hintStyle: hintStyle ??
                    appTextStyle.subMinTSBasic.copyWith(color: AppColors.lightGrey),
                alignLabelWithHint: true,
                isDense: isDense,
                // border: new UnderlineInputBorder(
                //     borderSide: new BorderSide(
                //         color: AppColors.lightGrey
                //     )
                // ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.mainGreen),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.darkGreen),
                ),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.mainGray),
                ),

                filled: filled,
                fillColor: fillColor ?? null),
            validator: validator,
            enabled: isEnableFocusOnTextField,
            inputFormatters: inputFormat,
            keyboardType: keyboardType,
            onChanged: onChanged,
            focusNode: focusNode,
            maxLines: maxLines,
            obscureText: isSecure,
            readOnly: readOnly,
            onTap: onTap != null ? onTap as void Function()? : () {},
            onFieldSubmitted: onFieldSubmitted != null
                ? onFieldSubmitted
                : (term) {
                _fieldFocusChange(context, focusNode, nextNode);
            });
    }
    _fieldFocusChange(
        BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
        if (currentFocus != null && nextFocus != null) {
            currentFocus.unfocus();
            FocusScope.of(context).requestFocus(nextFocus);
        }
    }
}
class NormalFormPasswordField extends StatefulWidget {
    final FocusNode? focusNode;
    final FocusNode? nextNode;
    final ValueChanged<String>? onChanged;
    final TextInputAction? textInputAction;
    final FormFieldValidator<String>? validator;
    final List<TextInputFormatter>? inputFormat;
    final TextInputType? keyboardType;
    final double borderRadius;
    final String? hintText;
    final String labelText;
    final TextEditingController? controller;
    final int? maxLines;
    final int? minLines;
    final bool isEnableFocusOnTextField;
    final bool readOnly;
    final bool filled;
    final Color? fillColor;
    final Function? onTap;
    final Widget? prefixIcon;
    final Widget? suffixIcon;
    final Color? suffixIconColor;
    final double? suffixIconSize;

    final Color? borderColor;
    final ValueChanged<String>? onFieldSubmitted;
    final EdgeInsetsGeometry? contentPadding;
    final int? maxLength;

    final InputCounterWidgetBuilder? buildCounter;
    final TextStyle? style;
    final TextStyle? hintStyle;
    final TextAlign? textAlign;

    const NormalFormPasswordField(
        {Key? key,
            this.validator,
            this.isEnableFocusOnTextField = true,
            this.inputFormat,
            this.controller,
            this.keyboardType,
            this.onChanged,
            this.focusNode,
            this.nextNode,
            this.textInputAction,
            this.onTap,
            this.readOnly = false,
            this.filled = false,
            this.fillColor,
            this.textAlign,
            this.maxLines = 1,
            this.minLines,
            this.onFieldSubmitted,
            this.prefixIcon,
            this.suffixIcon,
            this.suffixIconColor,
            this.suffixIconSize = 20,
            this.borderColor,
            this.style,
            this.contentPadding,
            this.maxLength,
            this.buildCounter,
            this.hintStyle,
            this.hintText,
            required this.labelText,
            this.borderRadius = 0})
        : super(key: key);

    @override
    _NormalFormPasswordFieldState createState() => _NormalFormPasswordFieldState();
}

class _NormalFormPasswordFieldState extends State<NormalFormPasswordField> {


    bool isSecureText = true;


    @override
    Widget build(BuildContext context) {
        return TextFormField(
            controller: widget.controller,
            style: widget.style ??
                appTextStyle.subMinTSBasic.copyWith(
                    color: AppColors.mainColor,
                    decorationThickness: 0,
                    wordSpacing: 1.0),
            cursorColor: widget.borderColor ?? AppColors.mainColor,
            textCapitalization: TextCapitalization.sentences,
            cursorWidth: 1.5,
            maxLength: widget.maxLength ?? null,
            // minLines: minLines??1,
            buildCounter: widget.buildCounter ?? null,
            textAlignVertical: TextAlignVertical.center,
            textAlign: widget.textAlign ?? TextAlign.start,
            decoration: InputDecoration(
                labelStyle: new TextStyle(color: AppColors.mainColor),
                errorStyle: appTextStyle.subMinTSBasic.copyWith(
                    color: Colors.red,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.mainGreen),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.darkGreen),
                ),
                hintText: widget.hintText,
                labelText: widget.labelText,
                prefixIcon: widget.prefixIcon ?? null,
                suffixIcon: widget.suffixIcon??InkWell(
                    onTap: (){
                        if(mounted){
                            setState(() {
                                isSecureText = !isSecureText;
                            });
                        }
                    },

                    child: Icon(
                        isSecureText ? Icons.panorama_fish_eye :  Icons.remove_red_eye,
                        color: widget.suffixIconColor ?? AppColors.mainGray,
                        size: widget.suffixIconSize,
                    ),
                ),
                prefixIconConstraints: BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                ),
                suffixIconConstraints: BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                ),
                //   labelText: hintText??'',
                hintStyle: widget.hintStyle ??
                    appTextStyle.subMinTSBasic.copyWith(color: AppColors.lightGrey),
                alignLabelWithHint: false,
                filled: widget.filled,
                fillColor: widget.fillColor ?? null),
            validator: widget.validator,
            enabled: widget.isEnableFocusOnTextField,
            inputFormatters: widget.inputFormat,
            keyboardType: widget.keyboardType,
            obscureText: isSecureText,
            obscuringCharacter: "*",
            onChanged: widget.onChanged,
            focusNode: widget.focusNode,
            maxLines: widget.maxLines,
            readOnly: widget.readOnly,
            onTap: widget.onTap != null ? widget.onTap as void Function()? : () {},
            onFieldSubmitted: widget.onFieldSubmitted != null
                ? widget.onFieldSubmitted
                : (term) {
                _fieldFocusChange(context, widget.focusNode, widget.nextNode);
            });
    }

    _fieldFocusChange(
        BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
        if (currentFocus != null && nextFocus != null) {
            currentFocus.unfocus();
            FocusScope.of(context).requestFocus(nextFocus);
        }
    }
}

class RoundedFormField extends StatelessWidget {
    final FocusNode? focusNode;
    final FocusNode? nextNode;
    final ValueChanged<String>? onChanged;
    final TextInputAction? textInputAction;
    final FormFieldValidator<String>? validator;
    final List<TextInputFormatter>? inputFormat;
    final TextInputType? keyboardType;
    final double borderRadius;
    final String? hintText;
    final String labelText;
    final TextEditingController? controller;
    final int? maxLines;
    final int? minLines;
    final bool isEnableFocusOnTextField;
    final bool readOnly;
    final bool filled;
    final bool isDense;
    final Color? fillColor;
    final Function? onTap;
    final Widget? prefixIcon;
    final Widget? suffixIcon;
    final Color? borderColor;
    final ValueChanged<String>? onFieldSubmitted;
    final EdgeInsetsGeometry? contentPadding;
    final int? maxLength;

    final InputCounterWidgetBuilder? buildCounter;
    final TextStyle? style;
    final TextStyle? hintStyle;
    final TextAlign? textAlign;
    final TextAlignVertical? textAlignVertical;

    const RoundedFormField(
        {Key? key,
            this.validator,
            this.isEnableFocusOnTextField = true,
            this.inputFormat,
            this.controller,
            this.keyboardType,
            this.onChanged,
            this.focusNode,
            this.nextNode,
            this.textInputAction,
            this.onTap,
            this.readOnly = false,
            this.filled = false,
            this.isDense = false,
            this.fillColor,
            this.textAlign,
            this.maxLines = 1,
            this.minLines,
            this.onFieldSubmitted,
            this.prefixIcon,
            this.suffixIcon,
            this.textAlignVertical = TextAlignVertical.center,
            this.borderColor,
            this.style,
            this.contentPadding,
            this.maxLength,
            this.buildCounter,
            this.hintStyle,
            required this.labelText,
            this.hintText,
            this.borderRadius = 0})
        : super(key: key);

    @override
    Widget build(BuildContext context) {
        return ClipRRect(
            borderRadius: BorderRadius.all(
                Radius.circular(borderRadius) //         <--- border radius here
            ),
            child: TextFormField(
                controller: controller,
                minLines: minLines,

                scrollPhysics: BouncingScrollPhysics(),
                scrollPadding:const EdgeInsets.symmetric(horizontal: AppDimens.space2) ,

                style: style ??
                    appTextStyle.subMinTSBasic.copyWith(
                        color: AppColors.black,
                        decorationThickness: 0,
                        wordSpacing: 1.0),
                cursorColor: borderColor ?? AppColors.mainColor,
                textCapitalization: TextCapitalization.sentences,
                cursorWidth: 1.5,
                maxLength: maxLength ?? null,
                // minLines: minLines??1,

                buildCounter: buildCounter ?? null,
                textAlignVertical: textAlignVertical,
                textAlign: textAlign ?? TextAlign.start,
                decoration: InputDecoration(
                    errorStyle: appTextStyle.subMinTSBasic.copyWith(
                        color: Colors.red,
                    ),
                    isDense: isDense,
                    counterStyle:
                    appTextStyle.subMinTSBasic.copyWith(color: AppColors.black),
                    contentPadding: contentPadding,
                    focusedBorder: generalBoarder(
                        borderRadius: borderRadius, borderColor: borderColor),
                    enabledBorder: generalBoarder(
                        borderRadius: borderRadius, borderColor: borderColor),
                    errorBorder: generalBoarder(
                        isError: true,
                        borderRadius: borderRadius,
                        borderColor: borderColor),
                    border: generalBoarder(
                        borderRadius: borderRadius, borderColor: borderColor),
                    focusedErrorBorder: generalBoarder(
                        isError: true,
                        borderRadius: borderRadius,
                        borderColor: borderColor),
                    hintText: hintText,
                    prefixIcon: prefixIcon ?? null,
                    prefixIconConstraints: BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                    ),
                    suffixIconConstraints: BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                    ),
                    suffixIcon: suffixIcon ?? null,
                    //   labelText: hintText??'',
                    hintStyle: hintStyle ??
                        appTextStyle.subMinTSBasic.copyWith(color: AppColors.lightGrey),
                    alignLabelWithHint: true,
                    labelStyle:style?? appTextStyle.middleTSBasic.copyWith(
                        color: AppColors.black
                    ),
                    filled: filled,
                    fillColor: fillColor ?? null),
                validator: validator,
                enabled: isEnableFocusOnTextField,
                inputFormatters: inputFormat,
                keyboardType: keyboardType,
                onChanged: onChanged,
                focusNode: focusNode,
                maxLines: maxLines,
                readOnly: readOnly,
                onTap: onTap != null ? onTap as void Function()? : () {},
                onFieldSubmitted: onFieldSubmitted != null
                    ? onFieldSubmitted
                    : (term) {
                    _fieldFocusChange(context, focusNode, nextNode);
                }),
        );
    }
    _fieldFocusChange(
        BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
        if (currentFocus != null && nextFocus != null) {
            currentFocus.unfocus();
            FocusScope.of(context).requestFocus(nextFocus);
        }
    }
}
InputBorder generalBoarder(
    {bool isError = false, required double borderRadius, Color? borderColor}) {
    return OutlineInputBorder(
        borderSide: BorderSide(
            color: borderColor ?? AppColors.mainColor,
            style: BorderStyle.solid,
            width: isError ? 1.5 : 0.5,
        ),
        borderRadius: BorderRadius.all(
            Radius.circular(borderRadius) //         <--- border radius here
        ),
    );
}


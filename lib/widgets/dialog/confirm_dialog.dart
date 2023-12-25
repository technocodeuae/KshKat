import 'package:flutter/material.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';

class ConfirmDialog extends StatefulWidget {
  final String? title;
  final String? confirmMessage;
  final String? messageYes;
  final Function? actionYes;
  final Function? actionNo;

  const ConfirmDialog({
    this.title,
    this.confirmMessage,
    this.messageYes,
    this.actionYes,
    this.actionNo,
  });

  @override
  State<StatefulWidget> createState() => ConfirmDialogState();
}

class ConfirmDialogState extends State<ConfirmDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
//    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack);

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: const EdgeInsets.all(AppDimens.space32),
              padding: const EdgeInsets.all(AppDimens.space8),
              decoration: ShapeDecoration(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.radius10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${widget.title}',
                    style: appTextStyle.normalTSBasic
                        .copyWith(color: AppColors.mainColor),
                  ),
                  VerticalPadding(percentage: 0.05,),
                  Container(
                    margin: const EdgeInsets.only(
                        left: AppDimens.space2,
                        right: AppDimens.space2,
                        top: AppDimens.space2),
                    alignment: AlignmentDirectional.centerStart,
                    child: Text('${widget.confirmMessage}',
                        style: appTextStyle.smallTSBasic
                            .copyWith(color: AppColors.black),textAlign: TextAlign.center,),
                  ),
                  VerticalPadding(percentage: 0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          child: ButtonTheme(
                              height: 35,
                              minWidth: 110,
                              child:ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(AppRadius.radius6),
                                        ),
                                      )
                                  ),
                                  child: Text(
                                    "cancel",
                                    textAlign: TextAlign.center,
                                    style: appTextStyle.minTSBasic
                                        .copyWith(color: Colors.redAccent),
                                  ),
                                  onPressed:
                                      widget.actionNo as void Function()?))),
                      Container(
                        child: ButtonTheme(
                            height: 35,
                            minWidth: 110,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(AppRadius.radius6),
                                      ),
                                    )
                                ),
                                child: Text(
                                  widget.messageYes ?? 'Yes',
                                  textAlign: TextAlign.center,
                                  style: appTextStyle.minTSBasic
                                      .copyWith(color: AppColors.white),
                                ),
                                onPressed:
                                    widget.actionYes as void Function()?)),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

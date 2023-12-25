import 'package:flutter/material.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/widgets/button/rounded_checkbox.dart';

class SharedDiscussionConfirmDialog extends StatefulWidget {


  @override
  State<StatefulWidget> createState() => SharedDiscussionConfirmDialogState();
}

class SharedDiscussionConfirmDialogState extends State<SharedDiscussionConfirmDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  ShareDiscussionType  _isSelected  = ShareDiscussionType.FullShare;
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
                    'Select Share Type',
                    style: appTextStyle.normalTSBasic
                        .copyWith(color: AppColors.mainColor),
                  ),
                  VerticalPadding(percentage: 0.05,),
                  RadioButtonWithTitle(
                    onChange: () {


                        if(_isSelected != ShareDiscussionType.FullShare){
                          if(mounted)
                            setState(() {
                              _isSelected = ShareDiscussionType.FullShare;
                            });
                        }

                    },
                    label:"Full Share",
                    style:  appTextStyle.minTSBasic.copyWith(
                        color: AppColors.mainGray,
                        fontWeight: FontWeight.bold),
                    circleBorder: 15,
                    value: _isSelected == ShareDiscussionType.FullShare,
                    checkBoxHeight: 15,
                    checkBoxWidth: 15,
                    iconCheckSize: 11,
                    isRadioButton: true,
                  ),
                  VerticalPadding(percentage: 0.05,),
                  RadioButtonWithTitle(
                    onChange: () {
                      if(_isSelected != ShareDiscussionType.OnlyBasic){
                        if(mounted)
                          setState(() {
                            _isSelected = ShareDiscussionType.OnlyBasic;
                          });
                      }


                    },
                    label:"Only Basic",
                    style:  appTextStyle.minTSBasic.copyWith(
                        color: AppColors.mainGray,
                        fontWeight: FontWeight.bold),
                    circleBorder: 15,
                    value: _isSelected == ShareDiscussionType.OnlyBasic,
                    checkBoxHeight: 15,
                    checkBoxWidth: 15,
                    iconCheckSize: 11,
                    isRadioButton: true,
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
                                  onPressed:(){
                                    Navigator.of(context).pop();
                                  }))),
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
                                  'Confirm',
                                  textAlign: TextAlign.center,
                                  style: appTextStyle.minTSBasic
                                      .copyWith(color: AppColors.white),
                                ),
                                onPressed:(){
                                  Navigator.of(context).pop(_isSelected==ShareDiscussionType.OnlyBasic?2:1);
                                })),
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

enum ShareDiscussionType {FullShare,OnlyBasic}
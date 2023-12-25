import 'package:erp/ui/user_management/widgets/button_user_management_widget.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';

import '../../ui/splash/argument/GlobalArgument.dart';
import '../../utils/routes/routes.dart';


class AddressDialog extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => AddressDialogState();
}

class AddressDialogState extends State<AddressDialog>
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
    double widthC = DeviceUtils.getScaledWidth(context, 1);
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: const EdgeInsets.all(AppDimens.space32),
              padding: const EdgeInsets.all(AppDimens.space28),
              decoration: ShapeDecoration(
                  color: AppColors.scaffoldBGColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.radius10))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate('add_address'),
                    style: appTextStyle.subBigTSBasicBold
                        .copyWith(color: AppColors.black),
                  ),
                  VerticalPadding(percentage: 0.05,),
                  Container(
                    margin: const EdgeInsets.only(
                        left: AppDimens.space2,
                        right: AppDimens.space2,
                        top: AppDimens.space2),
                    alignment: AlignmentDirectional.center,
                    child: Text(AppLocalizations.of(context).translate('msg_address'),
                        style: appTextStyle.normalTSBasicBold
                            .copyWith(color: AppColors.black),textAlign: TextAlign.center,),
                  ),
                  VerticalPadding(percentage: 0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ButtonUserManagementWidget(
                        width: widthC/3.15,
                        child: Text(
                          AppLocalizations.of(context).translate("cancel"),
                          style: appTextStyle.middleTSBasic
                              .copyWith(color: AppColors.black),
                        ),
                        backgroundColor: AppColors.white,
                        height: 55,
                        borderRadius: 10.0,
                        borderColor: AppColors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      ButtonUserManagementWidget(
                        width: widthC/3.15,
                        child: Text(
                          AppLocalizations.of(context).translate("add_now"),
                          style: appTextStyle.middleTSBasic
                              .copyWith(color: AppColors.white),
                        ),
                        backgroundColor: AppColors.mainColor,
                        height: 55,
                        borderRadius: 10.0,
                        borderColor: AppColors.mainColor,
                          onPressed:(){
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(Routes.addressPage);
                          },
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

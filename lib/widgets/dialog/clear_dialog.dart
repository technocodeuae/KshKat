import 'package:erp/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/data/repo/user_management_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/utils/routes/routes.dart';
import 'package:get/get.dart';

import '../../ui/cart/controller/cart_controller.dart';
import '../../ui/main/main_root.dart';
import '../../ui/splash/argument/GlobalArgument.dart';


class ClearDialog extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => ClearDialogState();
}

class ClearDialogState extends State<ClearDialog>
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
                    AppLocalizations.of(context).translate('clear_cart'),
                    style: appTextStyle.subBigTSBasicBold
                        .copyWith(color: AppColors.mainColor),
                  ),
                  VerticalPadding(percentage: 0.05,),
                  Container(
                    margin: const EdgeInsets.only(
                        left: AppDimens.space2,
                        right: AppDimens.space2,
                        top: AppDimens.space2),
                    alignment: AlignmentDirectional.center,
                    child: Text(AppLocalizations.of(context).translate('confirm_msg'),
                        style: appTextStyle.normalTSBasicBold
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
                                    AppLocalizations.of(context).translate('cancel'),
                                    textAlign: TextAlign.center,
                                    style: appTextStyle.minTSBasic
                                        .copyWith(color: AppColors.white),
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
                                  AppLocalizations.of(context).translate('ok'),
                                  textAlign: TextAlign.center,
                                  style: appTextStyle.minTSBasic
                                      .copyWith(color: AppColors.white),
                                ),
                                onPressed:()async{
                                  UserManagementRepository _repository = getIt<UserManagementRepository>();
                                  var token=await _repository.authToken;
                                  var numCart=await _repository.numCart;
                                  var timeId=await _repository.timeId;
                                  if (await _repository.clearCart()) {
                                    Navigator.of(context).pushReplacementNamed(
                                        Routes.mainRootPage,
                                        arguments:  GlobalArgument(token, numCart,
                                            null,
                                            null,1));
                                  }
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

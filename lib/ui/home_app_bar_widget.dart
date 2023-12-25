import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/models/user_management/sign_in_dashboard_response.dart';
import 'package:erp/utils/device/app_uitls.dart';
import 'package:erp/utils/routes/routes.dart';

class HomeAppBarWidget extends StatelessWidget {
  final String time;
  final Duration? duration;
  final Duration? delay;
  final bool? automaticallyImplyLeading;
  final bool? isThereAnyUpdate;
  final bool isHideSearch;
  final bool isShowCart;
  final bool isHideSettings;
  final bool isHideNotification;
  final UserSignInDashboardResult? userInfo;

  const HomeAppBarWidget({
    this.time = "",
    this.duration = const Duration(milliseconds: 2500),
    this.delay = const Duration(milliseconds: 1500),
    this.automaticallyImplyLeading = false,
    this.isThereAnyUpdate = false,
    this.userInfo,
    this.isHideSearch = false,
    this.isHideSettings = false,
    this.isShowCart = false,
    this.isHideNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          Row(
            children: [
              automaticallyImplyLeading!
                  ? InkWell(
                      onTap: () => Navigator.of(context).pop(isThereAnyUpdate),
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimens.space4),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: AppColors.black,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                width: AppDimens.space4,
              ),
            ],
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: FittedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.mainRootPage);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.home_outlined,
                            size: 30,
                            color: AppColors.mainColor,
                          ),
                        ],
                      ),
                    ),
                    HorizontalPadding(
                      percentage: 0.02,
                    ),
                    if(isShowCart)
                      HorizontalPadding(
                      percentage: 0.02,
                    ),
                    if(isShowCart)
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(Routes.cartPage);
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.add_shopping_cart,
                            size: 30,
                            color: AppColors.mainColor,
                          ),
                        ],
                      ),
                    ),
                    isHideSettings
                        ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 17,
                        height: 17,
                      ),
                    )
                        : Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.checkoutPage);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 0.5,
                                    color: AppColors.mainColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(2.3),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    "${AppUtils.notNullOrEmpty(userInfo!.username) ? userInfo!.username![0] : ""}",
                                    style: appTextStyle.middleTSBasic
                                        .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userInfo!.username.toString(),
                    style: appTextStyle.normalTSBasic
                        .copyWith(color: AppColors.mainGray),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: FadeInDown(
              delay: delay!,
              duration: duration!,
              animate: true,
              child: Container(
                child: Center(
                  child: Image.asset(
                    AppAssets.main_logo,
                    width: 40,
                    //  height: 40,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: AppDimens.space4,
          ),
        ],
      ),
    );
  }
}

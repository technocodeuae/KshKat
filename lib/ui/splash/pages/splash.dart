import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_assets.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/constants/colors.dart';
import 'package:erp/data/repo/user_management_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/ui/user_management/widgets/button_user_management_widget.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/utils/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../stores/language/language_store.dart';
import '../../globals.dart' as globals;
import '../argument/GlobalArgument.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var token;
  int? numCart;
  bool isFinish = false;
  UserManagementRepository _repository = getIt<UserManagementRepository>();
  late LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
    startTimer();
    getToken();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
  }

  Future<void> getToken() async {
    token = await _repository.authToken;
    numCart = await _repository.numCart;
    globals.numCart = numCart;
  }

  @override
  Widget build(BuildContext context) {
    double widthC = DeviceUtils.getScaledWidth(context, 1);
    return Scaffold(
      backgroundColor:Color(0xff1d253c) ,//AppColors.black,
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets/images/kskat.gif"))),
                ),
              ),
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     FadeInDownBig(
            //       child: Container(
            //         child: Image.asset(
            //           AppAssets.logo,
            //           width: 250,
            //           fit: BoxFit.fill,
            //         ),
            //       ),
            //       duration: Duration(milliseconds: 1500),
            //     ),
            //     _languageStore.getLanguage() == "Arabic"?
            //     Container():
            //     Container(
            //       width: double.infinity,
            //       alignment: AlignmentDirectional.center,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 200), letter: "w"),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 400), letter: "e "),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 600), letter: "b"),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 800), letter: "r"),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 1000), letter: "i"),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 1200), letter: "n"),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 1200), letter: "g "),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 1400), letter: "h"),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 1600), letter: "o"),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 1800), letter: "m"),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 2000), letter: "e "),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 2400), letter: "t"),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 2600), letter: "o "),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 2800), letter: "y"),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 3000), letter: "o"),
            //           _buildLetterAnimated(
            //               delay: Duration(milliseconds: 3200), letter: "u"),
            //         ],
            //       ),
            //     ),

            //   ],
            // ),
            isFinish
                ? token != null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.all(35.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ButtonUserManagementWidget(
                              width: widthC,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("get_started"),
                                style: appTextStyle.middleTSBasic
                                    .copyWith(color: AppColors.black),
                              ),
                              backgroundColor: AppColors.white,
                              height: 55,
                              borderRadius: 10.0,
                              borderColor: AppColors.white,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(Routes.signInPage);
                              },
                            ),
                            VerticalPadding(
                              percentage: 0.05,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    Routes.mainRootPage,
                                    arguments: GlobalArgument(
                                        token, numCart, null, null, null));
                              },
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('just_browsing'),
                                style: appTextStyle.subBigBasic.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _buildLetterAnimated(
      {required String letter, required Duration delay}) {
    return FadeInRight(
      delay: delay,
      child: Text(
        letter,
        style: appTextStyle.subBigTSBasic.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 4500);
    return Timer(_duration, navigate);
  }

  navigate() async {
    print("object");
    if (token != null)
      Navigator.of(context).pushReplacementNamed(Routes.mainRootPage,
          arguments: GlobalArgument(token, numCart, null, null, null));
    else
      setState(() {
        isFinish = !isFinish;
      });
  }
}

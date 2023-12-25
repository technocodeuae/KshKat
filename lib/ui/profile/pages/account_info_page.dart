import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/ui/user_management/widgets/button_user_management_widget.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/utils/routes/routes.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/base_body.dart';
import '../../../common/widgets/horizontal_padding.dart';
import '../../../constants/app_constants.dart';
import '../../../stores/language/language_store.dart';
import '../../../widgets/dialog/logout_dialog.dart';


class AccountInfoPage extends StatefulWidget {
  @override
  _AccountInfoPageState createState() => _AccountInfoPageState();
}

class _AccountInfoPageState extends State<AccountInfoPage>
    with SingleTickerProviderStateMixin {

  late String userInfo;
  late LanguageStore _languageStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageStore = Provider.of<LanguageStore>(context);
  }


  @override
  Widget build(BuildContext context) {
    userInfo = ModalRoute.of(context)!.settings.arguments as String;
    AppBar appBar = AppBar(
      title: Container(
        color: AppColors.transparent,
        child: Padding(
            padding: EdgeInsets.only(bottom: 40.0,top: 40.0,left: 10,right: 10),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(
                    _languageStore.getLanguage() == "Arabic"?Icons.arrow_forward_ios_sharp:
                    Icons.arrow_back_ios_sharp,
                    color: AppColors.black,
                    size: 20,
                  ),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 800),
                  duration: Duration(milliseconds: 400),
                  animate: true,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('account_settings'),
                      style: appTextStyle.subBigTSBasicBold.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppTextSize.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )),
      ),
      backgroundColor: AppColors.appBarBGColor,
      automaticallyImplyLeading: false,
      brightness: Brightness.light,
      elevation: 0,
    );

    double widthC = DeviceUtils.getScaledWidth(context, 1);
    double heightC = DeviceUtils.getScaledHeight(context, 1);

    return Stack(
      children: [
        Container(
          color: AppColors.white,
        ),
        Scaffold(
            appBar: appBar,
            backgroundColor: AppColors.scaffoldBGColor,
            body: _buildBody(height: heightC, width: widthC)
          // body: _buildBody(height: heightC, width: widthC),
        ),
      ],
    );
  }

  Widget _buildBody({required double width, required double height}) {
    return BaseBody(
      portraitWidget: _portraitWidget(height: height, width: width),
      landscapeWidget: _portraitWidget(height: height, width: width),
      isSafeAreaTop: false,
    );
  }

  // portrait view:--------------------------------------------------------------
  Widget _portraitWidget({required double width, required double height}) {
    return SlideInRight(
        delay: Duration(milliseconds: 200),
        duration: Duration(milliseconds: 800),
        animate: true,
        child: Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                       padding: EdgeInsets.all(20.0),
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            child: Card(
                              elevation: 2.0,
                              color: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(AppRadius.radiusDefault)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  VerticalPadding(
                                    percentage: 0.02,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      HorizontalPadding(
                                        percentage: 0.05,
                                      ),
                                      Expanded(child:
                                      Text(
                                        AppLocalizations.of(context).translate("full_name"),
                                        style: appTextStyle.middleTSBasic
                                            .copyWith(color: AppColors.black),
                                      )
                                        ,flex: 1,),
                                      Expanded(child:
                                      Text(
                                        userInfo.split(",")[0],
                                        style: appTextStyle.middleTSBasic
                                            .copyWith(color: AppColors.black),
                                      )
                                        ,flex: 2,),
                                      HorizontalPadding(
                                        percentage: 0.05,
                                      ),
                                    ],
                                  ),
                                  VerticalPadding(
                                    percentage: 0.01,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      HorizontalPadding(
                                        percentage: 0.05,
                                      ),
                                      Expanded(child:
                                      Text(
                                        AppLocalizations.of(context).translate("user_mobile"),
                                        style: appTextStyle.middleTSBasic
                                            .copyWith(color: AppColors.black),
                                      )
                                        ,flex: 1,),
                                      Expanded(child:
                                      Text(
                                        userInfo.split(",")[1],
                                        style: appTextStyle.middleTSBasic
                                            .copyWith(color: AppColors.black),
                                      )
                                        ,flex: 2,),
                                      HorizontalPadding(
                                        percentage: 0.05,
                                      ),
                                    ],
                                  ),
                                  VerticalPadding(
                                    percentage: 0.01,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      HorizontalPadding(
                                        percentage: 0.05,
                                      ),
                                      Expanded(child:
                                      Text(
                                        AppLocalizations.of(context).translate("user_email"),
                                        style: appTextStyle.middleTSBasic
                                            .copyWith(color: AppColors.black),
                                      )
                                        ,flex: 1,),
                                      Expanded(child:
                                      Text(
                                        userInfo.split(",")[2],
                                        style: appTextStyle.middleTSBasic
                                            .copyWith(color: AppColors.black),
                                      )
                                        ,flex: 2,),
                                      HorizontalPadding(
                                        percentage: 0.05,
                                      ),
                                    ],
                                  ),
                                  VerticalPadding(
                                    percentage: 0.01,
                                  ),
                                ],
                              ),
                            ),
                            decoration: new BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(AppRadius.radiusDefault)),
                              boxShadow: [
                                new BoxShadow(
                                  color: AppColors.light_gray.withOpacity(0.1),
                                  blurRadius: 1.0,
                                ),
                              ],
                            ),
                          ),

                          VerticalPadding(
                            percentage: 0.02,
                          ),

                          ButtonUserManagementWidget(
                            width: width,
                            child: Text(
                              AppLocalizations.of(context).translate("sign_out"),
                              style: appTextStyle.middleTSBasic
                                  .copyWith(color: AppColors.black),
                            ),
                            backgroundColor: AppColors.white,
                            height: 55,
                            borderRadius: 10.0,
                            borderColor: AppColors.white,
                            onPressed: () {
                              showDialog(
                                  context: context, builder: (context) => LogOutDialog());
                            },
                          ),
                          VerticalPadding(
                            percentage: 0.02,
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

}



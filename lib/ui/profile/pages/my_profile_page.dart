import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:erp/common/widgets/base_body.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/stores/theme/theme_store.dart';
import 'package:erp/ui/profile/widgets/item_profile_card_widget.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/utils/routes/routes.dart';

import '../../../data/repo/user_management_repository.dart';
import '../../../di/components/service_locator.dart';
import '../../../getx/application/application_bloc.dart';
import '../../../getx/application/application_events.dart';
import '../../../utils/device/app_uitls.dart';


class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with SingleTickerProviderStateMixin {
  /// //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  /// //main properties:---------------------------------------------------------------------
  String? _userInfo;
  List<String> user=[];
  UserManagementRepository _repository = getIt<UserManagementRepository>();
  late List<LangList> fList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    fList = [
      LangList(
        index: 1,
        name: AppLocalizations.of(context).translate("arabic"),
      ),
      LangList(
        index: 2,
        name: AppLocalizations.of(context).translate("english"),
      )
    ];

    AppBar appBar = AppBar(
      title: Container(
        color: AppColors.transparent,
        child: Padding(
            padding: EdgeInsets.only(bottom: 40.0,top: 40.0,left: 10,right: 10),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                FadeInDown(
                    delay: Duration(milliseconds: 800),
                    duration: Duration(milliseconds: 400),
                    animate: true,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).translate('my_profile'),
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

  Future<void> getUser() async {
    _userInfo = await _repository.userInfo;
    user= _userInfo!.split(" ");
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VerticalPadding(
                      percentage: 0.02,
                    ),
                    ItemProfileCardWidget(
                        title: AppLocalizations.of(context)
                            .translate("recent_order"),
                        svgIcon: Icons.reorder,
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.orderPage);
                        }),
                    ItemProfileCardWidget(
                        title:
                            AppLocalizations.of(context).translate("privacy"),
                        svgIcon: Icons.privacy_tip_outlined,
                        onPressed: () {
                          AppUtils.launchURL("https://avasheen.com/privacy");
                        }),
                    ItemProfileCardWidget(
                        title: AppLocalizations.of(context).translate("terms"),
                        svgIcon: Icons.branding_watermark,
                        onPressed: () {
                          AppUtils.launchURL("https://avasheen.com/terms");
                        }),
                    ItemProfileCardWidget(
                        title: AppLocalizations.of(context)
                            .translate("account_settings"),
                        svgIcon: Icons.settings,
                        onPressed: () {
                          Navigator.of(context).pushNamed(Routes.accountInformationPage,arguments: _userInfo);
                        }),
                    ItemProfileCardWidget(
                        title:
                            AppLocalizations.of(context).translate("set_lang"),
                        svgIcon: Icons.language,
                        onPressed: () {
                          _changeLangDialog(context);
                        }),
                    ItemProfileCardWidget(
                        title: AppLocalizations.of(context).translate("faq"),
                        svgIcon: Icons.copyright,
                        onPressed: () {
                          AppUtils.launchURL("https://avasheen.com/about");
                        }),
                    VerticalPadding(
                      percentage: 0.04,
                    ),
                  ],
                ),
              )),
            ],
          ),
        ));
  }

  Widget _titleValueWidget({required String title, required String value}) {
    return Container(
      child: Column(
        children: [
          VerticalPadding(
            percentage: 0.02,
          ),
          Wrap(
            children: [
              Container(
                child: Text(
                  "$title :",
                  style: appTextStyle.minTSBasic
                      .copyWith(color: AppColors.mainGray.withOpacity(0.8)),
                ),
              ),
              HorizontalPadding(
                percentage: 0.015,
              ),
              Container(
                child: Text(
                  value,
                  style: appTextStyle.minTSBasic
                      .copyWith(color: AppColors.mainGray.withOpacity(0.8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _titleInfoWidget({required String title}) {
    return Container(
      child: Column(
        children: [
          VerticalPadding(
            percentage: 0.01,
          ),
          Wrap(
            children: [
              Container(
                child: Text(
                  "$title",
                  style: appTextStyle.minTSBasic
                      .copyWith(color: AppColors.mainGray.withOpacity(0.8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _changeLangDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        int selectedRadio = 0;
        if(_languageStore.getLanguage() == "Arabic")
          selectedRadio=1;
        else if(_languageStore.getLanguage() == "English")
          selectedRadio=2;
        else
          selectedRadio=3;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppLocalizations.of(context)
                        .translate('change_lang'),
                    textAlign: TextAlign.center,
                    style: appTextStyle.normalTSBasic
                        .copyWith(color: AppColors.mainColor),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: fList
                        .map((data) =>
                        Row(children: [
                          Radio<int>(
                            value: data.index,
                            groupValue: selectedRadio,
                            onChanged: (int? value) {
                              setState(() => selectedRadio = value!);
                            },
                          ),
                          Text(
                            "${data.name}",
                            style: TextStyle(fontSize: 17.0),
                          ),
                          // more widgets ...
                        ]))
                        .toList(),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
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
                                    AppLocalizations.of(context)
                                        .translate('cancel'),
                                    textAlign: TextAlign.center,
                                    style: appTextStyle.minTSBasic
                                        .copyWith(color: AppColors.white),
                                  ),
                                  onPressed: () {
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
                                onPressed: () async {
                                  selectedRadio > 0 ?
                                  {
                                    BlocProvider.of<ApplicationBloc>(context)..add(SetApplicationLanguageEvent(selectedRadio == 1 ? "ar" :"en")),
                                    _languageStore.changeLanguage(selectedRadio == 1 ? "ar" : "en"),
                                    Navigator.of(context).pop(),
                                  }:
                                  AppUtils.showToast(
                                      msg: AppLocalizations.of(context).translate('choose_lang'),
                                      context
                                          :
                                      context
                                  );
                                })),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }


}


class LangList {
  String name;
  int index;

  LangList({required this.name, required this.index});
}
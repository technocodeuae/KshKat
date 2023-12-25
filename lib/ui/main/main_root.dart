import 'dart:async';
import 'dart:ui';

import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/getx/main/root_page_bloc.dart';
import 'package:erp/ui/cart/pages/cart_page.dart';
import 'package:erp/ui/category/pages/categories_page.dart';
import 'package:erp/ui/favouriteProducts/pages/products_fav_page.dart';
import 'package:erp/ui/profile/pages/my_profile_page.dart';
import 'package:erp/ui/splash/argument/GlobalArgument.dart';
import 'package:erp/ui/user_management/widgets/button_user_management_widget.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/utils/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/repo/user_management_repository.dart';
import '../../di/components/service_locator.dart';
import '../category/pages/category_page.dart';
import '../category/pages/home_page.dart';
import '../order/pages/order_page.dart';

class MainRootPage extends StatefulWidget {
  @override
  _MainRootPageState createState() => _MainRootPageState();
}

class _MainRootPageState extends State<MainRootPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;
  DateTime? currentBackPressTime;

  GlobalKey _key = GlobalKey();
  var arg;
  var token, numCart;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    tabController = new TabController(length: 5, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil.init(context, designSize: const Size(360, 690));

    if (arg != 1) {
      arg = ModalRoute.of(context)!.settings.arguments as GlobalArgument;
      token = arg.token;
      numCart = arg.numCart;
      if (arg != 1 && arg.indexAnimate != null) {
        tabController.index = arg.indexAnimate;
        arg = 1;
      }
    }
    double widthC = DeviceUtils.getScaledWidth(context, 1);
    double heightC = DeviceUtils.getScaledHeight(context, 1);

    return BlocListener<RootPageBloc, RootPageState>(
      listener: (context, state) {
        if (state is PageIndexState) {
          if (state.pageIndex != null) {
            tabController.index = state.pageIndex;
          }
        }
      },
      child: Stack(
        children: [
          Container(
            color: AppColors.white,
          ),
          Scaffold(
            extendBody: false,
            backgroundColor: AppColors.scaffoldBGColor,
            bottomNavigationBar: token != null
                ? Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 5.sp),
                    child: Row(
                      children: [
                        Expanded(
                          child: TabBar(
                            controller: tabController,
                            indicatorColor: AppColors.white,
                            indicatorPadding: EdgeInsets.all(0.0),
                            labelPadding: EdgeInsets.all(0.0),
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: <Widget>[
                              _buildTabItem(
                                  text: AppLocalizations.of(context)
                                      .translate('home'),
                                  iconPath: Icons.home_outlined,
                                  page: PagesEnum.PAGE_1),
                              _buildTabItem(
                                  text: AppLocalizations.of(context)
                                      .translate('cart'),
                                  iconPath: Icons.shopping_cart_outlined,
                                  page: PagesEnum.PAGE_2),
                              _buildTabItem(
                                  text: AppLocalizations.of(context)
                                      .translate('categories'), //'my_order'
                                  iconPath: Icons
                                      .category_outlined, //Icons.request_page_outlined,
                                  page: PagesEnum.PAGE_3),
                              _buildTabItem(
                                  text: AppLocalizations.of(context)
                                      .translate('favorite'),
                                  iconPath: Icons.favorite_outline,
                                  page: PagesEnum.PAGE_4),
                              _buildTabItem(
                                  text: AppLocalizations.of(context)
                                      .translate('account'),
                                  iconPath: Icons.person_outline,
                                  page: PagesEnum.PAGE_5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    color: AppColors.mainColor,
                    child: Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HorizontalPadding(
                            percentage: 0.05,
                          ),
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('browsing_mode'),
                              style: appTextStyle.subBigBasic.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            flex: 2,
                          ),
                          Spacer(),
                          Expanded(
                            child: ButtonUserManagementWidget(
                              width: widthC / 2,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("login_btn_sign_up"),
                                style: appTextStyle.middleTSBasic
                                    .copyWith(color: AppColors.black),
                              ),
                              backgroundColor: AppColors.white,
                              height: 55,
                              borderRadius: 10.0,
                              borderColor: AppColors.white,
                              onPressed: () {
                                if (mounted) {
                                  DeviceUtils.hideKeyboard(context);
                                  Navigator.of(context)
                                      .pushNamed(Routes.signInPage);
                                }
                              },
                            ),
                            flex: 2,
                          ),
                          HorizontalPadding(
                            percentage: 0.05,
                          ),
                        ],
                      ),
                    ),
                  ),
            body: WillPopScope(
              onWillPop: _onWillPop,
              child: Container(
                child: TabBarView(
                  controller: tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    HomePage(
                      height: heightC,
                      width: widthC,
                      token: token,
                    ),
                    CartPage(),
                    CategoriesPage(),
                    ProductFavPage(),
                    // OrderPage(),

                    MyProfilePage(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget _buildTabItem(
      {required String text,
      required IconData? iconPath,
      required PagesEnum page,
      Color? svgColor,
      double? iconSize}) {
    bool isSelected = (page.index == tabController.index);

    final iconColor = isSelected ? AppColors.dark_green : AppColors.mainGray;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: 70,
      height: 42.sp,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.sp),
        child: Column(
          children: [
            Icon(
              iconPath,
              color: svgColor ?? iconColor,
              size: 24.sp,
            ),
            // SvgPicture.asset(
            //   iconPath,
            //   color: svgColor ?? iconColor,
            //   width: 20,
            //   height: 20,
            //   fit: BoxFit.fill,
            // ),
            Text(
              text,
              style: appTextStyle.body2
                  .copyWith(color: iconColor, fontSize: 9.5.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItemCart(
      {required String text,
      required IconData? iconPath,
      required PagesEnum page,
      Color? svgColor,
      double? iconSize}) {
    bool isSelected = (page.index == tabController.index);

    final iconColor = isSelected ? AppColors.dark_green : AppColors.mainGray;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: 40,
      height: 30,
      child: new Stack(
        children: <Widget>[
          Icon(
            iconPath,
            color: svgColor ?? iconColor,
            size: 25,
          ),
          new Positioned(
            right: 0,
            child: new Container(
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: new Text(
                numCart.toString(),
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabItem2(
      {required String text,
      required String iconPath,
      Color? svgColor,
      double? iconSize}) {
    // bool isSelected = (pages.index == tabController.index);
    //
    // final iconColor = isSelected ? AppColors.mainColor : AppColors.mainGray;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: iconSize ?? 18,
      height: iconSize ?? 18,
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          color: svgColor,
          width: iconSize ?? 18,
          height: iconSize ?? 18,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    if (checkIndex()) return Future.value(false);

    if (tabController.index != PagesEnum.PAGE_1.index) {
      tabController.animateTo(0);
      return Future.value(false);
    }
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate('tab_to_exit'),
          backgroundColor: AppColors.mainColor,
          textColor: AppColors.white);
      return Future.value(false);
    }
    SystemNavigator.pop();
    return Future.value(true);
  }

  bool checkIndex() {
    if (tabController.index == 0) return false;
    // botNavBar.onTap(0);
    tabController.animateTo(0);

    return true;
  }
}

enum PagesEnum {
  PAGE_1,
  PAGE_2,
  PAGE_3,
  PAGE_4,
  PAGE_5,
}

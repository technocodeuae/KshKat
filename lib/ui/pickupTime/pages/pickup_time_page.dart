import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/constants/text_style.dart';
import 'package:erp/models/pickup/pickup_time_model.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/stores/theme/theme_store.dart';
import 'package:erp/ui/pickupTime/controller/pickup_time_controller.dart';
import 'package:erp/utils/device/app_uitls.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/widgets/empty_page_widget.dart';

import '../../../../data/repo/user_management_repository.dart';
import '../../../../di/components/service_locator.dart';
import '../../../../utils/routes/routes.dart';
import '../../../state/general_state.dart';
import '../../checkout/argument/CheckoutArgument.dart';
import '../../shimmer/dashboard_home_loading_widget.dart';
import '../../splash/argument/GlobalArgument.dart';
import '../../user_management/widgets/button_user_management_widget.dart';

class PickUpTimePage extends StatefulWidget {
  const PickUpTimePage();

  @override
  _PickUpTimePageState createState() => _PickUpTimePageState();
}

class _PickUpTimePageState extends State<PickUpTimePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  PickupTimeController pickupTimeController =  Get.find();

  var arg;

  var token;

  var numCart;

  late double widthC, heightC;
  bool isFromCheckout = false;

  var _cancelToken = CancelToken();

  // //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;
  int? _selectedIndex = 0, _selectedIndexTime = null;

  List<DilverySlotData> list = [];
  UserManagementRepository _repository = getIt<UserManagementRepository>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppBar appBar = AppBar(
      title: Container(
        color: AppColors.transparent,
        child: Padding(
            padding:
                EdgeInsets.only(bottom: 40.0, top: 40.0, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      isFromCheckout
                          ? {
                              arg.isFromCart
                                  ? Navigator.pop(context)
                                  : Navigator.of(context).pushReplacementNamed(
                                      Routes.checkoutPage,
                                      arguments: CheckoutArgument(
                                          arg.addressId,
                                          arg.time,
                                          arg.address,
                                          arg.subtotal,
                                          arg.tax,
                                          arg.total,
                                          "",
                                          false,
                                      null))
                            }
                          : Navigator.pop(context);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.arrow_back_ios_sharp,
                        color: AppColors.black,
                        size: 20,
                      ),
                    )),
                Spacer(),
                FadeInDown(
                  delay: Duration(milliseconds: 800),
                  duration: Duration(milliseconds: 400),
                  animate: true,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('pick_time'),
                      style: appTextStyle.subBigTSBasicBold.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppTextSize.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                    onTap: () {},
                    child: Container(
                      width: 40,
                      child: Icon(
                        Icons.access_time_rounded,
                        color: AppColors.black,
                        size: 20,
                      ),
                    )),
              ],
            )),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.appBarBGColor,
      brightness: Brightness.light,
      elevation: 0,
    );

    widthC = DeviceUtils.getScaledWidth(context, 1);
    heightC = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return WillPopScope(
      onWillPop: () async {
        isFromCheckout
            ? {
                arg.isFromCart
                    ? Navigator.pop(context)
                    : Navigator.of(context).pushReplacementNamed(
                        Routes.checkoutPage,
                        arguments: CheckoutArgument(
                            arg.addressId,
                            arg.time,
                            arg.address,
                            arg.subtotal,
                            arg.tax,
                            arg.total,
                            "",
                            false,
                        null))
              }
            : Navigator.pop(context);

        return false;
      },
      child: Stack(
        children: [
          Container(
            color: AppColors.white,
          ),
          Scaffold(
            appBar: appBar,
            backgroundColor: AppColors.scaffoldBGColor,
            body: Column(
              children: [
                VerticalPadding(
                  percentage: 0.02,
                ),
                Expanded(
                  child: _buildBody(height: heightC, width: widthC),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody({required double width, required double height}) {
    return GetBuilder<PickupTimeController>(
        builder: (state) {

          if (GeneralState.isFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppUtils.showErrorMessage(error: state.pickupFailure.error, context: context);

            });
          }

          if (GeneralState.isLoading)
           ListView.builder(
                itemCount: 10,
                // Important code
                itemBuilder: (context, index) =>
                    DashboardHomeLoadingWidget(
                      width: width * 0.83,
                      height: height,
                    ));

          if (GeneralState.iSuccess) {
            list = state.pickupSuccess.result.data!.dilvery_slot!;
            return _buildMainView(
                height:height, width:width, result: list);
          }

          return _buildMainView(
              height: height, width:width, result: list);

        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);

    if (ModalRoute.of(context)!.settings.arguments.runtimeType ==
        CheckoutArgument) {
      isFromCheckout = true;
      arg = ModalRoute.of(context)!.settings.arguments as CheckoutArgument;
      _selectedIndex = arg.addressId != null
          ? int.parse(arg.addressId.toString().split(",")[0])
          : 0;
      _selectedIndexTime = arg.addressId != null
          ? int.parse(arg.addressId.toString().split(",")[1])
          : null;
      if (_selectedIndexTime != null) _onSelectedTime(_selectedIndexTime!);
      _onSelected(_selectedIndex!);
    } else {
      arg = ModalRoute.of(context)!.settings.arguments as GlobalArgument;
      _selectedIndex = arg.index;
      _selectedIndexTime = arg.indexTime;
      if (_selectedIndexTime != null) _onSelectedTime(_selectedIndexTime!);
      _onSelected(_selectedIndex!);
    }
  }

  @override
  void initState() {
    super.initState();
    GeneralState.reset();
    getToken();
    pickupTimeController.getPickupTime(_cancelToken);

  }

  Future<void> getToken() async {
    token = await _repository.authToken;
    numCart = await _repository.numCart;
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  _buildMainView(
      {required double width,
      required double height,
      required List<DilverySlotData> result}) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.space12),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              //controller: ModalScrollController.of(context),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              //physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return index >= result.length
                    ? Container() /*BottomLoader()*/
                    : Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(AppDimens.space6),
                            child: ButtonUserManagementWidget(
                              width: widthC / 4,
                              child: Text(
                                result[index].name!,
                                style: appTextStyle.middleTSBasic.copyWith(
                                    color: _selectedIndex != null &&
                                            _selectedIndex == index
                                        ? AppColors.white
                                        : AppColors.black),
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? AppColors.mainColor
                                  : AppColors.white,
                              height: 55,
                              borderRadius: 10.0,
                              borderColor: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? AppColors.mainColor
                                  : AppColors.white,
                              onPressed: () {
                                _onSelected(index);
                                _selectedIndexTime = null;
                              },
                            ),
                          )
                        ],
                      );
              },
              itemCount: result.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          if (result.length > 0)
            Text(
              AppLocalizations.of(context).translate('available_time'),
              style: appTextStyle.normalTSBasic.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: AppTextSize.normal),
              textAlign: TextAlign.start,
            ),
          VerticalPadding(
            percentage: 0.05,
          ),
          if (result.length > 0)
            Expanded(
              child: _buildSubMainView(
                  width: width,
                  height: height,
                  result: result[_selectedIndex!].slots_ids!),
              flex: 4,
            ),
          Padding(
            padding: EdgeInsets.all(60.0),
            child: ButtonUserManagementWidget(
              width: MediaQuery.of(context).size.width,
              child: Text(
                AppLocalizations.of(context).translate("confirm_time"),
                style:
                    appTextStyle.middleTSBasic.copyWith(color: AppColors.white),
              ),
              backgroundColor: _selectedIndexTime != null
                  ? AppColors.mainColor
                  : AppColors.gray,
              height: 55,
              borderRadius: 10.0,
              borderColor: AppColors.white,
              onPressed: () async {
                if (_selectedIndexTime != null) {
                  String timeId = _selectedIndex.toString() +
                      "," +
                      _selectedIndexTime.toString() +
                      "," +
                      result[_selectedIndex!].name.toString() +
                      "," +
                      result[_selectedIndex!]
                          .slots_ids![_selectedIndexTime!]
                          .name
                          .toString() +
                      ","+
                      result[_selectedIndex!].id.toString() +
                      "," +
                      result[_selectedIndex!]
                          .slots_ids![_selectedIndexTime!]
                          .id
                          .toString();
                  String time = result[_selectedIndex!]
                          .name
                          .toString()
                          .split("-")[1] +
                      "-" +
                      result[_selectedIndex!].name.toString().split("-")[2] +
                      "," +
                      result[_selectedIndex!]
                          .slots_ids![_selectedIndexTime!]
                          .name
                          .toString()
                          .split("-")[0]
                          .toString();
                  await _repository.saveTime(time);
                  await _repository.saveTimeId(timeId);
                  isFromCheckout
                      ? {
                          arg.isFromCart
                              ? Navigator.of(context).pushReplacementNamed(
                                  Routes.mainRootPage,
                                  arguments: GlobalArgument(token, numCart,
                                      _selectedIndex, _selectedIndexTime,1))
                              : Navigator.of(context).pushReplacementNamed(
                                  Routes.checkoutPage,
                                  arguments: CheckoutArgument(
                                      timeId,
                                      time,
                                      arg.address,
                                      arg.subtotal,
                                      arg.tax,
                                      arg.total,
                                      "",
                                      false,
                                  null)),
                        }
                      : Navigator.of(context).pushReplacementNamed(
                          Routes.mainRootPage,
                          arguments: GlobalArgument(token, numCart,
                              _selectedIndex, _selectedIndexTime,null));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildSubMainView(
      {required double width,
      required double height,
      required List<SlotsIdsData> result}) {
    return result.length > 0
        ? GridView.builder(
            itemCount: result.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.only(
                bottom: AppDimens.space4, top: AppDimens.space4),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: AppDimens.space10,
              mainAxisSpacing: AppDimens.space10,
              childAspectRatio: 2.75,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ButtonUserManagementWidget(
                width: widthC / 4,
                child: Text(
                  result[index].name!,
                  style: appTextStyle.middleTSBasic.copyWith(
                      color: _selectedIndexTime != null &&
                              _selectedIndexTime == index
                          ? AppColors.white
                          : AppColors.black),
                  textAlign: TextAlign.center,
                ),
                backgroundColor: result[index].is_disabled!
                    ? AppColors.mainGray
                    : _selectedIndexTime != null && _selectedIndexTime == index
                        ? AppColors.mainColor
                        : AppColors.white,
                height: 55,
                borderRadius: 10.0,
                borderColor:
                    _selectedIndexTime != null && _selectedIndexTime == index
                        ? AppColors.mainColor
                        : AppColors.white,
                onPressed: () {
                  if (!result[index].is_disabled!) _onSelectedTime(index);
                },
              );
            },
          )
        : EmptyPageWidget();
  }

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _onSelectedTime(int index) {
    setState(() {
      _selectedIndexTime = index;
    });
  }
}

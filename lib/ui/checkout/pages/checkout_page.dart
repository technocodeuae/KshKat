import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:erp/ui/checkout/widgets/addres_checkout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/utils/routes/routes.dart';
import 'package:provider/provider.dart';

import '../../../common/animation/animation_column_widget.dart';
import '../../../data/repo/user_management_repository.dart';
import '../../../models/cart/cart_validate_model.dart';
import '../../../state/general_state.dart';
import '../../../stores/language/language_store.dart';
import '../../../utils/device/app_uitls.dart';
import '../../../widgets/dialog/address_dialog.dart';
import '../../splash/argument/GlobalArgument.dart';
import '../../user_management/widgets/button_user_management_widget.dart';
import '../argument/CheckoutArgument.dart';
import '../controller/checkout_controller.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with SingleTickerProviderStateMixin {
  CheckoutController checkoutController = Get.find();

  late double width, height;
  CheckoutArgument? arg;
  bool isAddresExist = true;
  bool shouldTransfer = false;
  String paymentMethod = 'cash';

  String? timeId, time, address, addressId;
  double? subtotal, tax, total;
  var token, numCart;
  String curr = "AED";
  var _cancelToken = CancelToken();
  TextEditingController copuonController = TextEditingController();

  UserManagementRepository _repository = getIt<UserManagementRepository>();
  late LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
    GeneralState.reset();
    getToken();
  }

  Future<void> getAddressId() async {
    addressId = await _repository.addressId;
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
  }

  @override
  Widget build(BuildContext context) {
    width = DeviceUtils.getScaledWidth(context, 1);
    height = DeviceUtils.getScaledHeight(context, 1);
    try {
      final d = ModalRoute.of(context)!.settings.arguments as Map;
      arg = d['checkout_argument'] as CheckoutArgument;
    } catch (e) {
      arg = ModalRoute.of(context)!.settings.arguments as CheckoutArgument;
    }

    addressId = arg!.addressId;
    time = arg!.time;
    address = arg!.address;
    subtotal = arg!.subtotal;
    tax = arg!.tax;
    total = arg!.total;
    curr = arg!.curr;

    AppBar appBar = AppBar(
      title: Container(
        color: AppColors.transparent,
        child: Padding(
            padding:
                EdgeInsets.only(bottom: 40.0, top: 40.0, left: 10, right: 10),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                          Routes.mainRootPage,
                          arguments: GlobalArgument(token, numCart, 0, 0, 1));
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Icon(
                        _languageStore.getLanguage() == "Arabic"
                            ? Icons.arrow_forward_ios_sharp
                            : Icons.arrow_back_ios_sharp,
                        color: AppColors.black,
                        size: 20,
                      ),
                    )),
                FadeInDown(
                  delay: Duration(milliseconds: 800),
                  duration: Duration(milliseconds: 400),
                  animate: true,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('order'),
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

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed(Routes.mainRootPage,
            arguments: GlobalArgument(token, numCart, 0, 0, 1));
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
            body: GetBuilder<CheckoutController>(builder: (state) {
              if (GeneralState.isFailure) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  AppUtils.showErrorMessage(
                      error: state.checkoutFailure.error, context: context);
                });
              }

              if (GeneralState.isLoading) return _buildBody();
              if (GeneralState.iSuccess && shouldTransfer) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  AppUtils.showToast(
                      msg: AppLocalizations.of(context)
                          .translate('success_order'),
                      context: context);
                  final result =
                      await Navigator.of(context).pushNamed(Routes.orderPage);
                  if (result == true) {
                    GeneralState.reset();
                    Navigator.of(context).pushReplacementNamed(
                        Routes.mainRootPage,
                        arguments: GlobalArgument(token, numCart, 0, 0, 1));
                  }
                });
              }

              return _buildBody();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.space8),
      child: SingleChildScrollView(
        child: AnimationColumnWidget(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          duration: Duration(milliseconds: 1000),
          verticalOffset: 50,
          children: [
            // AddressCheckoutWidget(),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(Routes.addressPage, arguments: arg);
              },
              child: Card(
                color: AppColors.white,
                shadowColor: AppColors.mainGray.withOpacity(0.6),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: isAddresExist ? Colors.transparent : Colors.red),
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppRadius.radius10))),
                child: Container(
                  width: width,
                  padding: const EdgeInsets.all(AppDimens.space16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        color: AppColors.light_gray,
                        child: Icon(
                          Icons.home,
                          color: AppColors.mainColor,
                          size: 20,
                        ),
                      ),
                      HorizontalPadding(
                        percentage: 0.035,
                      ),
                      Container(
                        width: width / 1.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('delivery_address_'),
                              style: appTextStyle.minTSBasic
                                  .copyWith(color: AppColors.black),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            VerticalPadding(
                              percentage: 0.01,
                            ),
                            Text(
                              isAddresExist
                                  ? (address ?? '')
                                  : AppLocalizations.of(context)
                                      .translate('choose_location'),
                              style: appTextStyle.middleTSBasic.copyWith(
                                  color: isAddresExist
                                      ? AppColors.black
                                      : Colors.red),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            VerticalPadding(
                              percentage: 0.01,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: AppColors.black,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            VerticalPadding(
              percentage: 0.05,
            ),
            Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Card(
                    elevation: 2.0,
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(AppRadius.radiusDefault)),
                    ),
                    child: TextFormField(
                      controller: copuonController,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)
                              .translate('enter_copuon'),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.sp),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Expanded(
                    flex: 4,
                    child: GetBuilder<CheckoutController>(
                      builder: (controller) => ButtonUserManagementWidget(
                        backgroundColor: AppColors.mainColor,
                        height: 55,
                        borderRadius: 10.0,
                        borderColor: AppColors.white,
                        onPressed: () {
                          controller.checkCopuon(_cancelToken,
                              copuonController.text, _languageStore.getCode());
                        },
                        child: controller.isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                AppLocalizations.of(context).translate('apply'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ))
              ],
            ),
            VerticalPadding(
              percentage: 0.05,
            ),
            GetBuilder<CheckoutController>(
              builder: (controller) => controller.copuonResult == null
                  ? Container()
                  : Card(
                      elevation: 2.0,
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppRadius.radiusDefault)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: controller.copuonResult!.containsKey('message')
                            ? Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                height: 50.sp,
                                child: Text(
                                  controller.copuonResult!['message'],
                                  style: appTextStyle.body2,
                                ))
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(width: 3.sp,),
                                  Text(
                                      '${AppLocalizations.of(context).translate('apply_copuon')} : ${controller.copuonResult!['code']}'),
                                  Row(
                                    children: [
                                      Text(
                                        '-${controller.copuonResult!['price']} ${controller.copuonResult!['type'] == 0 ? "%" : "AED"}',
                                        style:
                                            TextStyle(color: AppColors.mainRed),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            copuonController.text = '';
                                            controller.emptyCopuon();
                                          },
                                          icon: Icon(Icons.delete))
                                    ],
                                  )
                                ],
                              ),
                      ),
                    ),
            ),

            VerticalPadding(
              percentage: 0.05,
            ),
            Text(
              AppLocalizations.of(context).translate('order_summary'),
              style: appTextStyle.subBigTSBasicBold.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: AppTextSize.normal),
              textAlign: TextAlign.start,
            ),
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
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context).translate("sub_total"),
                            style: appTextStyle.middleTSBasic
                                .copyWith(color: AppColors.black),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Text(
                            NumberFormat.currency(
                                    name: curr, customPattern: '\u00a4 ###,###')
                                .format(total!),
                            style: appTextStyle.middleTSBasic
                                .copyWith(color: AppColors.black),
                          ),
                          flex: 2,
                        ),
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
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context).translate("tax"),
                            style: appTextStyle.middleTSBasic
                                .copyWith(color: AppColors.black),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Text(
                            NumberFormat.currency(
                                    name: curr, customPattern: '\u00a4 ###,###')
                                .format(tax!),
                            style: appTextStyle.middleTSBasic
                                .copyWith(color: AppColors.black),
                          ),
                          flex: 2,
                        ),
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
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context).translate("total"),
                            style: appTextStyle.middleTSBasic
                                .copyWith(color: AppColors.black),
                          ),
                          flex: 1,
                        ),
                        Expanded(
                          child: Text(
                            NumberFormat.currency(
                                    name: curr, customPattern: '\u00a4 ###,###')
                                .format(total!),
                            style: appTextStyle.middleTSBasic
                                .copyWith(color: AppColors.black),
                          ),
                          flex: 2,
                        ),
                        HorizontalPadding(
                          percentage: 0.05,
                        ),
                      ],
                    ),
                    GetBuilder<CheckoutController>(
                      builder: (controller) => controller.copuonResult ==
                                  null ||
                              controller.copuonResult!.containsKey('message')
                          ? Container()
                          : Column(
                              children: [
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
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate("total_after_copuon"),
                                        style: appTextStyle.middleTSBasic
                                            .copyWith(color: AppColors.black),
                                      ),
                                      flex: 1,
                                    ),
                                    Expanded(
                                      child: Text(
                                        NumberFormat.currency(
                                                name: curr,
                                                customPattern: '\u00a4 ###,###')
                                            .format(controller.copuonResult![
                                                        'type'] ==
                                                    0
                                                ? (total! -
                                                    (total! *
                                                        controller
                                                                .copuonResult![
                                                            'price']))
                                                : (total! -
                                                    controller.copuonResult![
                                                        'price'])),
                                        style: appTextStyle.middleTSBasic
                                            .copyWith(color: AppColors.black),
                                      ),
                                      flex: 2,
                                    ),
                                    HorizontalPadding(
                                      percentage: 0.05,
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
              percentage: 0.05,
            ),
            Text(
              AppLocalizations.of(context).translate('choose_payment_way'),
              style: appTextStyle.subBigTSBasicBold.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: AppTextSize.normal),
              textAlign: TextAlign.start,
            ),
            Card(
              elevation: 2.0,
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppRadius.radiusDefault)),
              ),
              child: Column(
                children: [
                  RadioListTile(
                    value: 'cash',
                    groupValue: paymentMethod,
                    title: Text(
                      AppLocalizations.of(context).translate('cash'),
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.black),
                    ),
                    onChanged: (value) {
                      paymentMethod = value.toString();
                      setState(() {});
                    },
                  ),
                  RadioListTile(
                    value: 'e-pay',
                    groupValue: paymentMethod,
                    title: Text(
                      AppLocalizations.of(context).translate('e_pay'),
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.black),
                    ),
                    onChanged: (value) {
                      paymentMethod = value.toString();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            VerticalPadding(
              percentage: 0.05,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ButtonUserManagementWidget(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  AppLocalizations.of(context).translate("place_order"),
                  style: appTextStyle.middleTSBasic
                      .copyWith(color: AppColors.white),
                ),
                backgroundColor: AppColors.mainColor,
                height: 55,
                borderRadius: 10.0,
                borderColor: AppColors.white,
                onPressed: () async {
                  if (address == null) {
                    isAddresExist = false;
                    setState(() {});
                    // showDialog(
                    //     context: context,
                    //     builder: (context) => AddressDialog());
                  } else {
                    await getAddressId().whenComplete(() {
                      shouldTransfer = true;
                      checkoutController.checkout(
                        _cancelToken,
                        arg!.data!.items,
                        int.parse(addressId ?? '0'),
                        _languageStore.getCode(),
                        paymentMethod,
                        copuonController.text,
                      );
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

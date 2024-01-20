import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:erp/common/animation/animation_column_widget.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/constants/text_style.dart';
import 'package:erp/models/address/address_model.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/stores/theme/theme_store.dart';
import 'package:erp/utils/device/app_uitls.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/utils/routes/routes.dart';
import 'package:erp/widgets/empty_page_widget.dart';

import '../../../../../data/repo/user_management_repository.dart';
import '../../../../../di/components/service_locator.dart';
import '../../../state/general_state.dart';
import '../../checkout/argument/CheckoutArgument.dart';
import '../../shimmer/dashboard_home_loading_widget.dart';
import '../controller/address_controller.dart';
import '../map/argument/MapArgument.dart';
import '../widget/address_overview_widget.dart';

class AddressPage extends StatefulWidget {
  const AddressPage();

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var _cancelToken = CancelToken();
  int limit = 25, page = 1, startAt = 0, endAt = 0, preparePage = 1;
  late List<Data> list = <Data>[];
  List<String> warehouses = [];
  List<String> company = [];
  List<String> type = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _refresherKey = GlobalKey();
  final formKey = GlobalKey<FormState>();

  AddressController addressController = Get.find();

  late double widthC, heightC;

  String search = "";

  // //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  // There is next pages or not
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  late ScrollController _controller;
  var token;
  var numCart;
  bool isFromCheckout = false;
  String? _userInfo;
  List<String> user = [];
  late CheckoutArgument arg;
  UserManagementRepository _repository = getIt<UserManagementRepository>();

  LocationData? myLocation;
  Position? myLocationIos;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (ModalRoute.of(context)!.settings.arguments != null) {
      isFromCheckout = true;
      print(
          "objectiiiiiiiiiiissssssssssssssss from checkout ${isFromCheckout}");
      arg = ModalRoute.of(context)!.settings.arguments as CheckoutArgument;
    } else
      arg = new CheckoutArgument(null, null, null, 0, 0, 0, "", false, null);
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
                          ? Navigator.of(context).pushReplacementNamed(
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
                                  arg.data))
                          : Navigator.pop(context);

                      /*Navigator.of(context).pushReplacementNamed(
                        Routes.mainRootPage,arguments: GlobalArgument(token,numCart,0,0));*/
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
                      AppLocalizations.of(context)
                          .translate('delivery_address'),
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
                    onTap: () async {
                      if (myLocation != null || myLocationIos != null) {
                        final result = await Navigator.of(context).pushNamed(
                            Routes.mapPage,
                            arguments: MapArgument(token, numCart, _userInfo,
                                myLocation, myLocationIos));
                        if (result == true) {
                          addressController.getAddress(_cancelToken);
                          setState(() {

                          });
                        }
                      }
                    },
                    child: Container(
                      width: 50,
                      child: Icon(
                        Icons.add,
                        color: AppColors.black,
                        size: 20,
                      ),
                    )),
              ],
            )),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.appBarBGColor,
      // brightness: Brightness.light,
      elevation: 0,

    );

    widthC = DeviceUtils.getScaledWidth(context, 1);
    heightC = DeviceUtils.getScaledHeight(context, 1) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return WillPopScope(
      onWillPop: () async {
        isFromCheckout
            ? Navigator.of(context).pushReplacementNamed(Routes.checkoutPage,
                arguments: CheckoutArgument(
                    arg.addressId,
                    arg.time,
                    arg.address,
                    arg.subtotal,
                    arg.tax,
                    arg.total,
                    "",
                    false,
                    arg.data))
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
    return GetBuilder<AddressController>(builder: (state) {
      if (GeneralState.isFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AppUtils.showErrorMessage(
              error: state.addressFailure.error, context: context);
        });
      }

      if (GeneralState.isLoading)
        return (!_isLoadMoreRunning)
            ? ListView.builder(
                itemCount: 10,
                // Important code
                itemBuilder: (context, index) => DashboardHomeLoadingWidget(
                      width: widthC * 0.83,
                      height: heightC,
                    ))
            : _buildMainView(height: heightC, width: widthC, result: list);
      if (GeneralState.iSuccess) {
        list = state.addressSuccess.result.data!;
        return _buildMainView(height: heightC, width: widthC, result: list);
      }

      return _buildMainView(height: heightC, width: widthC, result: list);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
  }

  var currentAddress;
  getAddress() async {
    currentAddress = await _repository.address;
  }

  @override
  void initState() {
    super.initState();
    GeneralState.reset();
    _isFirstLoadRunning = true;
    _controller = new ScrollController()..addListener(_loadMore);
    getAddress();
    addressController.getAddress(_cancelToken);

    getUser();
    getLocation();
  }

  _buildMainView(
      {required double width,
      required double height,
      required List<Data> result}) {
    return Column(
      children: [
        Expanded(
          child: RefreshConfiguration(
            child: SmartRefresher(
              header: WaterDropMaterialHeader(
                backgroundColor: AppColors.mainColor,
                offset: _languageStore.getLanguage() == "Arabic" ? -85.h : 0.h,
              ),
              physics: BouncingScrollPhysics(),
              onRefresh: () async {
                page = 1;
                list = [];
                _isFirstLoadRunning = true;
                _isLoadMoreRunning = false;
                addressController.getAddress(_cancelToken);
                _refreshController.refreshCompleted();
              },
              key: _refresherKey,
              footer: ClassicFooter(
                loadStyle: LoadStyle.ShowWhenLoading,
              ),
              controller: _refreshController,
              child: Container(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: AnimationColumnWidget(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      duration: Duration(milliseconds: 1000),
                      verticalOffset: 50,
                      children: [
                        Column(
                          children: [
                            VerticalPadding(
                              percentage: 0.01,
                            ),
                            result.length > 0
                                ? ListView.builder(
                                    padding: EdgeInsets.zero,
                                    controller: _controller,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return index >= result.length
                                          ? Container() /*BottomLoader()*/
                                          : Row(
                                              children: [
                                                AddressOverviewWidget(
                                                  arg: arg,
                                                  isFromCheckout:
                                                      isFromCheckout,
                                                  numCart: numCart,
                                                  token: token,
                                                  width: widthC - widthC / 7,
                                                  infoData: result[index],
                                                  cancelToken: _cancelToken,
                                                  currentAddres: currentAddress,
                                                ),
                                              ],
                                            );
                                    },
                                    itemCount: calculateListItemCount(result),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                  )
                                : EmptyPageWidget(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;

  void _loadMore() async {}

  int calculateListItemCount(List<Data> state) {
    if (_hasNextPage) {
      return state.length;
    } else {
      // + 1 for the loading indicator
      return state.length + 1;
    }
  }

  Future<void> getUser() async {
    _userInfo = await _repository.userInfo;
    token = await _repository.authToken;
    numCart = await _repository.numCart;
    user = _userInfo!.split(" ");
  }

  void getLocation() async {
    if (Platform.isIOS) {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      Position pos = await Geolocator.getCurrentPosition();
      myLocationIos = pos;
    } else {
      Location location = Location();
      final LocationData pos = await location.getLocation();
      myLocation = pos;
    }
  }
}

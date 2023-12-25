import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/data/repo/user_management_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/home/category_model.dart';
import 'package:erp/models/user_management/sign_in_dashboard_response.dart';
import 'package:erp/state/general_state.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/stores/theme/theme_store.dart';
import 'package:erp/utils/device/app_uitls.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/cart/products_cart.dart';
import '../../../utils/locale/app_localization.dart';
import '../../../utils/routes/routes.dart';
import '../../shimmer/dashboard_home_loading_widget.dart';
import '../controller/category_controller.dart';
import '../widget/category_overview_widget.dart';
import '../widget/flash_deals_overview_widget.dart';
import '../widget/latest_overview_widget.dart';

class FlashDealsPage extends StatefulWidget {
  final token;
  final UserSignInDashboardResult? userInfo;

  const FlashDealsPage({required this.token, this.userInfo});

  @override
  _FlashDealsPageState createState() => _FlashDealsPageState();
}

class _FlashDealsPageState extends State<FlashDealsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  CategoryController categoryController = Get.find();

  var _cancelToken = CancelToken();
  int limit = 25, page = 1, startAt = 0, endAt = 0, preparePage = 1;
  late List<LatestProductData> latestList = <LatestProductData>[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _refresherKey = GlobalKey();
  final formKey = GlobalKey<FormState>();

  UserManagementRepository _repository = getIt<UserManagementRepository>();
  var token, address, time, timeId;
  List<Products> cart = [];
  List<String> imgList = [AppAssets.one, AppAssets.two, AppAssets.three];
  int? num = 0;

  // //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  // There is next pages or not
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  bool _isFlashDeals = true;
  late ScrollController _controller;
  late double widthC, heightC;

  List<CategoriesData> firstList = [];
  List<CategoriesData> secondList = [];
  String search = "";

  DateTime? startDate;

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    token = widget.token;
    widthC = DeviceUtils.getScaledWidth(context, 1);
    heightC = DeviceUtils.getScaledHeight(context, 1);

    return _buildBody(height: heightC, width: widthC);
  }

  Widget _buildBody({required double width, required double height}) {
    return GetBuilder<CategoryController>(
        init: categoryController,
        builder: (state) {
          if (_isFlashDeals && GeneralState.isFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppUtils.showErrorMessage(
                  error: state.signInFailure!.error, context: context);
            });
          }

          if (_isFlashDeals && GeneralState.isLoading)
            return (!_isLoadMoreRunning)
                ? Container(
                    height: 150.sp,
                    width: widthC,
                    margin: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: ListView.builder(
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        // Important code
                        itemBuilder: (context, index) =>
                            DashboardHomeLoadingWidget(
                              width: 300.sp,
                              height: 90.sp,
                            )),
                  )
                :/* state.flashDealSuccess!.result.data!.isEmpty
                    ? Container()
                    :*/ _buildMainView(height: heightC, width: widthC);
          if (state.flashDealSuccess != null &&
              _isFlashDeals &&
              (GeneralState.iSuccess) &&
              (state.flashDealSuccess == categoryController.flashDealSuccess)) {
            if (page == 1) {
              latestList = state.flashDealSuccess!.result.data!;
            } else {
              latestList.addAll(state.flashDealSuccess!.result.data!);
            }
            _isFirstLoadRunning = false;
            _isLoadMoreRunning = false;

            return /*state.flashDealSuccess!.result.data!.isEmpty
                    ? Container()
                    :*/_buildMainView(height: heightC * 30, width: widthC);
          }

          return /*state.flashDealSuccess!.result.data!.isEmpty
                    ? Container()
                    :*/
                    _buildMainView(height: heightC, width: widthC);
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    categoryController.getFlashDeals(
        _cancelToken, limit, page, _languageStore.getCode());
  }

  @override
  void initState() {
    super.initState();
    GeneralState.reset();
    _isFirstLoadRunning = true;
    _controller = new ScrollController()..addListener(_loadMore);
    getToken();
  }

  Future<void> getToken() async {
    token = await _repository.authToken;
    address = await _repository.address;
    num = await _repository.numCart;
    cart = await _repository.cart;
    time = await _repository.time;
    timeId = await _repository.timeId;
  }

  _buildMainView({required double width, required double height}) {
    latestList.forEach((element) {
      print('object ${element.discount_date}');
    });

    return Column(
      children: [
        Container(
            height: 200.sp,
            margin: EdgeInsets.symmetric(horizontal: 16.sp),
            child:
                /*  CarouselSlider(
          options: CarouselOptions(
            // autoPlay: true,
            // aspectRatio: ,
            // enlargeCenterPage: true,
            reverse: true
          ),
          items: latestList
              .map((item) => FlashDealsOverviewWidget(
                  address: address,
                  token: token,
                  cart: cart,
                  infoData:item,// latestList[index],
                  cancelToken: _cancelToken,
                ))
              .toList(),
        ),*/
                ListView.builder(
              itemCount: latestList.length,
              shrinkWrap: true,
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return FlashDealsOverviewWidget(
                  address: address,
                  token: token,
                  cart: cart,
                  infoData: latestList[index],
                  cancelToken: _cancelToken,
                );
              },
            )),
        latestList.length > 1
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 4.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      latestList.length,
                      (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.sp),
                            child: CircleAvatar(
                              radius: 4.sp,
                              backgroundColor: AppColors.textNaveColor,
                            ),
                          )),
                ),
              )
            : Container(),
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

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      //   page = preparePage;
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      page++;
      categoryController.getFlashDeals(
          _cancelToken, limit, page, _languageStore.getCode());
    }
  }

  int calculateListMedicineCount(List<CategoriesData> state) {
    if (_hasNextPage) {
      return state.length;
    } else {
      // + 1 for the loading indicator
      return state.length + 1;
    }
  }
}

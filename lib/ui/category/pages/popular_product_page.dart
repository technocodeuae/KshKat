import 'package:animate_do/animate_do.dart';
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
import '../../splash/argument/GlobalArgument.dart';
import '../controller/category_controller.dart';
import '../widget/category_overview_widget.dart';
import '../widget/latest_overview_widget.dart';

class PopularProduct extends StatefulWidget {
  final token;
  final UserSignInDashboardResult? userInfo;

  const PopularProduct({required this.token, this.userInfo});

  @override
  _PopularProductState createState() => _PopularProductState();
}

class _PopularProductState extends State<PopularProduct>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  CategoryController categoryController = Get.find();

  var _cancelToken = CancelToken();
  int limit = 25, page = 1, startAt = 0, endAt = 0, preparePage = 1;
  late List<LatestProductData> popularList = <LatestProductData>[];
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
  bool _isTopProduct = true;
  late ScrollController _controller;
  late double widthC, heightC;

  List<CategoriesData> firstList = [];
  List<CategoriesData> secondList = [];
  String search = "";

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
          if (_isTopProduct == true && GeneralState.isFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppUtils.showErrorMessage(
                  error: state.signInFailure!.error, context: context);
            });
          }

          if (_isTopProduct == true && GeneralState.isLoading)
            return (!_isLoadMoreRunning)
                ? Column(
                    children: [
                      FadeInDown(
                          delay: Duration(milliseconds: 800),
                          duration: Duration(milliseconds: 400),
                          animate: true,
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: AppDimens.space16,
                                      end: AppDimens.space16),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('popular_product'),
                                    style: appTextStyle.bigTSBasic.copyWith(
                                      color: AppColors.textNaveColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Container(
                        height: 150.sp,
                        width: widthC,
                        child: ListView.builder(
                            itemCount: 10,
                            scrollDirection: Axis.horizontal,
                            // Important code
                            itemBuilder: (context, index) =>
                                DashboardHomeLoadingWidget(
                                  width: 71.sp,
                                  height: 71.sp,
                                )),
                      ),
                    ],
                  )
                : _buildMainView(height: heightC, width: widthC);
          if (state.popularProductSuccess != null &&
              _isTopProduct == true &&
              (GeneralState.iSuccess) &&
              (state.popularProductSuccess ==
                  categoryController.popularProductSuccess)) {
            if (page == 1) {
              popularList = state.popularProductSuccess!.result.data!;
            } else {
              popularList.addAll(state.popularProductSuccess!.result.data!);
            }
            _isFirstLoadRunning = false;
            _isLoadMoreRunning = false;

            return _buildMainView(height: heightC * 30, width: widthC);
          }

          return _buildMainView(height: heightC, width: widthC);
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    categoryController.getPopularProduct(
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
              delay: Duration(milliseconds: 800),
              duration: Duration(milliseconds: 400),
              animate: true,
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsetsDirectional.only(
                          start: AppDimens.space16, end: AppDimens.space16),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('popular_product'),
                        style: appTextStyle.bigTSBasic.copyWith(
                          color: AppColors.textNaveColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Container(
              height: 200.sp,
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 4) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.allPopularProductPage,
                            arguments:
                                GlobalArgument(token, null, null, null, null));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)
                                  .translate('show_all'),
                              style: TextStyle(
                                color: AppColors.textMainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.secondaryContainColor,
                                      width: 3),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(
                                  Localizations.localeOf(context)
                                              .languageCode ==
                                          'ar'
                                      ? Icons.keyboard_arrow_left_rounded
                                      : Icons.keyboard_arrow_right_rounded,
                                  color: AppColors.secondaryContainColor,
                                ))
                          ],
                        ),
                      ),
                    );
                  }

                  return LatestOverviewWidget(
                    address: address,
                    token: token,
                    cart: cart,
                    infoData: popularList[index],
                    cancelToken: _cancelToken,
                  );
                },
              )),
          VerticalPadding(
            percentage: 0.05,
          ),
        ],
      ),
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
      categoryController.getPopularProduct(
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

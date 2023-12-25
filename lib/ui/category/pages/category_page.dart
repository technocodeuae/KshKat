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
import '../../shimmer/dashboard_home_loading_widget.dart';
import '../controller/category_controller.dart';
import '../widget/category_overview_widget.dart';

class CategoryPage extends StatefulWidget {
  final token;
  final UserSignInDashboardResult? userInfo;

  const CategoryPage({required this.token, this.userInfo});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  CategoryController categoryController = Get.find();

  var _cancelToken = CancelToken();
  int limit = 25, page = 1, startAt = 0, endAt = 0, preparePage = 1;
  late List<LatestProductData> latestList = <LatestProductData>[];
  late List<TopProductData> topList = <TopProductData>[];
  late List<CategoriesData> categoryList = <CategoriesData>[];
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
  bool _isCategory = true;
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
          if (_isCategory && GeneralState.isFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppUtils.showErrorMessage(
                  error: state.signInFailure!.error, context: context);
            });
          }

          if (_isCategory && GeneralState.isLoading)
            return (!_isLoadMoreRunning)
                ? Container(
                    height: 150.sp,
                    width: widthC,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 5.sp,
                            mainAxisSpacing: 5.sp,
                            childAspectRatio: 1.sp //size.aspectRatio * 2.5,
                            ),
                        padding: EdgeInsets.all(15.sp),
                        itemCount: 8,
                        // Important code
                        itemBuilder: (context, index) =>
                            DashboardHomeLoadingWidget(
                              width: 50.sp,
                              height: 71.sp,
                            )),
                  )
                : _buildMainView(height: heightC, width: widthC);
          if (state.categorySuccess != null &&
              _isCategory &&
              GeneralState.iSuccess &&
              (state.categorySuccess == categoryController.categorySuccess)) {
            if (page == 1) {
              categoryList = state.categorySuccess!.result.data!;
              firstList = categoryList.sublist(0, categoryList.length ~/ 2);
              secondList = categoryList.sublist(categoryList.length ~/ 2);
              // topList = state.categorySuccess.result.top_product!;
              // latestList = state.categorySuccess.result.latest_product!;
            } else {
              if (state.categorySuccess!.result.data!.length > 0)
                categoryList.addAll(state.categorySuccess!.result.data!);

              firstList = categoryList.sublist(0, categoryList.length ~/ 2);
              secondList = categoryList.sublist(categoryList.length ~/ 2);
              // topList.addAll(state.categorySuccess.result.top_product!);
              // latestList.addAll(state.categorySuccess.result.latest_product!);
            }
            _isFirstLoadRunning = false;
            _isLoadMoreRunning = false;
            /*  page != state.categorySuccess.result.data!.is_last_page!
            ? _hasNextPage = true
            : _hasNextPage = false;
        limit =
            int.parse(state.categorySuccess.result.data!.per_page!.toString());
        preparePage = (state.categorySuccess.result.data!.current_page! + 1);*/
            var h = topList.length + latestList.length + categoryList.length;
            return _buildMainView(height: h * 30, width: widthC);
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
    categoryController.getCategory(
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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 12.sp,
          mainAxisSpacing: 12.sp,
          childAspectRatio: 1.sp //size.aspectRatio * 2.5,
          ),
      physics: const BouncingScrollPhysics(), //NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(15.sp),
      shrinkWrap: true,
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        final category = categoryList[index];
        return Row(
          children: [
            CategoryOverviewWidget(
              address: address,
              token: token,
              index: index,
              cart: cart,
              data: categoryList,
              infoData: category,
              cancelToken: _cancelToken,
            ),
          ],
        );
      },
    );

    /*Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // FadeInDown(
        //     delay: Duration(milliseconds: 800),
        //     duration: Duration(milliseconds: 400),
        //     animate: true,
        //     child: InkWell(
        //       onTap: () {
        //         Navigator.pushNamed(
        //           context,
        //           Routes.productDetailsPage,
        //         );
        //       },
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Container(
        //             padding: const EdgeInsetsDirectional.only(
        //                 start: AppDimens.space16,
        //                 end: AppDimens.space16),
        //             child: Text(
        //               AppLocalizations.of(context)
        //                   .translate('category'),
        //               style: appTextStyle.middleTSBasic.copyWith(
        //                   color: AppColors.mainRed,
        //                   fontWeight: FontWeight.bold,
        //                   fontSize: AppTextSize.normal),
        //             ),
        //           ),
        //         ],
        //       ),
        //     )),
        // VerticalPadding(
        //   percentage: 0.05,
        // ),
        Container(
            height: 80.sp,
            child: ListView.separated(
              itemCount: firstList.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              padding: const EdgeInsets.only(
                  bottom: AppDimens.space4, top: AppDimens.space4),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    CategoryOverviewWidget(
                      address: address,
                      token: token,
                      index: index,
                      cart: cart,
                      data: firstList,
                      infoData: firstList[index],
                      cancelToken: _cancelToken,
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 16.sp,
                );
              },
            )),
        Container(
          height: 80.sp,
          child: ListView.separated(
            controller: _controller,
            itemCount: secondList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.only(
                bottom: AppDimens.space4, top: AppDimens.space4),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  CategoryOverviewWidget(
                    address: address,
                    token: token,
                    index: index,
                    cart: cart,
                    data: secondList,
                    infoData: secondList[index],
                    cancelToken: _cancelToken,
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 16.sp,
              );
            },
          ),
        ),
        categoryList.length>8? Container(
          margin: EdgeInsets.symmetric(vertical: 4.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
                2,
                    (index) => Padding(
                  padding:  EdgeInsets.symmetric(
                      horizontal: 2.sp),
                  child: CircleAvatar(
                    radius: 4.sp,
                    backgroundColor: AppColors.textNaveColor,
                  ),
                )),
          ),
        ):Container(),

      ],
    );*/
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
      //page = preparePage;
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      page++;
      categoryController.getCategory(
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

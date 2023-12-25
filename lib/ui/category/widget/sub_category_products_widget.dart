import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/data/repo/user_management_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/home/category_model.dart';
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
import '../../shimmer/dashboard_home_loading_widget.dart';
import '../controller/category_controller.dart';
import '../widget/latest_overview_widget.dart';

class SubCategoryProductsWidget extends StatefulWidget {
  final token;
  final int mainId;
  final int catId;
  final int? childCat;
  final bool isCategories;

  const SubCategoryProductsWidget(
      {required this.token,
      required this.mainId,
      this.isCategories = false,
      required this.catId,
      required this.childCat});

  @override
  _SubCategoryProductsWidgetState createState() =>
      _SubCategoryProductsWidgetState();
}

class _SubCategoryProductsWidgetState extends State<SubCategoryProductsWidget>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  CategoryController categoryController = Get.find();

  var _cancelToken = CancelToken();
  int limit = 25, page = 1, startAt = 0, endAt = 0, preparePage = 1;
  late List<LatestProductData> latestList = <LatestProductData>[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _refresherKey = GlobalKey();
  // final formKey = GlobalKey<FormState>();

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
  bool _isLatestProduct = true;
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
          if (_isLatestProduct && GeneralState.isFailure) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              AppUtils.showErrorMessage(
                  error: state.signInFailure!.error, context: context);
            });
          }

          if (_isLatestProduct && GeneralState.isLoading)
            return (!_isLoadMoreRunning)
                ? Container(
                    height: MediaQuery.of(context).size.height * .6,
                    width: widthC,
                    child: GridView.builder(
                      itemCount: 10,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1.sp,
                          mainAxisSpacing: 1.sp,
                          childAspectRatio: .7.sp),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          DashboardHomeLoadingWidget(
                        width: 71.sp,
                        height: 71.sp,
                      ),
                    ),
                  )
                : _buildMainView(height: heightC, width: widthC);
          if (state.subCategoryProductsSuccess != null &&
              _isLatestProduct &&
              (GeneralState.iSuccess) &&
              (state.subCategoryProductsSuccess ==
                  categoryController.subCategoryProductsSuccess)) {
            if (page == 1) {
              latestList = state.subCategoryProductsSuccess!.result.data!;
            } else {
              latestList.addAll(state.subCategoryProductsSuccess!.result.data!);
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
    print("fgggggggggggggggggggffffffffffffffffffffff 5555");
    categoryController.getSubCategoryProducts(_cancelToken, widget.mainId,
        widget.catId, page, _languageStore.getCode(),
        childCat: widget.childCat);
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

  _buildMainView({
    required double width,
    required double height,
  }) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: widget.isCategories ? 5.sp : 16.sp),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: MediaQuery.of(context).size.height *
                  (widget.isCategories ? 0.6 : 0.67),
              child: RefreshConfiguration(
                child: SmartRefresher(
                    header: WaterDropMaterialHeader(
                      backgroundColor: AppColors.purple,
                      offset: _languageStore.getLanguage() == "Arabic"
                          ? -85.h
                          : 0.h,
                    ),
                    physics: BouncingScrollPhysics(),
                    onRefresh: () async {
                      page = 1;
                      categoryController.getSubCategoryProducts(
                          _cancelToken,
                          widget.mainId,
                          widget.catId,
                          page,
                          _languageStore.getCode(),
                          childCat: widget.childCat);
                      _refreshController.refreshCompleted();
                    },
                    key: _refresherKey,
                    footer: ClassicFooter(
                      loadStyle: LoadStyle.ShowWhenLoading,
                    ),
                    controller: _refreshController,
                    child: latestList.isEmpty
                        ? Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * .6,
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('no_data_found'),
                              textAlign: TextAlign.center,
                              style: appTextStyle.bigTSBasic,
                            ),
                          )
                        : GridView.builder(
                            itemCount: latestList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 1.sp,
                                    mainAxisSpacing: 1.sp,
                                    childAspectRatio:
                                        widget.isCategories ? .62.sp : .7.sp),
                            shrinkWrap: true,
                            controller: _controller,
                            itemBuilder: (BuildContext context, int index) {
                              return LatestOverviewWidget(
                                isAllProduct: true,
                                address: address,
                                token: token,
                                cart: cart,
                                infoData: latestList[index],
                                cancelToken: _cancelToken,
                              );
                            },
                          )),
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
      // page = preparePage;
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      page++;
      categoryController.getSubCategoryProducts(_cancelToken, widget.mainId,
          widget.catId, page, _languageStore.getCode(),
          childCat: widget.childCat);
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

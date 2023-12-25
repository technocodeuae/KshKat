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
import 'package:erp/ui/splash/argument/GlobalArgument.dart';
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

class AllPopularProductPage extends StatefulWidget {
  // final token;
  final UserSignInDashboardResult? userInfo;

  const AllPopularProductPage({this.userInfo});

  @override
  _AllPopularProductPageState createState() => _AllPopularProductPageState();
}

class _AllPopularProductPageState extends State<AllPopularProductPage>
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
  var arg;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // token = widget.token;
    arg = ModalRoute.of(context)!.settings.arguments as GlobalArgument;
    token = arg.token;
    widthC = DeviceUtils.getScaledWidth(context, 1);
    heightC = DeviceUtils.getScaledHeight(context, 1);
    AppBar appBar = AppBar(
      title: Container(
        color: AppColors.transparent,
        width: widthC,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
      backgroundColor: AppColors.appBarBGColor,
      automaticallyImplyLeading: false,
      brightness: Brightness.light,
      centerTitle: true,
      elevation: 0,
    );

    return Scaffold(
        appBar: appBar,
        body: SafeArea(
            child: _buildBody(
          height: heightC,
          width: widthC,
        )));
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
                ? Container(
                    width: widthC,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5.sp,
                            mainAxisSpacing: 5.sp,
                            childAspectRatio: 1.sp //size.aspectRatio * 2.5,
                            ),
                        padding: EdgeInsets.all(15.sp),
                        itemCount: 10,
                        // Important code
                        itemBuilder: (context, index) =>
                            DashboardHomeLoadingWidget(
                              width: 71.sp,
                              height: 71.sp,
                            )),
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: RefreshConfiguration(
          child: SmartRefresher(
              header: WaterDropMaterialHeader(
                backgroundColor: AppColors.purple,
                offset: _languageStore.getLanguage() == "Arabic" ? -85.h : 0.h,
              ),
              physics: BouncingScrollPhysics(),
              onRefresh: () async {
                page = 1;
                categoryController.getPopularProduct(
                    _cancelToken, limit, page, _languageStore.getCode());
                _refreshController.refreshCompleted();
              },
              key: _refresherKey,
              footer: ClassicFooter(
                loadStyle: LoadStyle.ShowWhenLoading,
              ),
              controller: _refreshController,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.sp,
                    mainAxisSpacing: 1.sp,
                    childAspectRatio: .77.sp //size.aspectRatio * 2.5,
                    ),
                physics:
                    const BouncingScrollPhysics(), //NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 4.sp),
                itemCount: popularList.length,
                shrinkWrap: true,
                controller: _controller,
                itemBuilder: (BuildContext context, int index) {
                  return LatestOverviewWidget(
                    address: address,
                    token: token,
                    cart: cart,
                    infoData: popularList[index],
                    cancelToken: _cancelToken,
                    isAllProduct: true,
                  );
                },
              )),
        )),
        VerticalPadding(
          percentage: 0.05,
        ),
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

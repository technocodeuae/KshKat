import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:erp/common/animation/animation_column_widget.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/constants/text_style.dart';
import 'package:erp/data/repo/user_management_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/home/category_model.dart';
import 'package:erp/models/user_management/sign_in_dashboard_response.dart';
import 'package:erp/state/general_state.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/stores/theme/theme_store.dart';
import 'package:erp/ui/category/pages/best_seller_page.dart';
import 'package:erp/ui/category/pages/popular_product_page.dart';
import 'package:erp/ui/category/pages/top_product_page.dart';
import 'package:erp/utils/device/app_uitls.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/utils/routes/routes.dart';
import 'package:erp/widgets/dialog/signup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../models/cart/products_cart.dart';
import '../../shimmer/dashboard_home_loading_widget.dart';
import '../controller/category_controller.dart';
import '../controller/slider_controller.dart';
import '../widget/category_overview_widget.dart';
import '../widget/latest_overview_widget.dart';
import 'category_page.dart';
import 'flash_deals_page.dart';
import 'latest_product_page.dart';

class HomePage extends StatefulWidget {
  final double width;
  final double height;
  final token;
  final UserSignInDashboardResult? userInfo;

  const HomePage(
      {required this.height,
      required this.width,
      required this.token,
      this.userInfo});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  SliderController sliderController = Get.find();
  CategoryController categoryController = Get.find();

  var _cancelToken = CancelToken();
  int limit = 25, page = 1, startAt = 0, endAt = 0, preparePage = 1;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _refresherKey = GlobalKey();
  final formKey = GlobalKey<FormState>();

  UserManagementRepository _repository = getIt<UserManagementRepository>();
  var token, address, time, timeId;
  List<Products> cart = [];
  List<String> imgList = [];
  int? num = 0;

  // //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  // There is next pages or not
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  late ScrollController _controller;
  late double widthC, heightC;

  String search = "";

  @override
  Widget build(BuildContext context) {
    super.build(context);
    token = widget.token;
    widthC = DeviceUtils.getScaledWidth(context, 1);
    heightC = DeviceUtils.getScaledHeight(context, 1);

    return Stack(
      children: [
        Container(
          color: AppColors.white,
        ),
        Scaffold(
          backgroundColor: AppColors.scaffoldBGColor,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: _buildBody(height: heightC, width: widthC),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody({required double width, required double height}) {
    return _buildMainView(height: height * 30, width: widget.width);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);

    sliderController.getSlider(_cancelToken, _languageStore.locale);
  }

  @override
  void initState() {
    super.initState();
    GeneralState.reset();

    _isFirstLoadRunning = true;
    getToken();
  }

  Future<void> getToken() async {
    token = await _repository.authToken;
    address = await _repository.address;
    setState(() {});
    // address = widget.defaultAddres;
    num = await _repository.numCart;
    cart = await _repository.cart;
    time = await _repository.time;
    timeId = await _repository.timeId;
  }

  _buildSliderWidget() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.sp),
          child: CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: MediaQuery.of(context).size.width * .9 / 120.sp,
                // enlargeCenterPage: true,
                viewportFraction: 1),
            items: imgList
                .map((item) => Container(
                      margin: EdgeInsets.all(4.0.sp),
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0.sp)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                item,
                                fit: BoxFit.cover,
                                width: 1500.0,
                                height: 136.sp,
                                // headers: {'Referer': 'http://tas-jeel.com'},
                              ),
                            ],
                          )),
                    ))
                .toList(),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 4.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
                3,
                (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.sp),
                      child: CircleAvatar(
                        radius: 4.sp,
                        backgroundColor: AppColors.textNaveColor,
                      ),
                    )),
          ),
        ),
      ],
    );
  }

  _buildMainView({required double width, required double height}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VerticalPadding(
          percentage: 0.05,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 16.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/app_logo.png",
                width: 110.sp,
              ),
              Container(
                width: 149.sp,
                decoration: BoxDecoration(
                  color:Colors.white70,// AppColors.mainContainColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(17.sp),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainContainColor,
                      spreadRadius: 0,
                      blurRadius: 3,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Container(
                  height: 45.sp,
                  color: AppColors.transparent,
                  child: InkWell(
                    onTap: () {
                      token == null
                          ? showDialog(
                              context: context,
                              builder: (context) => SignUpDialog())
                          : Navigator.of(context).pushNamed(
                              Routes.addressPage,
                            );
                    },
                    child: Row(
                      children: [
                        HorizontalPadding(
                          percentage: 0.02,
                        ),
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.black,// AppColors.textNaveColor,
                          size: 20.sp,
                        ),
                        Expanded(
                          child: Text(
                            address != null
                                ? address + address
                                : AppLocalizations.of(context)
                                    .translate('delivery_address'),
                            style: appTextStyle.smallTSBasic.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.normal,
                                overflow: TextOverflow.ellipsis),
                          ),
                          flex: 5,
                        ),
                        HorizontalPadding(
                          percentage: 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 4.sp,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.productSearchPage);
                },
                child: Container(
                  height: 38.sp,
                  width: 38.sp,
                  decoration: BoxDecoration(
                    color: AppColors.mainContainColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainContainColor,
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.search,
                    color: AppColors.textNaveColor,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(
                width: 4.sp,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 38.sp,
                  width: 38.sp,
                  decoration: BoxDecoration(
                    color: AppColors.mainContainColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mainContainColor,
                        spreadRadius: 0,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: AppColors.textNaveColor,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshConfiguration(
              child: SmartRefresher(
                  header: WaterDropMaterialHeader(
                    backgroundColor: AppColors.purple,
                    offset:
                        _languageStore.getLanguage() == "Arabic" ? -85.h : 0.h,
                  ),
                  physics: BouncingScrollPhysics(),
                  onRefresh: () async {
                    page = 1;
                    sliderController.getSlider(
                        _cancelToken, _languageStore.locale);
                    categoryController.getCategory(
                        _cancelToken, limit, page, _languageStore.getCode());
                    categoryController.getFlashDeals(
                        _cancelToken, limit, page, _languageStore.getCode());
                    categoryController.getLatestProduct(
                        _cancelToken, limit, page, _languageStore.getCode());
                    categoryController.getTopProduct(
                        _cancelToken, limit, page, _languageStore.getCode());
                    categoryController.getBestSeller(
                        _cancelToken, limit, page, _languageStore.getCode());
                    categoryController.getPopularProduct(
                        _cancelToken, limit, page, _languageStore.getCode());

                    _refreshController.refreshCompleted();
                  },
                  key: _refresherKey,
                  footer: ClassicFooter(
                    loadStyle: LoadStyle.ShowWhenLoading,
                  ),
                  controller: _refreshController,
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              VerticalPadding(
                                percentage: 0.01,
                              ),

                              GetBuilder<SliderController>(
                                  init: sliderController,
                                  builder: (state) {
                                    if (_isFirstLoadRunning &&
                                        GeneralState.isFailure) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        AppUtils.showErrorMessage(
                                            error: state.signInFailure!.error,
                                            context: context);
                                      });
                                    }

                                    if (_isFirstLoadRunning &&
                                        GeneralState.isLoading)
                                      return (!_isLoadMoreRunning)
                                          ? Container(
                                              height: 150.sp,
                                              width: widthC,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 15.sp),
                                              child: DashboardHomeLoadingWidget(
                                                width: 250.sp,
                                                height: 71.sp,
                                              )
                                              /*ListView.builder(
                                    itemCount: 10,
                                    scrollDirection: Axis.horizontal,
                                    // Important code
                                    itemBuilder: (context, index) =>
                                        DashboardHomeLoadingWidget(
                                          width: 71.sp,
                                          height: 71.sp,
                                        )),*/
                                              )
                                          : _buildSliderWidget();
                                    if (state.sliderSuccess != null &&
                                        (GeneralState.iSuccess) &&
                                        (state.sliderSuccess ==
                                            sliderController.sliderSuccess)) {
                                      for (int i = 0;
                                          i <
                                              state.sliderSuccess!.result.data!
                                                  .length;
                                          i++)
                                        imgList.add(state.sliderSuccess!.result
                                            .data![i].photo!
                                            .toString());

                                      _isFirstLoadRunning = false;
                                      _isLoadMoreRunning = false;

                                      return _buildSliderWidget();
                                    }

                                    return _buildSliderWidget();
                                  }),

                              // VerticalPadding(
                              //   percentage: 0.01,
                              // ),
                              // FadeInDown(
                              //     delay: Duration(milliseconds: 800),
                              //     duration: Duration(milliseconds: 400),
                              //     animate: true,
                              //     child: InkWell(
                              //       onTap: () {},
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
                              //                   .translate('latest_products'),
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
                              CategoryPage(
                                token: token,
                              ),
                              FlashDealsPage(
                                token: token,
                              ),
                              LatestProductPage(
                                token: token,
                              ),
                              TopProductPage(
                                token: token,
                              ),
                              FlashDealsPage(
                                token: token,
                              ),
                              BestSellerPage(
                                token: token,
                              ),
                              PopularProduct(
                                token: token,
                              ),
                              // FadeInDown(
                              //     delay: Duration(milliseconds: 800),
                              //     duration: Duration(milliseconds: 400),
                              //     animate: true,
                              //     child: InkWell(
                              //       onTap: () {},
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
                              //                   .translate('top_products'),
                              //               style: appTextStyle.bigTSBasic.copyWith(
                              //                 color: AppColors.textNaveColor,
                              //                 fontWeight: FontWeight.normal,
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     )),
                              // VerticalPadding(
                              //   percentage: 0.05,
                              // ),
                              // Flexible(
                              //   child: ConstrainedBox(
                              //       constraints:
                              //       BoxConstraints(maxHeight: width / 1.75),
                              //       child: ListView.builder(
                              //         itemCount: topList.length,
                              //         shrinkWrap: true,
                              //         scrollDirection: Axis.horizontal,
                              //         itemBuilder: (BuildContext context, int index) {
                              //           /* for (int i = 0; i < cart.length; i++) {
                              //             if (topList[index].id == cart[i].id!)
                              //               topList[index].quantity = cart[i].quantity!;
                              //           }*/
                              //           return TopOverviewWidget(
                              //             address: address,
                              //             token: token,
                              //             cart: cart,
                              //             width: 175.sp,
                              //             height: 164.sp,
                              //             infoData: topList[index],
                              //             cancelToken: _cancelToken,
                              //           );
                              //         },
                              //       )),
                              // ),
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
                              // Flexible(
                              //   child: ConstrainedBox(
                              //       constraints: BoxConstraints(maxHeight: width),
                              //       child: GridView.builder(
                              //         itemCount: categoryList.length,
                              //         shrinkWrap: true,
                              //         physics: ClampingScrollPhysics(),
                              //         padding: const EdgeInsets.only(
                              //             bottom: AppDimens.space4,
                              //             top: AppDimens.space4),
                              //         gridDelegate:
                              //         SliverGridDelegateWithFixedCrossAxisCount(
                              //           crossAxisCount: 3,
                              //           crossAxisSpacing: AppDimens.space10,
                              //           mainAxisSpacing: AppDimens.space10,
                              //           childAspectRatio: 0.8,
                              //         ),
                              //         itemBuilder: (BuildContext context, int index) {
                              //           return Row(
                              //             children: [
                              //               CategoryOverviewWidget(
                              //                 address: address,
                              //                 token: token,
                              //                 index: index,
                              //                 cart: cart,
                              //                 height: heightC,
                              //                 data: categoryList,
                              //                 width: widget.width,
                              //                 infoData: categoryList[index],
                              //                 cancelToken: _cancelToken,
                              //               ),
                              //             ],
                              //           );
                              //         },
                              //       )),
                              // ),
                              // VerticalPadding(
                              //   percentage: 0.05,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))),
        )
      ],
    );
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => false;
}

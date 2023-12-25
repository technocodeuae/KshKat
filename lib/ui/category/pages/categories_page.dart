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
import 'package:erp/ui/category/pages/sub_category_product_page.dart';
import 'package:erp/ui/category/widget/sub_categories_widget.dart';
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
import '../argument/sub_product_argument.dart';
import '../controller/category_controller.dart';
import '../widget/category_overview_widget.dart';
import '../widget/latest_overview_widget.dart';

class CategoriesPage extends StatefulWidget {
  // final token;
  final UserSignInDashboardResult? userInfo;

  const CategoriesPage({this.userInfo});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  CategoryController categoryController = Get.find();

  var _cancelToken = CancelToken();
  int limit = 25, page = 1, startAt = 0, endAt = 0, preparePage = 1;
  late List<CategoriesData> categoriesList = <CategoriesData>[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  // GlobalKey _refresherKey = GlobalKey();
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
  bool _isTopProduct = true;
  late ScrollController _controller;
  late double widthC, heightC;
  SubArgument? subArgSelectedCategory;

  List<CategoriesData> firstList = [];
  List<CategoriesData> secondList = [];
  String search = "";
  bool first = true;
  var arg;
  int? selectedCategory;

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
                              .translate('top_products'),
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
            child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: _buildBody(
                height: heightC,
                width: widthC,
              ),
            ),
            GetBuilder<CategoryController>(builder: (controller) {
              print(
                  "ggggggggggggggggggg${selectedCategory}gggggggggggggggggg${controller.categorySuccess!.result.data!.first.id}");
              return _isTopProduct == true && GeneralState.isLoading
                  ? Container()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: SubCategoriesWidget(
                          subArg: SubArgument(
                              controller
                                  .categorySuccess!.result.data!.first.name,
                              selectedCategory ??
                                  controller
                                      .categorySuccess!.result.data!.first.id,
                              address,
                              token)
                          // subArgSelectedCategory,
                          ),
                    );
            }),
          ],
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
                    child: ListView.builder(
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
          if (state.topProductSuccess != null &&
              _isTopProduct == true &&
              (GeneralState.iSuccess) &&
              (state.topProductSuccess ==
                  categoryController.topProductSuccess)) {
            if (page == 1) {
              categoriesList = state.categorySuccess!.result.data!;
              if (state.categorySuccess!.result.data!.isNotEmpty)
                subArgSelectedCategory = SubArgument(
                    state.categorySuccess!.result.data!.first.name,
                    state.categorySuccess!.result.data!.first.id,
                    address,
                    token);
            } else {
              final List<CategoriesData> copyOfList = List.from(categoriesList);

              for (var item in copyOfList) {
                if (!categoriesList.contains(item)) {
                  categoriesList.add(item);
                }
              }
              // categoriesList.addAll(state.categorySuccess!.result.data!);
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
            child: ListView.builder(
          physics:
              const BouncingScrollPhysics(), //NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 4.sp),
          itemCount: categoriesList.length,
          shrinkWrap: true,
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            final category = categoriesList[index];

            return CategoryOverviewWidget(
              key: UniqueKey(),
              onTap: () {
                selectedCategory = category.id;
                categoryController.changeParentCategory(true);
                categoryController.getSubCategory(
                    _cancelToken, category.id, page, _languageStore.getCode());
              },
              isCatrgoriesPage: true,
              address: address,
              token: token,
              index: index,
              cart: cart,
              data: categoriesList,
              infoData: category,
              cancelToken: _cancelToken,
            );
          },
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
      categoryController.getTopProduct(
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

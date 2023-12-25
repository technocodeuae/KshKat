import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_dimens.dart';
import '../../../constants/app_text_size.dart';
import '../../../constants/colors.dart';
import '../../../constants/text_style.dart';
import '../../../data/repo/user_management_repository.dart';
import '../../../di/components/service_locator.dart';
import '../../../models/cart/products_cart.dart';
import '../../../models/home/category_model.dart';
import '../../../state/general_state.dart';
import '../../../stores/language/language_store.dart';
import '../../../stores/theme/theme_store.dart';
import '../../../utils/device/app_uitls.dart';
import '../../../utils/device/device_utils.dart';
import '../../../utils/locale/app_localization.dart';
import '../../shimmer/dashboard_home_loading_widget.dart';
import '../argument/sub_product_argument.dart';
import '../controller/category_controller.dart';
import '../widget/sub_category_products_widget.dart';

class SubCategoryProductPage extends StatefulWidget {
  const SubCategoryProductPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SubCategoryProductPage> createState() => _SubCategoryProductPageState();
}

class _SubCategoryProductPageState extends State<SubCategoryProductPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  CategoryController categoryController = Get.find();

  var _cancelToken = CancelToken();
  int limit = 25, page = 1, startAt = 0, endAt = 0, preparePage = 1;
  late List<LatestProductData> latestList = <LatestProductData>[];
  late List<TopProductData> topList = <TopProductData>[];
  late List<CategoriesData> categoryList = <CategoriesData>[];
  List<ChildsCategory> selectedSubChildsList = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _refresherKey = GlobalKey();
  final formKey = GlobalKey<FormState>();

  int selectIndex = -1;
  int? selectedChildId;

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

  var arg;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    token = arg?.token;
    widthC = DeviceUtils.getScaledWidth(context, 1);
    heightC = DeviceUtils.getScaledHeight(context, 1);

    return _buildBody(height: heightC, width: widthC);
  }

  Widget _buildBody({required double width, required double height}) {
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
                Center(
                  child: Text(
                    arg.name,
                    style: appTextStyle.subBigTSBasicBold.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: AppTextSize.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
      ),
      backgroundColor: AppColors.appBarBGColor,
      automaticallyImplyLeading: false,
      brightness: Brightness.light,
      elevation: 0,
    );

    return Stack(
      children: [
        Container(
          color: AppColors.white,
        ),
        Scaffold(
          backgroundColor: AppColors.scaffoldBGColor,
          appBar: appBar,
          body: Column(
            children: [
              GetBuilder<CategoryController>(
                  init: categoryController,
                  builder: (state) {
                    if (_isCategory && GeneralState.isFailure) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        AppUtils.showErrorMessage(
                            error: state.signInFailure!.error,
                            context: context);
                      });
                    }

                    if (_isCategory && GeneralState.isLoading)
                      return (!_isLoadMoreRunning)
                          ? Container(
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
                            )
                          : _buildMainView(
                              height: heightC,
                              width: widthC,
                              // selectIndex: selectIndex
                            );
                    if (state.subCategorySuccess != null &&
                        _isCategory &&
                        GeneralState.iSuccess &&
                        (state.subCategorySuccess ==
                            categoryController.subCategorySuccess)) {
                      if (page == 1) {
                        if ((selectIndex == -1 && selectedChildId == null)) {
                          categoryList =
                              state.subCategorySuccess!.result.data!.subs!;
                          selectedSubChildsList = state.subCategorySuccess!
                                  .result.data!.subs!.first.child ??
                              [];
                          selectIndex = categoryList[0].id!;
                          selectedChildId = selectedSubChildsList.isNotEmpty
                              ? selectedSubChildsList.first.id
                              : null;
                          categoryController.getSubCategoryProducts(
                              _cancelToken,
                              arg.mainId,
                              selectIndex,
                              page,
                              _languageStore.getCode(),
                              childCat: selectedChildId);
                          // WidgetsBinding.instance.addPostFrameCallback((_) {
                          //   categoryController.changeParentCategory(false);
                          // });
                        }

                        /* categoryList =
                            state.subCategorySuccess!.result.data!.subs!;
                        selectedSubChildsList = state.subCategorySuccess!.result
                                .data!.subs!.first.child ??
                            [];
                        firstList =
                            categoryList.sublist(0, categoryList.length ~/ 2);
                        secondList =
                            categoryList.sublist(categoryList.length ~/ 2);
                        if (categoryList.length > 0 && selectIndex == -1)
                          selectIndex = categoryList[0].id!;
                        if (selectedSubChildsList.isNotEmpty &&
                            selectedChildId == null) {
                          selectedChildId = selectedSubChildsList.first.id;
                        }*/

                        // topList = state.categorySuccess.result.top_product!;
                        // latestList = state.categorySuccess.result.latest_product!;
                      } else {
                        categoryList.addAll(
                            state.subCategorySuccess!.result.data!.subs!);

                        firstList =
                            categoryList.sublist(0, categoryList.length ~/ 2);
                        secondList =
                            categoryList.sublist(categoryList.length ~/ 2);
                        // topList.addAll(state.categorySuccess.result.top_product!);
                        // latestList.addAll(state.categorySuccess.result.latest_product!);
                      }
                      _isFirstLoadRunning = false;
                      _isLoadMoreRunning = false;

                      var h = topList.length +
                          latestList.length +
                          categoryList.length;

                      return _buildMainView(
                        height: h * 30,
                        width: widthC,
                        // selectIndex: selectIndex
                      );
                    }

                    return _buildMainView(
                      height: heightC,
                      width: widthC,
                      // selectIndex: selectIndex
                    );
                  }),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores

    arg = ModalRoute.of(context)!.settings.arguments as SubArgument;

    _languageStore = Provider.of<LanguageStore>(context, listen: false);
    _themeStore = Provider.of<ThemeStore>(context, listen: false);
    if (_isFirstLoadRunning == true)
      categoryController.getSubCategory(
          _cancelToken, arg.mainId, page, _languageStore.getCode());
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

  Widget _buildMainView({
    required double width,
    required double height,
    // required int selectIndex
  }) {
    print("sssssssssssssssssssssssssss $selectIndex");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 80.sp,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.all(AppDimens.space12),
            shrinkWrap: true,
            itemCount: categoryList.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 16.sp,
              );
            },
            itemBuilder: (context, index) {
              final category = categoryList[index];

              return Row(
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          selectIndex = category.id!;
                          // category.child!.forEach((element) {
                          //   print(
                          //       "gwwwwwww${element.name}wwwwww 88 ${element.photo}");
                          // });

                          selectedSubChildsList = category.child ?? [];
                          if (selectedSubChildsList.isNotEmpty) {
                            selectedChildId = selectedSubChildsList.first.id;
                          }
                          categoryController.getSubCategoryProducts(
                              _cancelToken,
                              arg.mainId,
                              selectIndex,
                              page,
                              _languageStore.getCode(),
                              childCat: selectedChildId);

                          categoryController.setSub(selectIndex);
                        });
                      },
                      child: Container(
                        height: 71.sp,
                        width: 71.sp,
                        padding: EdgeInsets.all(4.sp),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectIndex == category.id
                                ? AppColors.indicatorBGColor.withOpacity(0.21)
                                : AppColors.mainContainColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30.sp,
                              height: 30.sp,
                              child: category.photo.toString().contains('svg')
                                  ? SvgPicture.network(
                                      category.photo.toString(),
                                      fit: BoxFit.cover,
                                      width: 30.sp,
                                      height: 30.sp,
                                    )
                                  : Image.network(
                                      category.photo.toString(),
                                      fit: BoxFit.cover,
                                      width: 30.sp,
                                      height: 30.sp,
                                    ),
                            ),
                            SizedBox(
                              height: 4.sp,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                category.name!,
                                overflow: TextOverflow.ellipsis,
                                style: appTextStyle.sub2MinTSBasic.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                                // maxLines: 1,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              );
            },
          ),
        ),
        SizedBox(
          height: 80.sp,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.all(AppDimens.space12),
            shrinkWrap: true,
            itemCount: selectedSubChildsList.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 16.sp,
              );
            },
            itemBuilder: (context, index) {
              final childSub = selectedSubChildsList[index];

              return Row(
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          selectedChildId = selectedChildId == childSub.id!
                              ? null
                              : childSub.id!;
                          _isCategory = false;
                          categoryController.getSubCategoryProducts(
                              _cancelToken,
                              arg.mainId,
                              selectIndex,
                              page,
                              _languageStore.getCode(),
                              childCat: selectedChildId);
                        });
                      },
                      child: Container(
                        height: 71.sp,
                        width: 71.sp,
                        padding: EdgeInsets.all(4.sp),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: selectedChildId == childSub.id
                                ? AppColors.indicatorBGColor.withOpacity(0.21)
                                : AppColors.mainContainColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 30.sp,
                              height: 30.sp,
                              child: childSub.photo.toString().contains('svg')
                                  ? SvgPicture.network(
                                      childSub.photo.toString(),
                                      fit: BoxFit.cover,
                                      width: 30.sp,
                                      height: 30.sp,
                                    )
                                  : Image.network(
                                      childSub.photo.toString(),
                                      fit: BoxFit.cover,
                                      width: 30.sp,
                                      height: 30.sp,
                                    ),
                            ),
                            SizedBox(
                              height: 4.sp,
                            ),
                            Text(
                              childSub.name!,
                              style: appTextStyle.sub2MinTSBasic.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )),
                ],
              );
            },
          ),
        ),
        // if (categoryList.length > 0)
        selectedSubChildsList.isEmpty
            ? Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .6,
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context).translate('no_data_found'),
                  textAlign: TextAlign.center,
                  style: appTextStyle.bigTSBasic,
                ),
              )
            : SubCategoryProductsWidget(
                token: arg.token,
                mainId: arg.mainId,
                catId: selectIndex,
                childCat: selectedChildId,
              ),
      ],
    );

    /* Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                    FadeInUpBig(
                        delay: Duration(milliseconds: 500),
                        duration: Duration(milliseconds: 300),
                        animate: true,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                selectIndex = firstList[index]!.id!;

                                  categoryController.setSub(
                                      selectIndex
                                  );
                              });
                            },
                            child: Container(
                              height: 71.sp,
                              width: 71.sp,
                              padding: EdgeInsets.all(4.sp),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectIndex ==
                                          firstList[index]!.id
                                      ? AppColors.indicatorBGColor
                                          .withOpacity(0.21)
                                      : AppColors.mainContainColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30.sp,
                                    height: 30.sp,
                                    child: Image.network(
                                      firstList[index].photo.toString()!,
                                      fit: BoxFit.cover,
                                      width: 30.sp,
                                      height: 30.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.sp,
                                  ),
                                  Text(
                                    firstList[index].name!,
                                    style: appTextStyle.sub2MinTSBasic.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ))),
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
              itemCount: secondList.length,
              shrinkWrap: true,
              controller: _controller,
              scrollDirection: Axis.horizontal,
              physics: ClampingScrollPhysics(),
              padding: const EdgeInsets.only(
                  bottom: AppDimens.space4, top: AppDimens.space4),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    FadeInUpBig(
                        delay: Duration(milliseconds: 500),
                        duration: Duration(milliseconds: 300),
                        animate: true,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                print(selectIndex.toString());
                                selectIndex = secondList[index]!.id!;


                                categoryController.setSub(selectIndex);
                              });
                            },
                            child: Container(
                              height: 71.sp,
                              width: 71.sp,
                              padding: EdgeInsets.all(4.sp),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: selectIndex ==
                                          secondList[index]!.id
                                      ? AppColors.indicatorBGColor
                                          .withOpacity(0.21)
                                      : AppColors.mainContainColor),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30.sp,
                                    height: 30.sp,
                                    child: Image.network(
                                      secondList[index].photo.toString(),
                                      fit: BoxFit.cover,
                                      width: 30.sp,
                                      height: 30.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.sp,
                                  ),
                                  Text(
                                    secondList[index].name!,
                                    style: appTextStyle.sub2MinTSBasic.copyWith(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ))),
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 16.sp,
                );
              },
            )),
        categoryList.length > 8
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 4.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      2,
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
        if (categoryList.length > 0)
          SubCategoryProductsWidget(
            token: arg.token,
            mainId: arg.mainId,
            catId: selectIndex,
          ),
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
      categoryController.getSubCategory(
          _cancelToken, arg.mainId, page, _languageStore.getCode());
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

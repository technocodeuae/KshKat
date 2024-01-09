import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/constants/text_style.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/stores/theme/theme_store.dart';
import 'package:erp/ui/cart/controller/cart_controller.dart';
import 'package:erp/utils/device/app_uitls.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/dio/errors/cancel_error.dart';
import 'package:erp/utils/dio/errors/connection_error.dart';
import 'package:erp/utils/dio/errors/http_error.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../common/animation/animation_column_widget.dart';
import '../../../../../data/repo/user_management_repository.dart';
import '../../../../../di/components/service_locator.dart';
import '../../../../../models/home/product_details_model.dart';
import '../../../../../state/general_state.dart';
import '../../../../../widgets/dialog/address_dialog.dart';
import '../../../../../widgets/dialog/confirm_dialog.dart';
import '../../../../../widgets/dialog/general_dialog.dart';
import '../../../../account_icon.dart';
import '../../../../shimmer/dashboard_home_loading_widget.dart';
import '../../../../user_management/widgets/button_user_management_widget.dart';
import '../../../controller/products_controller.dart';
import '../argument/ProductDetailsArgument.dart';
import '../controller/product_details_controller.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage();

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  CartController cartController = Get.find();

  var _cancelToken = CancelToken();

  ProductDetailsController productDetailsController = Get.find();
  ProductsController productsController = Get.find();

  ProductDetailsData data = new ProductDetailsData();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _refresherKey = GlobalKey();
  late int index;
  late String? address, token, addressId, attribute_id = "";
  final formKey = GlobalKey<FormState>();
  int quantity = 1;

  bool showFilter = false;
  bool showAdvancedFilter = false;
  bool firstLoad = false;
  int selectedGender = 0;
  List<int> listIds = [];
  List<String> listMainIds = [];
  List<String> imgList = [];
  List<Map<String, dynamic>> selectedAttribut = [], defaultAttribut = [];
  double total = 0;
  UserManagementRepository _repository = getIt<UserManagementRepository>();

  Color _selectedColor = AppColors.mainContainColor; // Default color
  late TabController _tabController;

  /*late var controller = GroupButtonController(
    selectedIndexes: listIds,
  );*/

  // //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  late double widthC, heightC;
  int addedPrice = 0;

  var arg;

  bool isLoading = true;
  final PageController _pageViewController =
      PageController(initialPage: 0); // set the initial page you want to show
  int _activePage = 0;
  String ids = '';
  int selectTabBar = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate('my_products'),
                  style: appTextStyle.subBigTSBasicBold.copyWith(
                      color: AppColors.darkGrayColor,
                      fontWeight: FontWeight.bold,
                      fontSize: AppTextSize.normal),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: AppColors.appBarBGColor,
      automaticallyImplyLeading: false,
      // brightness: Brightness.light,
      elevation: 0,
    );

    // "      " +
    //     NumberFormat.currency(
    //         name: data.curr?.sign ?? "",
    //         customPattern: '\u00a4 ###,###')
    //         .format(total),
    return Stack(
      children: [
        Container(
          color: AppColors.white,
        ),
        Scaffold(
          appBar: appBar,
          backgroundColor: AppColors.scaffoldBGColor,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VerticalPadding(
                  percentage: 0.02,
                ),
                Expanded(
                  child: _buildBody(height: heightC, width: widthC),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0.sp, horizontal: 32.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.cartPage);
                  },
                  child: Container(
                    height: 44.sp,
                    width: 55.sp,
                    color: AppColors.transparent,
                    child: Stack(
                      children: [
                        Container(
                          height: 44.sp,
                          width: 50.sp,
                          decoration: BoxDecoration(
                            color: AppColors.mainContainColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.sp),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: AppColors.secondaryContainColor,
                              size: 30.sp,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 22.sp,
                            width: 22.sp,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryContainColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                            child: Center(
                              child: GetBuilder<CartController>(
                                builder: (controller) => isLoading == true &&
                                        GeneralState.isLoading
                                    ? Container()
                                    : Text(
                                        controller.cartAllSuccess.result.items
                                                ?.length
                                                .toString() ??
                                            '0',
                                        // data.quantity == null
                                        //     ? "0"
                                        //     : data.quantity.toString(),
                                        style: appTextStyle.minTSBasic
                                            .copyWith(color: AppColors.white),
                                      ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ButtonUserManagementWidget(
                    child: Icon(Icons.add),
                    onPressed: () {
                      quantity++;
                      setState(() {});
                    },
                    backgroundColor: data.quantity != null && data.quantity! > 0
                        ? AppColors.secondaryContainColor
                        : AppColors.buttonColor,
                    height: 48.sp,
                    borderRadius: 16.sp,
                    borderColor: AppColors.borderColor,
                  ),
                ),
                SizedBox(
                  width: 8.sp,
                ),
                Expanded(
                  flex: 3,
                  child: GetBuilder<ProductDetailsController>(
                    builder: (controller) => ButtonUserManagementWidget(
                      // width: 230.sp,
                      child: controller.isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "${AppLocalizations.of(context).translate("add_to_cart")} ( $quantity )",
                              style: appTextStyle.middleTSBasic
                                  .copyWith(color: AppColors.black),
                            ),
                      backgroundColor:
                          data.quantity != null && data.quantity! > 0
                              ? AppColors.secondaryContainColor
                              : AppColors.buttonColor,
                      height: 48.sp,
                      borderRadius: 16.sp,
                      borderColor: AppColors.borderColor,
                      onPressed: () async {
                        // if (address == null)
                        //   showDialog(
                        //       context: context,
                        //       builder: (context) => AddressDialog());
                        // else
                        // if (quantity > 0) {
                        //(data.quantity ?? 0) > 0

                        attribute_id =
                            data.has_attributes! ? attribute_id : null;

                        print(defaultAttribut);
                        print(
                            "1212121ddddddddddddddddddddddddd ${selectedAttribut}");

                        if (selectedAttribut.length > 2) {
                          for (int j = 0; j < defaultAttribut.length; j++) {
                            if (selectedAttribut.contains(defaultAttribut[j])) {
                              selectedAttribut.remove(defaultAttribut[j]);
                              if (selectedAttribut.length == 2) {
                                break;
                              }
                            }
                          }
                        }
                        print("ddddddddddddddddddddddddd ${selectedAttribut}");

                        controller
                            .saveCart(
                                _cancelToken,
                                // attribute_id,
                                selectedAttribut,
                                defaultAttribut,
                                addressId,
                                quantity
                                    .toString(), //data.quantity!.toString(),
                                data.id!.toString(),
                                _languageStore.getCode())
                            .whenComplete(() {
                          quantity = 1;
                          selectedAttribut = [];
                          // selectedAttribut = defaultAttribut;
                          cartController.getCart(
                              _cancelToken, 25, 1, _languageStore.getCode());

                          if (controller.cartSuccess.result != null &&
                              controller.cartSuccess.result!.data != null) {
                            AppUtils.showToast(
                                msg: AppLocalizations.of(context)
                                    .translate('success_add'),
                                context: context);
                            controller.cartSuccess.result!.data = null;
                          } else if (controller.cartSuccess.result != null &&
                              controller.cartSuccess.result!.data == null &&
                              controller.cartSuccess.result!.msg != null) {
                            AppUtils.showToast(
                                msg: controller.cartSuccess.result!.msg!,
                                context: context);
                            controller.cartSuccess.result!.msg = null;
                          }

                          setState(() {});
                        });

                        // } else {
                        //   showDialog(
                        //       context: context,
                        //       builder: (context) => GeneralDialog(
                        //             title: AppLocalizations.of(context)
                        //                 .translate('alert'),
                        //             message: AppLocalizations.of(context)
                        //                 .translate('choose_at_least_item'),
                        //           ));
                        // }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.sp,
                ),
                Expanded(
                  child: ButtonUserManagementWidget(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 14.sp),
                      child: Icon(
                        Icons.minimize,
                      ),
                    ),
                    onPressed: () {
                      if (quantity > 1) {
                        quantity--;
                        setState(() {});
                      }
                    },
                    backgroundColor: data.quantity != null && data.quantity! > 0
                        ? AppColors.secondaryContainColor
                        : AppColors.buttonColor,
                    height: 48.sp,
                    borderRadius: 16.sp,
                    borderColor: AppColors.borderColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody({required double width, required double height}) {
    return GetBuilder<ProductDetailsController>(builder: (state) {
      if (GeneralState.isFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!(state.productFailure.error == HttpError ||
              state.productFailure.error == ConnectionError ||
              state.productFailure.error == CancelError))
            AppUtils.showErrorMessage(
                error: state.productFailure.error, context: context);
        });
      }

      if (isLoading == true && GeneralState.isLoading)
        return ListView.builder(
            itemCount: 10,
            // Important code
            itemBuilder: (context, index) => DashboardHomeLoadingWidget(
                  width: width * 0.83,
                  height: height,
                ));
      if (GeneralState.iSuccess) {
        isLoading = false;
        if (state.productSuccess.result.product_data != null)
          data = state.productSuccess.result.product_data!;
        listMainIds.clear();
        listIds.clear();
        for (int i = 0; i < data.attributes_price!.length; i++) {
          listMainIds.add(data.attributes_price![i].id.toString()!);
        }
        List<int> ind = [];
        bool isCheck = false;
        for (int i = 0; i < data.attributes!.length; i++) {
          isCheck = false;

          for (int j = 0; j < listMainIds.length; j++) {
            List<String> list = listMainIds[j].split("_");
            for (int k = 0; k < data.attributes![i].options!.length; k++) {
              for (int z = 0; z < list.length; z++) {
                if (list[z] ==
                    (data.attributes![i].options![k].id.toString())) {
                  ind.add(k);
                  isCheck = true;
                  break;
                }
              }

              if (isCheck) break;
            }

            if (isCheck) break;
          }
          listIds = ind;
        }
        // if (state.cartSuccess.result != null &&
        //     state.cartSuccess.result!.data != null) {
        //   AppUtils.showToast(
        //       msg: AppLocalizations.of(context).translate('success_add'),
        //       context: context);
        //   state.cartSuccess.result!.data = null;
        // } else if (state.cartSuccess.result != null &&
        //     state.cartSuccess.result!.data == null &&
        //     state.cartSuccess.result!.msg != null) {
        //   AppUtils.showToast(
        //       msg: state.cartSuccess.result!.msg!, context: context);
        //   state.cartSuccess.result!.msg = null;
        // }
        return _buildMainView(height: height, width: width, infoData: data);
        GeneralState.reset();
      }

      return _buildMainView(height: height, width: width, infoData: data);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageStore = Provider.of<LanguageStore>(context);

    arg = ModalRoute.of(context)!.settings.arguments as ProductDetailsArgument;
    token = arg.token;
    address = arg.address;
    initData(arg.id);
  }

  @override
  void initState() {
    super.initState();
    GeneralState.reset();
    _tabController = TabController(length: 2, vsync: this);

    getCart();
  }

  void initData(int id) {
    cartController.getCart(_cancelToken, 25, 1, _languageStore.getCode());
    productDetailsController.getProductDetails(
        _cancelToken, id, _languageStore.getCode());
  }

  _buildMainView(
      {required double width,
      required double height,
      required ProductDetailsData infoData}) {
    return infoData.id != null
        ? SingleChildScrollView(
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
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: width,
                            height: 250.sp,
                            child: PageView.builder(
                                controller: _pageViewController,
                                onPageChanged: (int index) {
                                  setState(() {
                                    _activePage = index;
                                  });
                                },
                                itemCount: infoData.galleries?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 214.sp,
                                    width: width,
                                    child: Image.network(
                                      infoData.galleries![index].toString(),
                                      fit: BoxFit.cover,
                                      width: width,
                                      height: 250.sp,
                                      // color: Colors.black12.withOpacity(0),
                                      colorBlendMode: BlendMode.modulate,
                                    ),
                                  );
                                }),
                          ),

                          // Image.network(
                          //   infoData.photo!,
                          //   fit: BoxFit.cover,
                          //   width: width,
                          //   height: 250.sp,
                          //   colorBlendMode: BlendMode.modulate,
                          // ),

                          // if (!infoData.coming_soon!)
                          //   new Positioned(
                          //       bottom: 0,
                          //       right: 0,
                          //       child: Padding(
                          //         padding: const EdgeInsets.only(
                          //             right: AppDimens.space6,
                          //             bottom: AppDimens.space6),
                          //         child: Row(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.end,
                          //           mainAxisSize: MainAxisSize.max,
                          //           mainAxisAlignment: MainAxisAlignment.end,
                          //           children: <Widget>[
                          //             Container(
                          //               height: 25.sp,
                          //               width: 35.sp,
                          //               padding: EdgeInsets.all(3),
                          //               decoration: BoxDecoration(
                          //                 color: AppColors.white,
                          //                 borderRadius: BorderRadius.all(
                          //                     Radius.circular(5)),
                          //                 border: Border.all(
                          //                   width: 1.0,
                          //                   color: AppColors.white,
                          //                 ),
                          //                 boxShadow: [
                          //                   BoxShadow(
                          //                     color: Colors.grey
                          //                         .withOpacity(0.2),
                          //                     spreadRadius: 2,
                          //                     blurRadius: 7,
                          //                     offset: Offset(0,
                          //                         3), // changes position of shadow
                          //                   ),
                          //                 ],
                          //               ),
                          //               child: Row(
                          //                 children: [
                          //                   if (infoData.quantity != null &&
                          //                       infoData.quantity! > 0)
                          //                     InkWell(
                          //                         onTap: () {
                          //                           if (token == null)
                          //                             showDialog(
                          //                                 context: context,
                          //                                 builder: (context) =>
                          //                                     SignUpDialog());
                          //                           else if (address == null)
                          //                             showDialog(
                          //                                 context: context,
                          //                                 builder: (context) =>
                          //                                     AddressDialog());
                          //                           else
                          //                             minus();
                          //                         },
                          //                         child: Icon(
                          //                           Icons.remove,
                          //                           color:
                          //                               AppColors.mainColor,
                          //                           size: 25,
                          //                         )),
                          //                   if (infoData.quantity != null &&
                          //                       infoData.quantity! > 0)
                          //                     Container(
                          //                       margin: EdgeInsets.symmetric(
                          //                           horizontal: 3),
                          //                       padding: EdgeInsets.symmetric(
                          //                           horizontal: 3,
                          //                           vertical: 2),
                          //                       decoration: BoxDecoration(
                          //                           borderRadius:
                          //                               BorderRadius.circular(
                          //                                   3),
                          //                           color: Colors.white),
                          //                       child: Text(
                          //                         infoData.quantity!
                          //                             .toString(),
                          //                         style: TextStyle(
                          //                             color: Colors.black,
                          //                             fontSize: 16),
                          //                       ),
                          //                     ),
                          //                   InkWell(
                          //                       onTap: () {
                          //                         if (token == null)
                          //                           showDialog(
                          //                               context: context,
                          //                               builder: (context) =>
                          //                                   SignUpDialog());
                          //                         else if (address == null)
                          //                           showDialog(
                          //                               context: context,
                          //                               builder: (context) =>
                          //                                   AddressDialog());
                          //                         else
                          //                           add();
                          //                       },
                          //                       child: Icon(
                          //                         Icons.add,
                          //                         color: AppColors.mainColor,
                          //                         size: 25,
                          //                       )),
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       )),
                          Positioned(
                            top: 10.sp,
                            right: 10.sp,
                            child: Container(
                              color: Colors.black12.withOpacity(0.03),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (infoData.is_Fav!) {
                                        productsController.deleteFav(
                                            _cancelToken, infoData.id!);
                                        setState(() {
                                          infoData.is_Fav = false;
                                        });
                                      } else {
                                        productsController.addFav(
                                            _cancelToken, infoData.id!);
                                        setState(() {
                                          infoData.is_Fav = true;
                                        });
                                      }
                                    },
                                    child: Container(
                                      //    height: 20,
                                      child: Icon(
                                        infoData.is_Fav!
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: AppColors.mainRed,
                                        size: 21.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.sp,
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.share_rounded,
                                      color: AppColors.black,
                                      size: 21.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                              infoData.galleries!.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: InkWell(
                                      onTap: () {
                                        _pageViewController.animateToPage(index,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeIn);
                                      },
                                      child: CircleAvatar(
                                        radius: 5,
                                        backgroundColor: _activePage == index
                                            ? AppColors.secondaryContainColor
                                            : Colors.black12,
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8.sp,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      infoData.name!,
                                      style:
                                          appTextStyle.normalTSBasic.copyWith(
                                        color: AppColors.darkGrayColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            Text(
                              infoData.category_name.toString()!,
                              style: appTextStyle.bigTSBasic.copyWith(
                                color: AppColors.textMainColor,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            infoData.is_discount != null &&
                                    infoData.is_discount != false
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GetBuilder<CartController>(
                                        builder: (controller) => Text(
                                          (infoData.curr?.sign ?? "") +
                                              " " +
                                              (infoData.price +
                                                      controller.addedPrice)
                                                  .toString(),
                                          style:
                                              appTextStyle.bigTSBasic.copyWith(
                                            color: AppColors.textMainColor,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.sp,
                                      ),
                                      Text(
                                        (infoData.curr?.sign ?? "") +
                                            " " +
                                            infoData.previous_price.toString(),
                                        style: appTextStyle.bigTSBasic.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.normal,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        width: 8.sp,
                                      ),
                                      Container(
                                        color: AppColors.indicatorBGColor
                                            .withOpacity(0.21),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(8.sp),
                                        child: Text(
                                          (infoData.percent_discount)
                                                  .toString() +
                                              "%",
                                          style: appTextStyle.smallTSBasic
                                              .copyWith(
                                            color: AppColors.mainRed,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.sp,
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.center,
                                      //   children: [

                                      Column(
                                        children: [
                                          Container(
                                            child: RatingBarIndicator(
                                              rating: infoData.averageRating
                                                      .toDouble() ??
                                                  0,
                                              itemCount: 5,
                                              itemSize: 13.sp,
                                              unratedColor:
                                                  AppColors.darkGrayColor,
                                              direction: Axis.horizontal,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                size: 13.sp,
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            " " +
                                                infoData.averageRating
                                                    .toDouble()
                                                    .toString() +
                                                " " +
                                                AppLocalizations.of(context)
                                                    .translate("reviews"),
                                            style: appTextStyle.midSmallTSBasic
                                                .copyWith(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),

                                      //   ],
                                      // ),
                                    ],
                                  )
                                : Text(
                                    (infoData.curr?.sign ?? "") +
                                        " " +
                                        infoData.price.toString()!,
                                    style: appTextStyle.bigTSBasic.copyWith(
                                      color: AppColors.textMainColor,
                                      fontWeight: FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                            ListView.builder(
                              itemCount: infoData.attributes!.length,
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                if (selectedAttribut.isEmpty) {
                                  for (int n = 0;
                                      n <
                                          infoData.attributes![index].options!
                                              .length;
                                      n++) {
                                    if (infoData.attributes![index].options![n]
                                        .is_default!) {
                                      print("ddddddddddddd444444444444444444");

                                      selectedAttribut.add({
                                        'id': infoData.attributes![index].id,
                                        'attribute_id': infoData
                                            .attributes![index].options![n].id,
                                        'attribute_value': infoData
                                            .attributes![index]
                                            .options![n]
                                            .name,
                                        'is_default': infoData
                                            .attributes![index]
                                            .options![n]
                                            .is_default
                                      });
                                    }
                                  }
                                  for (int i = 0;
                                      i < selectedAttribut.length;
                                      i++) {
                                    if (selectedAttribut.length == 1) {
                                      ids = selectedAttribut[i]['attribute_id']
                                          .toString();
                                    } else if (i ==
                                        selectedAttribut.length - 1) {
                                      ids = ids +
                                          selectedAttribut[i]['attribute_id']
                                              .toString();
                                    } else {
                                      ids = selectedAttribut[i]['attribute_id']
                                              .toString() +
                                          ',' +
                                          ids;
                                    }
                                  }
                                  for (int g = 0;
                                      g < selectedAttribut.length;
                                      g++) {
                                    if (!defaultAttribut
                                        .contains(selectedAttribut[g])) {
                                      defaultAttribut.add(selectedAttribut[g]);
                                    }
                                  }
                                } else {
                                  for (int i = 0;
                                      i < selectedAttribut.length;
                                      i++) {
                                    print("object");
                                    if (selectedAttribut[i]['id'] ==
                                        infoData.attributes![index].id) {
                                      break;
                                    } else {
                                      for (int n = 0;
                                          n <
                                              infoData.attributes![index]
                                                  .options!.length;
                                          n++) {
                                        if (infoData.attributes![index]
                                            .options![n].is_default!) {
                                          selectedAttribut.add({
                                            'id':
                                                infoData.attributes![index].id,
                                            'attribute_id': infoData
                                                .attributes![index]
                                                .options![n]
                                                .id,
                                            'attribute_value': infoData
                                                .attributes![index]
                                                .options![n]
                                                .name,
                                            'is_default': infoData
                                                .attributes![index]
                                                .options![n]
                                                .is_default
                                          });
                                        }
                                      }
                                    }
                                  }
                                  for (int i = 0;
                                      i < selectedAttribut.length;
                                      i++) {
                                    if (selectedAttribut.length == 1) {
                                      ids = selectedAttribut[i]['attribute_id']
                                          .toString();
                                    } else if (i ==
                                        selectedAttribut.length - 1) {
                                      ids = ids +
                                          selectedAttribut[i]['attribute_id']
                                              .toString();
                                    } else {
                                      ids = selectedAttribut[i]['attribute_id']
                                              .toString() +
                                          ',' +
                                          ids;
                                    }
                                  }
                                  for (int g = 0;
                                      g < selectedAttribut.length;
                                      g++) {
                                    if (!defaultAttribut
                                        .contains(selectedAttribut[g])) {
                                      defaultAttribut.add(selectedAttribut[g]);
                                    }
                                  }
                                }

                                List<String> list = [];
                                List<int> listIdOption = [];

                                int indexSelect = -1;
                                for (int i = 0;
                                    i <
                                        infoData
                                            .attributes![index].options!.length;
                                    i++) {
                                  if (infoData.attributes![index].options![i]
                                          .is_default ==
                                      true) {
                                    indexSelect = i;
                                  }
                                  list.add(infoData
                                      .attributes![index].options![i].name!);
                                  listIdOption.add(infoData
                                      .attributes![index].options![i].id!);
                                }

                                late var controller = GroupButtonController(
                                  selectedIndexes: listIds,
                                  selectedIndex: indexSelect,
                                );

                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    VerticalPadding(
                                      percentage: 0.04,
                                    ),
                                    Container(
                                      //      height: 20,
                                      child: Text(
                                        infoData.attributes![index].name! + ":",
                                        style: appTextStyle.bigTSBasic.copyWith(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    VerticalPadding(
                                      percentage: 0.02,
                                    ),
                                    GroupButton(
                                      isRadio: true,
                                      controller: controller,
                                      options: GroupButtonOptions(
                                          selectedColor:
                                              AppColors.secondaryContainColor,
                                          unselectedColor:
                                              AppColors.mainContainColor,
                                          selectedTextStyle: appTextStyle
                                              .smallTSBasic
                                              .copyWith(
                                                  color: AppColors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                          unselectedTextStyle: appTextStyle
                                              .midSmallTSBasic
                                              .copyWith(
                                                  color: AppColors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                          elevation: 0,
                                          textPadding: EdgeInsets.symmetric(
                                              vertical: 8.sp),
                                          textAlign: TextAlign.center,
                                          unselectedShadow: [
                                            BoxShadow(
                                                offset: Offset(3.sp, 3.sp),
                                                blurRadius: 3.sp,
                                                spreadRadius: 0,
                                                color:
                                                    AppColors.mainContainColor)
                                          ],
                                          selectedShadow: [
                                            BoxShadow(
                                                offset: Offset(3.sp, 3.sp),
                                                blurRadius: 3.sp,
                                                color:
                                                    AppColors.mainContainColor)
                                          ],
                                          groupingType: GroupingType.wrap,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.sp))),
                                      onSelected: (value, j, isSelected) {
                                        ids = '';
                                        print(selectedAttribut);
                                        for (int i = 0;
                                            i < selectedAttribut.length;
                                            i++) {
                                          if (selectedAttribut[i]['id'] ==
                                              infoData.attributes![index].id) {
                                            selectedAttribut
                                                .remove(selectedAttribut[i]);
                                          }
                                        }

                                        selectedAttribut.add({
                                          'id': infoData.attributes![index].id,
                                          'attribute_id': infoData
                                              .attributes![index]
                                              .options![j]
                                              .id,
                                          'attribute_value': infoData
                                              .attributes![index]
                                              .options![j]
                                              .name,
                                          'is_default': infoData
                                              .attributes![index]
                                              .options![j]
                                              .is_default
                                        });
                                        print(selectedAttribut);
                                        if (selectedAttribut.length ==
                                            infoData.attributes!.length) {
                                          for (int i = 0;
                                              i < selectedAttribut.length;
                                              i++) {
                                            if (selectedAttribut.length == 1) {
                                              ids = selectedAttribut[i]
                                                      ['attribute_id']
                                                  .toString();
                                            } else if (i ==
                                                selectedAttribut.length - 1) {
                                              ids = ids +
                                                  selectedAttribut[i]
                                                          ['attribute_id']
                                                      .toString();
                                            } else {
                                              ids = selectedAttribut[i]
                                                          ['attribute_id']
                                                      .toString() +
                                                  ',' +
                                                  ids;
                                            }
                                          }
                                          for (int i = 0;
                                              i <
                                                  infoData
                                                      .attributes_price!.length;
                                              i++) {
                                            // print(infoData
                                            //     .attributes_price![i].ids);
                                            // print(
                                            //     "${infoData.attributes_price![i].ids}objefffffffffffffffffffffffffct$ids");

                                            List<String> d = ids.split(',');
                                            d = d.reversed.toList();
                                            final String ids2 = d.join(',');
                                            print(ids2);

                                            if (infoData.attributes_price![i]
                                                        .ids ==
                                                    ids ||
                                                infoData.attributes_price![i]
                                                        .ids ==
                                                    ids2) {
                                              print(
                                                  "objefffffffffffffffffffffffffct");
                                              cartController.changePrice(
                                                  infoData.attributes_price![i]
                                                      .price);
                                              // addedPrice =
                                              //  infoData
                                              //     .attributes_price![i].price;
                                            }
                                          }
                                        }

                                        // print(selectedAttribut);

                                        // print(
                                        //     "gggggggg$isSelected ggggggg${infoData.attributes![index].options![j].name}gggggg88 77 ${infoData.attributes![index].options![j].id}");
                                        /*   List<String> listMain = [];
                                        for (int i = 0;
                                            i < listMainIds.length;
                                            i++) {
                                          listMain =
                                              listMainIds[i].split("_");
                                          if (listMain.contains(
                                              listIdOption[j].toString())) {
                                            attribute_id = infoData
                                                .attributes_price![i].id!
                                                .toString();

                                            // listIds[j]=index;
                                          }
                                        }*/
                                      },
                                      buttons: list,
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: 16.sp,
                            ),
                            Column(
                              children: [
                                Container(
                                  height: kToolbarHeight,
                                  color: AppColors.transparent,
                                  child: TabBar(
                                    controller: _tabController,
                                    indicatorColor: AppColors.textMainColor,
                                    isScrollable: false,
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    indicatorWeight: 1,
                                    unselectedLabelStyle:
                                        appTextStyle.midSmallTSBasic.copyWith(
                                            fontWeight: AppFontWeight.regular),
                                    unselectedLabelColor:
                                        AppColors.textMainColor,
                                    tabs: [
                                      Tab(
                                        text: AppLocalizations.of(context)
                                            .translate("description"),
                                      ),
                                      Tab(
                                        text: AppLocalizations.of(context)
                                            .translate("reviews"),
                                      )
                                    ],
                                    onTap: (index) {
                                      setState(() {
                                        _selectedColor =
                                            AppColors.mainContainColor;
                                        selectTabBar =
                                            index; // Reset to default color
                                      });
                                    },
                                    labelColor: AppColors.textMainColor,
                                    labelStyle: appTextStyle.midSmallTSBasic
                                        .copyWith(
                                            fontWeight: AppFontWeight.regular),
                                  ),
                                ),

                                selectTabBar == 0
                                    ? Container(
                                        padding: EdgeInsets.all(16.sp),
                                        child: infoData.details != null &&
                                                infoData.details!.isNotEmpty
                                            ? Html(
                                                data:
                                                    '''${infoData.details.toString()}''')
                                            : Text(AppLocalizations.of(context)
                                                .translate('no_rating_yet')))
                                    : Container(
                                        padding: EdgeInsets.all(16.sp),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: infoData.ratings != null &&
                                                infoData.ratings!.isNotEmpty
                                            ? ListView.separated(
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {},
                                                    child: Container(
                                                      width: 300.sp,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20.sp,
                                                              vertical: 10.sp),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.sp),
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .mainContainColor,
                                                        border: Border.all(
                                                          color: AppColors
                                                              .borderColor,
                                                          width: 0.2,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                              20.sp),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              infoData.ratings![index]
                                                                          .user_photo !=
                                                                      null
                                                                  ? ClipOval(
                                                                      child: Image
                                                                          .network(
                                                                        infoData
                                                                            .ratings![index]
                                                                            .user_photo!,
                                                                        width: 32
                                                                            .sp,
                                                                        height:
                                                                            32.sp,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    )
                                                                  : AccountIcon(
                                                                      height:
                                                                          32.sp,
                                                                      width:
                                                                          32.sp,
                                                                    ),
                                                              SizedBox(
                                                                width: 12.sp,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    infoData
                                                                        .ratings![
                                                                            index]
                                                                        .user_name
                                                                        .toString(),
                                                                    style: appTextStyle
                                                                        .midSmallTSBasic
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        12.sp,
                                                                  ),
                                                                  Container(
                                                                    child:
                                                                        RatingBarIndicator(
                                                                      rating: double.parse(infoData
                                                                          .ratings![
                                                                              index]
                                                                          .rating
                                                                          .toString()),
                                                                      itemCount:
                                                                          5,
                                                                      itemSize:
                                                                          13.sp,
                                                                      unratedColor:
                                                                          AppColors
                                                                              .darkGrayColor,
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      itemBuilder:
                                                                          (context, _) =>
                                                                              Icon(
                                                                        Icons
                                                                            .star,
                                                                        size: 13
                                                                            .sp,
                                                                        color: Colors
                                                                            .amber,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 8.sp,
                                                          ),
                                                          Text(
                                                            AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        "comment") +
                                                                ":",
                                                            style: appTextStyle
                                                                .midSmallTSBasic
                                                                .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 4.sp,
                                                          ),
                                                          Text(
                                                            infoData
                                                                .ratings![index]
                                                                .review
                                                                .toString(),
                                                            style: appTextStyle
                                                                .midSmallTSBasic
                                                                .copyWith(
                                                              color: AppColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                separatorBuilder:
                                                    (context, index) {
                                                  return SizedBox(
                                                    width: 8.sp,
                                                  );
                                                },
                                                itemCount:
                                                    infoData.ratings!.length,
                                                // scrollDirection: Axis.horizontal,
                                              )
                                            : Text(AppLocalizations.of(context)
                                                .translate('no_rating_yet')),
                                        alignment: Alignment.center,
                                        height: 150.sp,
                                      ),
                                // Container(
                                //   height: 150.sp,
                                //   child: TabBarView(
                                //       physics: NeverScrollableScrollPhysics(),
                                //       controller: _tabController,
                                //       children: [
                                //         SingleChildScrollView(
                                //           child: Container(
                                //               padding: EdgeInsets.all(16.sp),
                                //               child: Html(
                                //                   data:
                                //                       '''${infoData.details.toString()}''')),
                                //         ),
                                //         Container(
                                //           padding: EdgeInsets.all(16.sp),
                                //           child: ListView.separated(
                                //             itemBuilder: (context, index) {
                                //               return InkWell(
                                //                 onTap: () {},
                                //                 child: Container(
                                //                   width:
                                //                       MediaQuery.of(context)
                                //                               .size
                                //                               .width -
                                //                           40.sp,
                                //                   padding:
                                //                       EdgeInsets.symmetric(
                                //                           horizontal: 20.sp,
                                //                           vertical: 10.sp),
                                //                   decoration: BoxDecoration(
                                //                     color: AppColors
                                //                         .mainContainColor,
                                //                     border: Border.all(
                                //                       color: AppColors
                                //                           .borderColor,
                                //                       width: 0.2,
                                //                     ),
                                //                     borderRadius:
                                //                         BorderRadius.all(
                                //                       Radius.circular(20.sp),
                                //                     ),
                                //                   ),
                                //                   child: Column(
                                //                     crossAxisAlignment:
                                //                         CrossAxisAlignment
                                //                             .start,
                                //                     children: [
                                //                       Row(
                                //                         mainAxisAlignment:
                                //                             MainAxisAlignment
                                //                                 .start,
                                //                         children: [
                                //                           infoData.ratings![index]
                                //                                       .user_photo !=
                                //                                   null
                                //                               ? ClipOval(
                                //                                   child: Image
                                //                                       .network(
                                //                                     infoData
                                //                                         .ratings![
                                //                                             index]
                                //                                         .user_photo!,
                                //                                     width:
                                //                                         32.sp,
                                //                                     height:
                                //                                         32.sp,
                                //                                     fit: BoxFit
                                //                                         .fill,
                                //                                   ),
                                //                                 )
                                //                               : AccountIcon(
                                //                                   height:
                                //                                       32.sp,
                                //                                   width:
                                //                                       32.sp,
                                //                                 ),
                                //                           SizedBox(
                                //                             width: 12.sp,
                                //                           ),
                                //                           Column(
                                //                             mainAxisAlignment:
                                //                                 MainAxisAlignment
                                //                                     .start,
                                //                             crossAxisAlignment:
                                //                                 CrossAxisAlignment
                                //                                     .start,
                                //                             children: [
                                //                               Text(
                                //                                 infoData
                                //                                     .ratings![
                                //                                         index]
                                //                                     .user_name
                                //                                     .toString(),
                                //                                 style: appTextStyle
                                //                                     .midSmallTSBasic
                                //                                     .copyWith(
                                //                                   color: AppColors
                                //                                       .black,
                                //                                   fontWeight:
                                //                                       FontWeight
                                //                                           .normal,
                                //                                 ),
                                //                               ),
                                //                               SizedBox(
                                //                                 width: 12.sp,
                                //                               ),
                                //                               Container(
                                //                                 child:
                                //                                     RatingBarIndicator(
                                //                                   rating: double.parse(infoData
                                //                                       .ratings![
                                //                                           index]
                                //                                       .rating
                                //                                       .toString()),
                                //                                   itemCount:
                                //                                       5,
                                //                                   itemSize:
                                //                                       13.sp,
                                //                                   unratedColor:
                                //                                       AppColors
                                //                                           .darkGrayColor,
                                //                                   direction: Axis
                                //                                       .horizontal,
                                //                                   itemBuilder:
                                //                                       (context,
                                //                                               _) =>
                                //                                           Icon(
                                //                                     Icons
                                //                                         .star,
                                //                                     size:
                                //                                         13.sp,
                                //                                     color: Colors
                                //                                         .amber,
                                //                                   ),
                                //                                 ),
                                //                               ),
                                //                             ],
                                //                           ),
                                //                         ],
                                //                       ),
                                //                       SizedBox(
                                //                         height: 8.sp,
                                //                       ),
                                //                       Text(
                                //                         AppLocalizations.of(
                                //                                     context)
                                //                                 .translate(
                                //                                     "comment") +
                                //                             ":",
                                //                         style: appTextStyle
                                //                             .midSmallTSBasic
                                //                             .copyWith(
                                //                           color:
                                //                               AppColors.black,
                                //                           fontWeight:
                                //                               FontWeight
                                //                                   .normal,
                                //                         ),
                                //                       ),
                                //                       SizedBox(
                                //                         height: 4.sp,
                                //                       ),
                                //                       Text(
                                //                         infoData
                                //                             .ratings![index]
                                //                             .review
                                //                             .toString(),
                                //                         style: appTextStyle
                                //                             .midSmallTSBasic
                                //                             .copyWith(
                                //                           color:
                                //                               AppColors.black,
                                //                           fontWeight:
                                //                               FontWeight
                                //                                   .normal,
                                //                         ),
                                //                         maxLines: 1,
                                //                         overflow: TextOverflow
                                //                             .ellipsis,
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //               );
                                //             },
                                //             separatorBuilder:
                                //                 (context, index) {
                                //               return SizedBox(
                                //                 height: 8.sp,
                                //               );
                                //             },
                                //             itemCount:
                                //                 infoData.ratings!.length!,
                                //             scrollDirection: Axis.vertical,
                                //           ),
                                //           width: 50.sp,
                                //         ),
                                //       ]),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        : Container();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void minus() async {
    setState(() {
      if (data.quantity! != 0) {
        data.quantity = data.quantity! - 1;
      }
      total = data.price! * data.quantity!;
    });
  }

  Future<void> add() async {
    setState(() {
      if (data.quantity == null) {
        data.quantity = 0;
        data.quantity = data.quantity! + 1;
      } else
        data.quantity = data.quantity! + 1;

      total = data.price! * data.quantity!;
    });
  }

  Future<void> getCart() async {
    addressId = await _repository.addressId;
  }
}

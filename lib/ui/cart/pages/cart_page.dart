import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/constants/text_style.dart';
import 'package:erp/models/user_management/sign_in_dashboard_response.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/stores/theme/theme_store.dart';
import 'package:erp/ui/cart/widget/cart_overview_widget.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/widgets/dialog/clear_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../data/repo/user_management_repository.dart';
import '../../../di/components/service_locator.dart';
import '../../../models/cart/cart_model.dart';
import '../../../models/cart/cart_validate_model.dart';
import '../../../models/cart/products_cart.dart';
import '../../../state/general_state.dart';
import '../../../utils/device/app_uitls.dart';
import '../../../utils/routes/routes.dart';
import '../../../widgets/dialog/address_dialog.dart';
import '../../checkout/argument/CheckoutArgument.dart';
import '../../shimmer/dashboard_home_loading_widget.dart';
import '../../user_management/widgets/button_user_management_widget.dart';
import '../controller/cart_controller.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var timeFormat = DateFormat('dd/MM/yyyy');
  String _date = "";
  UserSignInDashboardResult? _userInfo;

  CartController cartController = Get.find();
  CartValidateData data = new CartValidateData(items: []);

  var _cancelToken = CancelToken();
  int limit = 25, page = 1, startAt = 0, endAt = 0, preparePage = 1;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _refresherKey = GlobalKey();
  double total = 0, subtotal = 0, tax = 0;
  String curr = "AED";
  int cartLength = 0;
  static bool isValidateCart = false, isValidateTime = false;

  // //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  // There is next pages or not
  late ScrollController _controller;
  late double width, height;

  late AnimationController controller;
  late Animation<double> scaleAnimation;

  UserManagementRepository _repository = getIt<UserManagementRepository>();

  static String? time, addressId, address;

  @override
  void initState() {
    super.initState();
    GeneralState.reset();

    getCart();
    _date = timeFormat.format(DateTime.now());
    _controller = new ScrollController()..addListener(_loadMore);

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
//    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack);

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    controller.forward();
  }

  Future<void> getCart() async {
    time = await _repository.time;
    addressId = await _repository.addressId;
    address = await _repository.address;
  }

  @override
  Widget build(BuildContext context) {
    width = DeviceUtils.getScaledWidth(context, 1);
    height = DeviceUtils.getScaledHeight(context, 1);

    super.build(context);
    AppBar appBar = AppBar(
      title: Container(
        color: AppColors.transparent,
        child: Padding(
            padding:
                EdgeInsets.only(bottom: 40.0, top: 40.0, left: 10, right: 10),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                InkWell(
                  onTap: () {
                    if (cartLength > 0)
                      cartController.clearCart(
                          _cancelToken,
                          null, // mean clear all data in cart
                          _languageStore.getCode());
                    /*if(cartLength>0)
                      showDialog(
                          context: context, builder: (context) => ClearDialog());*/
                  },
                  child: Text(
                    AppLocalizations.of(context).translate('clear'),
                    style: appTextStyle.minTSBasic.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: AppTextSize.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
                FadeInDown(
                  delay: Duration(milliseconds: 800),
                  duration: Duration(milliseconds: 400),
                  animate: true,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('cart'),
                      style: appTextStyle.subBigTSBasicBold.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: AppTextSize.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            )),
      ),
      backgroundColor: AppColors.appBarBGColor,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.black,
          )),
      brightness: Brightness.light,
      elevation: 0,
    );

    return Stack(
      children: [
        Container(
          color: AppColors.white,
        ),
        Scaffold(
          appBar: appBar,
          backgroundColor: AppColors.scaffoldBGColor,
          body: Column(
            children: [
              VerticalPadding(
                percentage: 0.02,
              ),
              Expanded(
                child: _buildBody(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return GetBuilder<CartController>(builder: (state) {
      if (GeneralState.isFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AppUtils.showErrorMessage(
              error: state.productFailure.error, context: context);
        });
      }

      if (GeneralState.isLoading)
        return ListView.builder(
            itemCount: 10,
            // Important code
            itemBuilder: (context, index) => DashboardHomeLoadingWidget(
                  width: width * 0.83,
                  height: height,
                ));
      if (GeneralState.iSuccess) {
        // GeneralState.reset();
        total = state.cartAllSuccess.result.total ?? 0;
        cartLength = state.cartAllSuccess.result.items!.length;
        if (cartLength > 0) curr = state.cartAllSuccess.result.curr!.sign ?? '';
        return _buildMainView(
            height: height, width: width, result: state.cartAllSuccess.result);
      }

      return Container();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //
    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    cartController.getCart(_cancelToken, limit, page, _languageStore.getCode());
  }

  _buildMainView(
      {required double width,
      required double height,
      required CartModel result}) {
    print(
        "ffffffffffffffffffffffffffffffffffffffffffffffff ${result.items!.length}");
    return Column(
      children: [
        Expanded(
            child: result.items!.length > 0
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    controller: _controller,
                    //controller: ModalScrollController.of(context),
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    //physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return index >= result.items!.length
                          ? Container()
                          : Row(
                              children: [
                                CartOverviewWidget(
                                  cartId:
                                      cartController.cartAllSuccess.result.id!,
                                  callback: refresh,
                                  index: index,
                                  width: width,
                                  lang: _languageStore.getCode(),
                                  cancelToken: _cancelToken,
                                  infoData: result.items![index],
                                ),
                              ],
                            );
                    },
                    itemCount: result.items!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                  )
                : SvgPicture.asset(AppAssets.emptyPage)),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: ButtonUserManagementWidget(
            width: MediaQuery.of(context).size.width,
            child: Text(
              AppLocalizations.of(context).translate("go_checkout") +
                  "      " +
                  NumberFormat.currency(
                          name: cartLength > 0 ? result.curr!.sign! : "0",
                          customPattern: '\u00a4 ###,###')
                      .format(result.total),
              style:
                  appTextStyle.middleTSBasic.copyWith(color: AppColors.white),
            ),
            backgroundColor:
                result.items!.length > 0 ? AppColors.mainColor : AppColors.gray,
            height: 55,
            borderRadius: 10.0,
            borderColor: AppColors.white,
            onPressed: () async {
              // if (address == null)
              //   showDialog(
              //       context: context, builder: (context) => AddressDialog());
              // else if (result.items!.length > 0) {
              //   for (int i = 0; i < result.items!.length; i++) {
              //     /* String? ids=null;
              //         for(int k=0;k<result.items![i].price_options!.length;k++)
              //         {
              //           ids=result.items![i].price_options![k].ids;
              //         }*/
              //     data.items.add(Items(
              //         attributes_price_id: int.parse(
              //             result.items![i].attributes_price_id.toString()),
              //         product_id: result.items![i].product_id,
              //         quantity:
              //             int.parse(result.items![i].qty_in_cart!.toString())));
              //   }

/*
{   "method_id":  5 ,
    "coupon_code" : null  ,
    "lang" : "ar" ,
    "cart_id" : 239 ,
    "address_id" : 2
    } */
              if (result.items!.length > 0) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context)
                      .pushNamed(Routes.checkoutPage, arguments: {
                    'cart_id': result.id,
                    'checkout_argument': CheckoutArgument(addressId, time,
                        address, subtotal, tax, total, curr, true, data)
                  });
                });
              }

              // }
            },
          ),
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

  void _loadMore() async {}

  void refresh() {
    setState(() {});
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/constants/text_style.dart';
import 'package:erp/models/home/products_model.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/stores/theme/theme_store.dart';
import 'package:erp/ui/products/widget/product_overview_widget.dart';
import 'package:erp/utils/args/warehouses_filter_args.dart';
import 'package:erp/utils/device/app_uitls.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/widgets/empty_page_widget.dart';

import '../../../models/cart/products_cart.dart';
import '../../../state/general_state.dart';
import '../../shimmer/dashboard_home_loading_widget.dart';
import '../../user_management/widgets/button_user_management_widget.dart';
import '../argument/ProductsArgument.dart';
import '../controller/products_controller.dart';
import '../widget/category_sub_overview_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage();

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var _cancelToken = CancelToken();

  ProductsController productsController = Get.find();

  int limit = 25,
      page = 1,
      startAt = 0,
      endAt = 0,
      preparePage = 1,
      indexData = 0;
  late List<DataData> list = <DataData>[];
  late List<ProductData> data = <ProductData>[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _refresherKey = GlobalKey();
  late List<Products> cart;
  late int index;
  late String? address, token;

  bool showFilter = false;
  bool showAdvancedFilter = false;

  // //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  late double widthC, heightC;

  // There is next pages or not
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  bool _isProducts = true;
  late ScrollController _controller;

  int? _selectedIndex = null;
  int? _selectedTagsIndex = 0;

  var arg;

  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    widthC = DeviceUtils.getScaledWidth(context, 1);
    heightC = DeviceUtils.getScaledHeight(context, 1);

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
                FadeInDown(
                  delay: Duration(milliseconds: 800),
                  duration: Duration(milliseconds: 400),
                  animate: true,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate('my_products'),
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
          appBar: appBar,
          backgroundColor: AppColors.scaffoldBGColor,
          body: Column(
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
      ],
    );
  }

  Widget _buildBody({required double width, required double height}) {
    return GetBuilder<ProductsController>(builder: (state) {
      if (GeneralState.isFailure) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AppUtils.showErrorMessage(
              error: state.productFailure.error, context: context);
        });
      }

      if (GeneralState.isLoading)
        return (!_isLoadMoreRunning)
            ? ListView.builder(
                itemCount: 10,
                // Important code
                itemBuilder: (context, index) => DashboardHomeLoadingWidget(
                      width: width * 0.83,
                      height: height,
                    ))
            : _buildMainView(
                height: height, width: width, result: data[indexData]);
      if (GeneralState.iSuccess) {
        data = state.productSuccess.result.data!;
        list = state.productSuccess.result.data![indexData].products!.data!;
        /* data.subs!.insert(
            0, SubsData(id: 0, api_image_url: "", name: "ALL", product_ids: []));*/
       // GeneralState.reset();
        _selectedTagsIndex = data[indexData].subs!.length;
        return _buildMainView(
            height: height, width: width, result: data[indexData]);
      }

      return _buildMainView(
          height: height, width: width, result: data[indexData]);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _languageStore = Provider.of<LanguageStore>(context);

    arg = ModalRoute.of(context)!.settings.arguments as ProductsArgument;
    cart = arg.cart;
    index = arg.index;
    _selectedIndex = arg.index;
    indexData=_selectedIndex!;
    token = arg.token;
    address = arg.address;
    initData(arg.id);
  }

  @override
  void initState() {
    super.initState();
    GeneralState.reset();
    _isFirstLoadRunning = true;
    _controller = new ScrollController()..addListener(_loadMore);
  }

  void initData(String id) {
    productsController.getProducts(
        _cancelToken, limit, page, _languageStore.getCode());
  }

  _buildMainView(
      {required double width,
      required double height,
      required ProductData result}) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.space12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 2,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              //controller: ModalScrollController.of(context),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              //physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return index >= arg.data.length
                    ? Container()
                    : Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(AppDimens.space6),
                            child: ButtonUserManagementWidget(
                              width: widthC / 4,

                              child: Text(
                                arg.data[index].name,
                                style: appTextStyle.middleTSBasic.copyWith(
                                    color: _selectedIndex != null &&
                                            _selectedIndex == index
                                        ? AppColors.white
                                        : AppColors.black),
                                textAlign: TextAlign.center,
                              ),
                              backgroundColor: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? AppColors.mainColor
                                  : AppColors.white,
                              height: height,
                              borderRadius: 10.0,
                              borderColor: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? AppColors.mainColor
                                  : AppColors.white,
                              onPressed: () {
                                isLoading = false;
                                _onSelected(index);
                                indexData = index;
                                _selectedTagsIndex =
                                    data[indexData].subs!.length;
                                _buildMainView(
                                    height: height,
                                    width: width,
                                    result: data[indexData]);
                                //   initData(arg.data[index].id.toString());
                              },
                            ),
                          )
                        ],
                      );
              },
              itemCount: arg.data.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Flexible(
            child: _buildTagView(width: width, height: height, result: result),
            flex: 2,
          ),
          Expanded(
            child: _isProducts
                ? _buildSubMainView(
                    width: width,
                    height: height,
                    result: data[indexData].products!.data!)
                :
            EmptyPageWidget()
            /*_buildSubCategoryView(
                width: width,
                height: height,
                result: data[indexData].subs!)*/,
            flex: 9,
          )
        ],
      ),
    );
  }

  _buildTagView(
      {required double width,
      required double height,
      required ProductData result}) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.space10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(AppDimens.space4),
              //controller: ModalScrollController.of(context),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              //physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return index == result.subs!.length
                    ? Padding(
                        padding: const EdgeInsets.all(AppDimens.space6),
                        child: ButtonUserManagementWidget(
                          width: widthC / 5,
                          child: Text(
                            AppLocalizations.of(context).translate('products'),
                            style: appTextStyle.middleTSBasic.copyWith(
                                color: _selectedTagsIndex != null &&
                                        _selectedTagsIndex == index
                                    ? AppColors.white
                                    : AppColors.black),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: _selectedTagsIndex != null &&
                                  _selectedTagsIndex == index
                              ? AppColors.mainColor
                              : AppColors.white,
                          height: height,
                          borderRadius: 10.0,
                          borderColor: _selectedTagsIndex != null &&
                                  _selectedTagsIndex == index
                              ? AppColors.mainColor
                              : AppColors.white,
                          onPressed: () {
                           setState(() {
                             _isProducts = true;
                             _onSelectedTags(index);
                           });
                          },
                        ))
                    : Padding(
                        padding: const EdgeInsets.all(AppDimens.space4),
                        child: ButtonUserManagementWidget(
                          width: widthC / 5,
                          child: Text(
                            result.subs![index].name!,
                            style: appTextStyle.middleTSBasic.copyWith(
                                color: _selectedTagsIndex != null &&
                                        _selectedTagsIndex == index
                                    ? AppColors.white
                                    : AppColors.black),
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: _selectedTagsIndex != null &&
                                  _selectedTagsIndex == index
                              ? AppColors.mainColor
                              : AppColors.white,
                          height: height,
                          borderRadius: 10.0,
                          borderColor: _selectedTagsIndex != null &&
                                  _selectedTagsIndex == index
                              ? AppColors.mainColor
                              : AppColors.white,
                          onPressed: () {
                          setState(() {
                            _isProducts = false;
                            _onSelectedTags(index);
                          });
                          },
                        ));
              },
              itemCount: result.subs!.length + 1,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
            ),
            flex: 1,
          ),
          VerticalPadding(
            percentage: 0.02,
          ),
          /* _selectedTagsIndex
              == 0
              ? Expanded(
                  child: _buildSubMainView(
                      width: width, height: height, result: result.products!),
                  flex: 4,
                )
              : Expanded(
                  child: _buildSubTagsView(
                      width: width,
                      height: height,
                      result: result.subs![_selectedTagsIndex!].product_ids!),
                  flex: 4,
                )*/
        ],
      ),
    );
  }

/*  _buildSubTagsView(
      {required double width,
      required double height,
      required List<ProductIdsData> result}) {
    return GridView.builder(
      itemCount: result.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: const EdgeInsets.only(
          bottom: AppDimens.space4, top: AppDimens.space4),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppDimens.space10,
        mainAxisSpacing: AppDimens.space10,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (BuildContext context, int index) {
        for (int i = 0; i < cart.length; i++) {
          if (result[index].id == cart[i].id!)
            result[index].quantity = cart[i].quantity!;
        }

        return ProductTagsOverviewWidget(
          address: address,
          token: token,
          cart: cart,
          width: widthC,
          infoData: result[index],
          cancelToken: _cancelToken,
        );
      },
    );
  }*/

  _buildSubMainView(
      {required double width,
      required double height,
      required List<DataData> result}) {
    return result.length > 0
        ? GridView.builder(
            itemCount: result.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.only(
                bottom: AppDimens.space4, top: AppDimens.space4),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppDimens.space10,
              mainAxisSpacing: AppDimens.space10,
              childAspectRatio: 1,
            ),
            itemBuilder: (BuildContext context, int index) {
              for (int i = 0; i < cart.length; i++) {
                if (result[index].id == cart[i].id!)
                  result[index].quantity = cart[i].quantity!;
              }

              return ProductOverviewWidget(
                address: address,
                token: token,
                cart: cart,
                width: widthC,
                infoData: result[index],
                cancelToken: _cancelToken,
              );
            },
          )
        : EmptyPageWidget();
  }

  _buildSubCategoryView(
      {required double width,
        required double height,
        required List<SubsData> result}) {
    return result.length > 0
        ? GridView.builder(
      itemCount: result.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: const EdgeInsets.only(
          bottom: AppDimens.space4, top: AppDimens.space4),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppDimens.space10,
        mainAxisSpacing: AppDimens.space10,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (BuildContext context, int index) {
        return CategorySubOverviewWidget(
          address: address,
          token: token,
          width: widthC,
          infoData: result[index],
          cancelToken: _cancelToken,
        );
      },
    )
        : EmptyPageWidget();
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      page = preparePage;
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      //initData(arg.id);
    }
  }

  int calculateListWarehouseCount(List<ProductsData> state) {
    if (_hasNextPage) {
      return state.length;
    } else {
      // + 1 for the loading indicator
      return state.length + 1;
    }
  }

  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _onSelectedTags(int index) {
    setState(() {
      _selectedTagsIndex = index;
    });
  }
}

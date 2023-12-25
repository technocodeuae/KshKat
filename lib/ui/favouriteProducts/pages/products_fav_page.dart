import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/constants/text_style.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/stores/theme/theme_store.dart';
import 'package:erp/ui/products/widget/product_overview_widget.dart';
import 'package:erp/utils/args/warehouses_filter_args.dart';
import 'package:erp/utils/device/app_uitls.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/widgets/empty_page_widget.dart';

import '../../../data/repo/user_management_repository.dart';
import '../../../di/components/service_locator.dart';
import '../../../models/home/products_fav_model.dart';
import '../../../state/general_state.dart';
import '../../products/controller/products_controller.dart';
import '../../shimmer/dashboard_home_loading_widget.dart';
import '../widget/product_fav_overview_widget.dart';

class ProductFavPage extends StatefulWidget {
  const ProductFavPage();

  @override
  _ProductFavPageState createState() => _ProductFavPageState();
}

class _ProductFavPageState extends State<ProductFavPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  var _cancelToken = CancelToken();

  ProductsController productsController = Get.find();

  int limit = 25,
      page = 1,
      startAt = 0,
      endAt = 0,
      preparePage = 1,
      indexData = 0;
  late List<ProductsData> data = <ProductsData>[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _refresherKey = GlobalKey();
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
  UserManagementRepository _repository = getIt<UserManagementRepository>();

  int? _selectedIndex = null;
  int? _selectedTagsIndex = 0;

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
            : _buildMainView(height: height, width: width, result: data);
      if (GeneralState.iSuccess) {
        data = state.productFavSuccess.result.products!;
        /* data.subs!.insert(
            0, SubsData(id: 0, api_image_url: "", name: "ALL", product_ids: []));*/
        GeneralState.reset();
        return _buildMainView(height: height, width: width, result: data);
      }

      return _buildMainView(height: height, width: width, result: data);
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    _languageStore = Provider.of<LanguageStore>(context);
    address = await _repository.address;
    token = await _repository.authToken;
    initData();
  }

  @override
  void initState() {
    super.initState();
    GeneralState.reset();
    _isFirstLoadRunning = true;
    _controller = new ScrollController()..addListener(_loadMore);
  }

  void initData() {
    productsController.getProductsFav(
        _cancelToken, limit, page, _languageStore.getCode(), true);
  }

  _buildMainView(
      {required double width,
      required double height,
      required List<ProductsData> result}) {
    return result.length > 0
        ? GridView.builder(
            itemCount: result.length,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
                vertical: AppDimens.space4, horizontal: AppDimens.space10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.sp,
              mainAxisSpacing: 5.sp,
              childAspectRatio: 0.6.sp,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ProductFavOverviewWidget(
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
  bool get wantKeepAlive => false;

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

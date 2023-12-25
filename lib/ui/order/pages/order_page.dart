import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/constants/text_style.dart';
import 'package:erp/models/order/order_model.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/stores/theme/theme_store.dart';
import 'package:erp/utils/device/app_uitls.dart';
import 'package:erp/utils/device/device_utils.dart';
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/widgets/empty_page_widget.dart';

import '../../../state/general_state.dart';
import '../../shimmer/dashboard_home_loading_widget.dart';
import '../controller/order_controller.dart';
import '../widget/order_overview_widget.dart';

class OrderPage extends StatefulWidget {

    @override
    _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

    OrderController orderController =  Get.find();

    var _cancelToken = CancelToken();
    int limit = 25, page = 1, startAt = 0, endAt = 0, preparePage = 1;
    late List<OrderData> list = <OrderData>[];
    RefreshController _refreshController =
    RefreshController(initialRefresh: false);
    GlobalKey _refresherKey = GlobalKey();

    // //stores:---------------------------------------------------------------------
    late ThemeStore _themeStore;
    late LanguageStore _languageStore;

    // There is next pages or not
    late ScrollController _controller;
    late double width,height;


    @override
    Widget build(BuildContext context) {
        width = DeviceUtils.getScaledWidth(context, 1);
        height = DeviceUtils.getScaledHeight(context, 1);
        super.build(context);
        AppBar appBar = AppBar(
            title: Container(
                color: AppColors.transparent,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 40.0,top: 40.0,left: 10,right: 10),
                    child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                            InkWell(
                                onTap: (){
                                    Navigator.of(context).pop(true);
                                },
                                child:  Container(
                                    width: 50,
                                    height: 50,
                                    child: Icon(
                                        _languageStore.getLanguage() == "Arabic"?Icons.arrow_forward_ios_sharp:
                                        Icons.arrow_back_ios_sharp,
                                        color: AppColors.black,
                                        size: 20,
                                    ),
                                )
                            ),
                            FadeInDown(
                                delay: Duration(milliseconds: 800),
                                duration: Duration(milliseconds: 400),
                                animate: true,
                                child: Center(
                                    child: Text(
                                        AppLocalizations.of(context).translate('order'),
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

        double widthC = DeviceUtils.getScaledWidth(context, 1);
        double heightC = DeviceUtils.getScaledHeight(context, 1);


        return WillPopScope(
            onWillPop: () async{
              Navigator.of(context).pop(true);
              return false;
            },
          child: Stack(
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
                              child: _buildBody(height: heightC, width: widthC),
                          ),
                      ],
                  ),
              ),
            ],
          ),
        );
    }

    Widget _buildBody({required double width, required double height}) {
        return GetBuilder<OrderController>(
            builder: (state) {

                if (GeneralState.isFailure) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                        AppUtils.showErrorMessage(error: state.orderFailure.error, context: context);

                    });
                }

                if (GeneralState.isLoading)
                    return  ListView.builder(
                        itemCount: 10,
                        // Important code
                        itemBuilder: (context, index) => DashboardHomeLoadingWidget(
                            width: width * 0.83,
                            height: height,
                        ));
                if (GeneralState.iSuccess) {
                    if (page == 1)
                        list = state.orderSuccess.result.data!;
                    else
                        list.addAll(state.orderSuccess.result.data!);
                    return _buildMainView(
                        height: height, width: width, result: list);
                }

                return _buildMainView(
                    height: height, width: width, result: list);

            });
    }


    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        //
        // initializing stores
        _languageStore = Provider.of<LanguageStore>(context);
        _themeStore = Provider.of<ThemeStore>(context);
        orderController.getOrder(_cancelToken, limit, page,_languageStore.getCode());

    }

    @override
    void initState() {
        super.initState();
        GeneralState.reset();
        _controller = new ScrollController()..addListener(_loadMore);

    }

    _buildMainView(
        {required double width,
            required double height,
            required List<OrderData> result}) {
        return Column(
            children: [

                Expanded(
                    child: RefreshConfiguration(
                        child: SmartRefresher(
                            header: WaterDropMaterialHeader(
                                backgroundColor: AppColors.purple,
                                offset: _languageStore.getLanguage()=="Arabic" ? -85.h : 0.h,
                            ),
                            physics: BouncingScrollPhysics(),
                            onRefresh: () async {
                                page = 1;
                                list = [];
                                orderController.getOrder(_cancelToken, limit, page,_languageStore.getCode());
                                _refreshController.refreshCompleted();
                            },
                            key: _refresherKey,
                            footer: ClassicFooter(
                                loadStyle: LoadStyle.ShowWhenLoading,
                            ),
                            controller: _refreshController,
                            child:
                            result.length>0?ListView.builder(
                                padding: EdgeInsets.zero,
                                controller: _controller,
                                //controller: ModalScrollController.of(context),
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                //physics: ClampingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                    return index >= result.length
                                        ? Container() /*BottomLoader()*/
                                        : Row(
                                        children: [
                                            OrderOverviewWidget(
                                                width: width,
                                                infoData: result[index],
                                                cancelToken: _cancelToken,
                                            ),
                                        ],
                                    );
                                },
                                itemCount: result.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                            ):
                            EmptyPageWidget(),
                        ),
                    ),
                )
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

    }

}

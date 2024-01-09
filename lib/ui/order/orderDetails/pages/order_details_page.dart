import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../common/animation/animation_column_widget.dart';
import '../../../../common/widgets/horizontal_padding.dart';
import '../../../../common/widgets/vertical_padding.dart';
import '../../../../constants/app_dimens.dart';
import '../../../../constants/app_radius.dart';
import '../../../../constants/app_text_size.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/text_style.dart';
import '../../../../models/order/order_details_model.dart';
import '../../../../models/order/order_model.dart';
import '../../../../state/general_state.dart';
import '../../../../stores/language/language_store.dart';
import '../../../../stores/theme/theme_store.dart';
import '../../../../utils/device/app_uitls.dart';
import '../../../../utils/device/device_utils.dart';
import '../../../../utils/locale/app_localization.dart';
import '../../../../widgets/empty_page_widget.dart';
import '../../../shimmer/dashboard_home_loading_widget.dart';
import '../argument/OrderArgument.dart';
import '../controller/order_details_controller.dart';
import '../widget/order_details_widget.dart';



class OrderDetailsPage extends StatefulWidget {

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  late final arg;
  OrderDetailsController orderDetailsController =  Get.find();

  var _cancelToken = CancelToken();
  int limit = 25, page = 1, startAt = 0, endAt = 0, preparePage = 1;
  late OrderDetailsData list;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  GlobalKey _refresherKey = GlobalKey();

  // //stores:---------------------------------------------------------------------
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  // There is next pages or not
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  late ScrollController _controller;
  late double width,height;
  final formKey = GlobalKey<FormState>();


  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    GeneralState.reset();
    _isFirstLoadRunning = true;
    _controller = new ScrollController()..addListener(_loadMore);

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack);

    controller.addListener(() {
      if (mounted) setState(() {});
    });

    controller.forward();

  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppBar appBar = AppBar(
      title: Container(
        color: AppColors.white,
        child: Padding(
            padding: EdgeInsets.only(bottom: 40.0,top: 40.0,left: 10,right: 10),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
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
      // brightness: Brightness.light,
      elevation: 0,
    );

    double widthC = DeviceUtils.getScaledWidth(context, 1);
    double heightC = DeviceUtils.getScaledHeight(context, 1);

    return
      WillPopScope(
        onWillPop:() async {
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          appBar: appBar,
          backgroundColor:Colors.white,
          body:
          SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: AnimationColumnWidget(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    duration: Duration(milliseconds: 1000),
                    verticalOffset: 50,
                    children: [
                      Container(
                        height: 1000,
                        child:Column(
                          children: [
                            VerticalPadding(
                              percentage: 0.02,
                            ),
                            Expanded(
                              child: _buildBody(height: heightC, width: widthC),
                            ),
                          ],
                        ),
                      )
                    ],
                  ))),
        ),);
  }


  Widget _buildBody({required double width, required double height}) {

    return GetBuilder<OrderDetailsController>(
        builder: (state) {

          if (GeneralState.isFailure) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              AppUtils.showErrorMessage(error: state.orderFailure.error, context: context);

            });
          }

          if (GeneralState.isLoading)
            return (!_isLoadMoreRunning)
                ? ListView.builder(
                itemCount: 10,
                // Important code
                itemBuilder: (context, index) =>
                    DashboardHomeLoadingWidget(
                      width: width * 0.83,
                      height: height,
                    ))
                : Container();
          if (GeneralState.iSuccess) {
            list=state.orderSuccess.result.data![0];
            return  _buildMainView(
                height: height,
                width: width, result: list);
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
    // _user = getIt<UserManagementDataSource>().getUserInfo();
    arg= ModalRoute.of(context)!.settings.arguments as OrderArgument;
    orderDetailsController.getOrderDetails(_cancelToken, arg.id,_languageStore.getCode());
  }

  _buildMainView(
      {required double width,
      required double height,
      required OrderDetailsData result}) {
    return Padding(padding: const EdgeInsets.all(AppDimens.space8),
    child: AnimationColumnWidget(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      duration: Duration(milliseconds: 1000),
      verticalOffset: 50,
      children: [
        /*Card(
          color: AppColors.white,
          shadowColor: AppColors.mainGray.withOpacity(0.6),
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppRadius.radius10))),
          child: Container(
            width: width,
            padding: const EdgeInsets.all(AppDimens.space16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Container(
                  width: 40,
                  height: 40,
                  color: AppColors.light_gray,
                  child:
                  Icon(
                    Icons.access_time,
                    color: AppColors.mainColor,
                    size: 20,
                  ),
                ),
                HorizontalPadding(
                  percentage: 0.035,
                ),
               *//* Column(
                  children: [
                    Text(
                      AppLocalizations.of(context).translate('delivery_time'),
                      style: appTextStyle.minTSBasic
                          .copyWith(color: AppColors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    VerticalPadding(
                      percentage: 0.01,
                    ),
                    Text(
                      result.delivery_slot_id![1],
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      result.delivery_slot_time_id![1],
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.black),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    VerticalPadding(
                      percentage: 0.01,
                    ),
                  ],
                ),*//*
                *//*Spacer(),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColors.black,
                  size: 20,
                ),*//*

              ],
            ),
          ),
        ),*/
        Card(
          color: AppColors.white,
          shadowColor: AppColors.mainGray.withOpacity(0.6),
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppRadius.radius10))),
          child: Container(
            width: width,
            padding: const EdgeInsets.all(AppDimens.space16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Container(
                  width: 40,
                  height: 40,
                  color: AppColors.light_gray,
                  child:
                  Icon(
                    Icons.home,
                    color: AppColors.mainColor,
                    size: 20,
                  ),
                ),
                HorizontalPadding(
                  percentage: 0.035,
                ),
                Container(
                  width: width/1.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context).translate('delivery_address_'),
                        style: appTextStyle.minTSBasic
                            .copyWith(color: AppColors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      VerticalPadding(
                        percentage: 0.01,
                      ),
                      Text(
                        result.customer_city !=null?result.customer_city!:"",
                        style: appTextStyle.middleTSBasic
                            .copyWith(color: AppColors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      VerticalPadding(
                        percentage: 0.01,
                      ),
                    ],
                  ),

                ),

                // Spacer(),
                // Icon(
                //   Icons.arrow_forward_ios_sharp,
                //   color: AppColors.black,
                //   size: 20,
                // ),

              ],
            ),
          ),
        ),
        VerticalPadding(
          percentage: 0.05,
        ),
        Text(
          AppLocalizations.of(context).translate('order_summary'),
          style: appTextStyle.subBigTSBasicBold.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppTextSize.normal),
          textAlign: TextAlign.start,
        ),
        Container(
          child: Card(
            elevation: 2.0,
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(AppRadius.radiusDefault)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                VerticalPadding(
                  percentage: 0.02,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HorizontalPadding(
                      percentage: 0.05,
                    ),
                    Expanded(child:
                    Text(
                      AppLocalizations.of(context).translate("tax"),
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.black),
                    )
                      ,flex: 1,),
                    Expanded(child:
                    Text(
                      NumberFormat.currency(
                          name: result.curr !=null?result.curr!.sign:"",
                          customPattern: '\u00a4 ###,###')
                          .format(result.tax !=null?double.parse(result.tax!):0),
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.black),
                    )
                      ,flex: 2,),
                    HorizontalPadding(
                      percentage: 0.05,
                    ),
                  ],
                ),
                VerticalPadding(
                  percentage: 0.01,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HorizontalPadding(
                      percentage: 0.05,
                    ),
                    Expanded(child:
                    Text(
                      AppLocalizations.of(context).translate("total"),
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.black),
                    )
                      ,flex: 1,),
                    Expanded(child:
                    Text(
                      NumberFormat.currency(
                          name: result.curr !=null?result.curr!.sign!:"",
                          customPattern: '\u00a4 ###,###')
                          .format(result.total??0),
                      style: appTextStyle.middleTSBasic
                          .copyWith(color: AppColors.black),
                    )
                      ,flex: 2,),
                    HorizontalPadding(
                      percentage: 0.05,
                    ),
                  ],
                ),
                VerticalPadding(
                  percentage: 0.01,
                ),
              ],
            ),
          ),
          decoration: new BoxDecoration(
            borderRadius:
            BorderRadius.all(Radius.circular(AppRadius.radiusDefault)),
            boxShadow: [
              new BoxShadow(
                color: AppColors.light_gray.withOpacity(0.1),
                blurRadius: 1.0,
              ),
            ],
          ),
        ),
        VerticalPadding(
          percentage: 0.05,
        ),
        Text(
          AppLocalizations.of(context).translate('order_overview'),
          style: appTextStyle.subBigTSBasicBold.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppTextSize.normal),
          textAlign: TextAlign.start,
        ),
        result.cart !=null && result.cart!.length>0?SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            controller: _controller,
            
            physics: BouncingScrollPhysics(),
            //controller: ModalScrollController.of(context),
            // physics: const BouncingScrollPhysics(
            //     parent: AlwaysScrollableScrollPhysics()),
            //physics: ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return index >= result.cart!.length
                  ? Container()
                  : Row(
                children: [
                  OrderDetailsWidget(
                    width: width,
                    infoData: result.cart![index],
                  ),
                ],
              );
            },
            itemCount:  result.cart!.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          ),
        )
            :EmptyPageWidget(),
      ],
    ),);
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
    }
  }

}

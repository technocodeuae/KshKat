import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/models/cart/products_cart.dart';
import 'package:erp/ui/globals.dart' as globals;
import 'package:erp/utils/locale/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/repo/user_management_repository.dart';
import '../../../di/components/service_locator.dart';
import '../../../models/home/category_model.dart';
import '../../../utils/routes/routes.dart';
import '../../products/controller/products_controller.dart';
import '../../products/pages/productDetails/argument/ProductDetailsArgument.dart';

class FlashDealsOverviewWidget extends StatefulWidget {
  final LatestProductData? infoData;
  final CancelToken cancelToken;
  final List<Products> cart;
  final String? token;
  final String? address;

  const FlashDealsOverviewWidget({
    Key? key,
    required this.cart,
    required this.infoData,
    required this.cancelToken,
    required this.address,
    required this.token,
  }) : super(key: key);

  @override
  FlashDealsOverviewWidgetState createState() =>
      FlashDealsOverviewWidgetState();
}

class FlashDealsOverviewWidgetState extends State<FlashDealsOverviewWidget> {
  UserManagementRepository _repository = getIt<UserManagementRepository>();
  ProductsController productsController = Get.find();

  Duration? diff = Duration();
  Duration? diffTime = Duration();

  Timer? time;

  void startTime() {
    var targetDate =
        DateFormat("yyyy-M-d").parse(widget.infoData!.discount_date.toString());
    diff = DateTime.now().difference(targetDate);

    time = Timer.periodic(
        Duration(
          seconds: diff!.inSeconds % 60,
          days: diff!.inDays,
          hours: diff!.inHours % 24,
          minutes: diff!.inMinutes % 60,
        ), (timer) {
      setState(() {
        diffTime = DateTime.now().difference(targetDate);
        if (targetDate.isBefore(DateTime.now())) {
          diffTime = Duration();
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    startTime();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    time?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetailsPage,
          arguments: ProductDetailsArgument(
              widget.infoData!.id!, widget.address, widget.token),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(4.sp),
        child: Container(
          padding: EdgeInsets.only(
            top: 8.sp,
            bottom: 8.sp,
            left: Localizations.localeOf(context).languageCode == 'ar'
                ? 0
                : 8.sp,
            right: Localizations.localeOf(context).languageCode == 'ar'
                ? 8.sp
                : 0,
          ),
          // width: MediaQuery.of(context).size.width - (40.sp),
          decoration: BoxDecoration(
            color: AppColors.pinkContainColor.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(4.sp)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate("woo_flash_sale"),
                        style: appTextStyle.middleTSBasic.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 4.sp,
                      ),
                      Text(
                        widget.infoData!.categoryName.toString(),
                        style: appTextStyle.middleTSBasic.copyWith(
                          color: AppColors.textNaveColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCountItem(
                          AppLocalizations.of(context).translate("days"),
                          diffTime!.inDays.abs()),
                      SizedBox(
                        width: 8.sp,
                      ),
                      _buildCountItem(
                          AppLocalizations.of(context).translate("hours"),
                          (diffTime!.inHours.abs() % 24)),
                      SizedBox(
                        width: 8.sp,
                      ),
                      _buildCountItem(
                          AppLocalizations.of(context).translate("minutes"),
                          (diffTime!.inMinutes.abs() % 60)),
                      SizedBox(
                        width: 8.sp,
                      ),
                      _buildCountItem(
                          AppLocalizations.of(context).translate("seconds"),
                          (diffTime!.inSeconds.abs() % 60)),
                    ],
                  ),
                  SizedBox(
                    height: 11.sp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.infoData!.is_discount != null &&
                              widget.infoData!.is_discount == 1
                          ? Container(
                              height: 30.sp,
                              width: 75.sp,
                              decoration: BoxDecoration(
                                color: AppColors.indicatorBGColor
                                    .withOpacity(0.21),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(21.sp),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 3.sp),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "  " +
                                    (widget.infoData!.percent_discount)
                                        .toString() +
                                    "% " +
                                    AppLocalizations.of(context)
                                        .translate("off"),
                                style: appTextStyle.middleTSBasic.copyWith(
                                  color: AppColors.textNaveColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container(),
                      SizedBox(
                        width: 5.sp,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.productDetailsPage,
                            arguments: ProductDetailsArgument(
                                widget.infoData!.id!,
                                widget.address,
                                widget.token),
                          );
                        },
                        child: Container(
                          width: 110.sp,
                          height: 30.sp,
                          // margin: EdgeInsets.symmetric(
                          //   horizontal: 32.sp,
                          // ),
                          padding: EdgeInsets.symmetric(horizontal: 5.sp),
                          decoration: BoxDecoration(
                            color:
                                AppColors.indicatorBGColor.withOpacity(0.21),
                            borderRadius: BorderRadius.all(
                              Radius.circular(21.sp),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)
                                    .translate("shop_now"),
                                style: appTextStyle.bigTSBasic.copyWith(
                                    color: AppColors.textNaveColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: AppTextSize.subBig,
                                    overflow: TextOverflow.ellipsis),
                                softWrap: true,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 18.sp,
                                color: AppColors.textNaveColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 12.sp,
              ),
              Container(
                color: AppColors.transparent,
                width: 107.sp,
                // height: 167.sp,
                child: Image.network(
                  widget.infoData!.photo!,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  //color: widget.infoData!.coming_soon!?AppColors.gray.withOpacity(0.1):AppColors.white,
                  colorBlendMode: BlendMode.modulate,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void minus() async {
    setState(() {
      if (widget.infoData!.qty_in_cart! != 0) {
        //   widget.infoData!.quantity = widget.infoData!.qty_in_cart! - 1;
        for (int i = 0; i < widget.cart.length; i++)
          if (widget.cart[i].id == widget.infoData!.id)
            widget.cart.remove(widget.cart[i]);

        /*  if (widget.infoData!.qty_in_cart!>0)
          {
            Products pro=new Products(
                id:widget.infoData!.id!,
                name:widget.infoData!.name!,
                description: widget.infoData!.description,
                api_image_url:widget.infoData!.api_image_url!,
                listPrice:widget.infoData!.list_price!,
                qty_available:widget.infoData!.qty_available!,
                virtual_available:widget.infoData!.virtual_available!,
                price:widget.infoData!.price!,
                is_discount:widget.infoData!.is_discount!,
                is_comming_soon: widget.infoData!.is_comming_soon!,
                tax:widget.infoData!.tax!,
                disc: widget.infoData!.disc!,
                quantity:widget.infoData!.qty_in_cart!);

            widget.cart.add(pro);
          }*/
      }
    });
    int? num = 0;
    for (int i = 0; i < widget.cart.length; i++)
      num = num! + widget.cart[i].quantity!;
    globals.numCart = num;
    await _repository.saveNumCart(num!);
    await _repository.saveCart(widget.cart);
  }

  Future<void> add() async {
    setState(() {
      /* if(widget.infoData!.quantity ==null) {
        widget.infoData!.quantity=0;
        widget.infoData!.quantity = widget.infoData!.qty_in_cart! + 1;
      } else
        widget.infoData!.quantity=widget.infoData!.qty_in_cart!+1;

      for(int i=0;i<widget.cart.length;i++)
        if(widget.cart[i].id==widget.infoData!.id)
          widget.cart.remove(widget.cart[i]);

      if (widget.infoData!.qty_in_cart!>0)
      {
        Products pro=new Products(
            id:widget.infoData!.id!,
            name:widget.infoData!.name!,
            description: widget.infoData!.description,
            api_image_url:widget.infoData!.api_image_url!,
            listPrice:widget.infoData!.list_price!,
            qty_available:widget.infoData!.qty_available!,
            virtual_available:widget.infoData!.virtual_available!,
            price:widget.infoData!.price!,
            is_comming_soon: widget.infoData!.is_comming_soon!,
            tax:widget.infoData!.tax!,
            disc: widget.infoData!.disc!,
            is_discount:widget.infoData!.is_discount!,
            quantity:widget.infoData!.qty_in_cart!);

        widget.cart.add(pro);
      }*/
    });

    int? num = 0;
    for (int i = 0; i < widget.cart.length; i++)
      num = num! + widget.cart[i].quantity!;
    globals.numCart = num;
    await _repository.saveNumCart(num!);
    await _repository.saveCart(widget.cart);
  }

  _buildCountItem(String name, int num) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 40.sp,
          width: 40.sp,
          decoration: BoxDecoration(
            color: AppColors.indicatorBGColor.withOpacity(0.21),
            borderRadius: BorderRadius.all(
              Radius.circular(15.sp),
            ),
          ),
          child: Center(
            child: Text(
              (num.toString()),
              style: appTextStyle.middleTSBasic.copyWith(
                color: AppColors.darkRed,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        SizedBox(
          height: 8.sp,
        ),
        Text(
          name.toString(),
          style: appTextStyle.subMinTSBasic.copyWith(
            color: AppColors.textNaveColor,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}

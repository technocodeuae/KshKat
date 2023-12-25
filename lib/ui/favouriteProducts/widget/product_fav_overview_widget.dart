import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/ui/globals.dart' as globals;

import '../../../data/repo/user_management_repository.dart';
import '../../../di/components/service_locator.dart';
import '../../../models/home/products_fav_model.dart';
import '../../../utils/routes/routes.dart';
import '../../products/controller/products_controller.dart';
import '../../products/pages/productDetails/argument/ProductDetailsArgument.dart';

class ProductFavOverviewWidget extends StatefulWidget {
  final double width;
  final ProductsData? infoData;
  final CancelToken cancelToken;
  final String? token;
  final String? address;

  const ProductFavOverviewWidget({
    Key? key,
    required this.width,
    required this.infoData,
    required this.cancelToken,
    required this.address,
    required this.token,
  }) : super(key: key);

  @override
  ProductFavOverviewWidgetState createState() =>
      ProductFavOverviewWidgetState();
}

class ProductFavOverviewWidgetState extends State<ProductFavOverviewWidget> {
  ProductsController productsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("phhhhhhhhhhhhhhhhhhhhhhhhhhhh     ${widget.infoData!.photo!}");
        Navigator.pushNamed(
          context,
          Routes.productDetailsPage,
          arguments: ProductDetailsArgument(
              widget.infoData!.id!, widget.address, widget.token),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(4.sp),
        child: Stack(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.productDetailsPage,
                  arguments: ProductDetailsArgument(
                      widget.infoData!.id!, widget.address, widget.token),
                );
              },
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.44, // 175.sp,
                  height: 190.sp,
                  padding: EdgeInsets.only(
                    bottom: 2.sp,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mainContainColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.sp),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          color: AppColors.transparent,
                          width: double.infinity,
                          height: 116.sp,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12.sp),
                              topRight: Radius.circular(12.sp),
                            ),
                            // : null,
                            child: Image.network(
                              widget.infoData!.photo!,
                              fit: BoxFit.fill,
                              //color: widget.infoData!.coming_soon!?AppColors.gray.withOpacity(0.1):AppColors.white,
                              colorBlendMode: BlendMode.modulate,
                              // headers: {'Referer': 'https://test.mm8market.com'},
                            ),
                          ),
                        ),
                      ),

                      // if(widget.infoData!.is_discount!=null&&!(widget.infoData!.is_discount==1))
                      //   Container(
                      //     //   height: 20,
                      //     child:
                      //     Text(
                      //       NumberFormat.currency(
                      //           name: widget.infoData!.curr!.sign!,
                      //           customPattern: '\u00a4 ###,###')
                      //           .format(widget.infoData!.price!).replaceAll(".00", ""),
                      //       style: appTextStyle.minTSBasic.copyWith(
                      //         color: AppColors.black,
                      //         fontWeight: FontWeight.bold,
                      //         decorationStyle:
                      //         TextDecorationStyle.solid,
                      //       ),
                      //       textAlign: TextAlign.start,
                      //     ),
                      //   ),

                      SizedBox(
                        height: 4.sp,
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            right: 12.sp, top: 12.sp, left: 12.sp),
                        child: Column(
                          children: [
                            Text(
                              widget.infoData!.name!,
                              style: appTextStyle.subMinTSBasic.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.normal,
                                  overflow: TextOverflow.ellipsis),
                              softWrap: true,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 4.sp,
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    widget.infoData!.is_discount != null &&
                                            widget.infoData!.is_discount == 1
                                        ? Column(
                                            children: [
                                              Text(
                                                NumberFormat.currency(
                                                        name: widget.infoData!
                                                            .curr!.sign!,
                                                        customPattern:
                                                            '\u00a4 ###,###')
                                                    .format(widget
                                                        .infoData!.price!)
                                                    .replaceAll(".00", ""),
                                                style: appTextStyle
                                                    .subMinTSBasic
                                                    .copyWith(
                                                        color:
                                                            AppColors.mainRed,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text(
                                                NumberFormat.currency(
                                                        name: widget.infoData!
                                                            .curr!.sign!,
                                                        customPattern:
                                                            '\u00a4 ###,###')
                                                    .format(widget.infoData!
                                                        .previous_price!)
                                                    .replaceAll(".00", ""),
                                                style: appTextStyle
                                                    .subMinTSBasic
                                                    .copyWith(
                                                  color: AppColors.black,
                                                  fontWeight:
                                                      FontWeight.normal,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  decorationColor: Colors.red,
                                                  decorationStyle:
                                                      TextDecorationStyle
                                                          .solid,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )
                                        : Text(
                                            widget.infoData!.price
                                                    .toString() +
                                                " " +
                                                widget.infoData!.curr!.sign
                                                    .toString(),
                                            style: appTextStyle.subMinTSBasic
                                                .copyWith(
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                            softWrap: true,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                          ),
                                  ],
                                ),
                                Container(
                                  height: 30.sp,
                                  width: 30.sp,
                                  color: AppColors.transparent,
                                  child: Container(
                                    height: 19.sp,
                                    width: 19.sp,
                                    decoration: BoxDecoration(
                                      color: AppColors.mainContainColor,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.sp),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add_shopping_cart_outlined,
                                        color:
                                            AppColors.secondaryContainColor,
                                        size: 19.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
            Positioned.fill(
              top: 12.sp,
              left: Localizations.localeOf(context).languageCode == 'ar'
                  ? 12.sp
                  : 0,
              right: Localizations.localeOf(context).languageCode == 'ar'
                  ? 0
                  : 12.sp,
              child: Align(
                alignment:
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? Alignment.topLeft
                        : Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    if (widget.infoData!.is_Fav!) {
                      productsController.deleteFav(
                          widget.cancelToken, widget.infoData!.id!);
                      setState(() {
                        widget.infoData!.is_Fav = false;
                      });
                    } else {
                      productsController.addFav(
                          widget.cancelToken, widget.infoData!.id!);
                      setState(() {
                        widget.infoData!.is_Fav = true;
                      });
                    }
                  },
                  child: Container(
                    //    height: 20,
                    // alignment: Alignment.center,
                    child: Icon(
                      widget.infoData!.is_Fav!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.indicatorBGColor,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),
            ),
            if (widget.infoData!.is_discount != null &&
                widget.infoData!.is_discount == 1)
              Container(
                height: 20.sp,
                width: 30.sp,
                decoration: BoxDecoration(
                  color: AppColors.indicatorBGColor.withOpacity(0.21),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.sp),
                  ),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  "  " + (widget.infoData!.percent_discount).toString() + "%",
                  style: appTextStyle.subMinTSBasic.copyWith(
                    color: AppColors.mainRed,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
      /* Column(
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppRadius.radius8)),
              child: Stack(
                children: [
                  Container(
                    color: AppColors.white,
                    width: widget.width / 2.5,
                    height: widget.width / 3.27,
                    child: Image.network(
                      widget.infoData!.photo!,
                      fit: BoxFit.fill,
                      color: widget.infoData!.coming_soon!
                          ? AppColors.gray.withOpacity(0.1)
                          : AppColors.white,
                      colorBlendMode: BlendMode.modulate,
                    ),
                  ),
                  if (widget.infoData!.is_discount!)
                    Container(
                      height: 25,
                      width: 35,
                      color: AppColors.mainRed,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "  " + (widget.infoData!.percent_discount).toString(),
                        style: appTextStyle.subMinTSBasic.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  /*  if (!widget.infoData!.coming_soon!)
                  new Positioned(
                  bottom: 0,
                  right: 0,
                  child:
                  Padding(padding: const EdgeInsets.only(right: AppDimens.space6,
                  bottom: AppDimens.space6),
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            width: 1.0,
                            color:AppColors.white,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            if(widget.infoData!.quantity !=null && widget.infoData!.quantity!>0)
                            InkWell(
                                onTap: () {
                                  if(widget.token == null)
                                    showDialog(
                                        context: context, builder: (context) => SignUpDialog());
                                  else if(widget.address ==null)
                                    showDialog(
                                        context: context, builder: (context) => AddressDialog());
                                  else
                                    minus();
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.mainColor,
                                  size: 25,
                                )),
                            if(widget.infoData!.quantity !=null && widget.infoData!.quantity!>0)
                              Container(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.white),
                              child: Text(
                                widget.infoData!.quantity!.toString(),
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ),
                              InkWell(
                                onTap: () {
                                  if(widget.token == null)
                                    showDialog(
                                        context: context, builder: (context) => SignUpDialog());
                                  else if(widget.address ==null)
                                    showDialog(
                                        context: context, builder: (context) => AddressDialog());
                                  else
                                      add();

                                },
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.mainColor,
                                  size: 25,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),)
                ),*/
                ],
              ),
            ),
            if (widget.infoData!.is_discount!)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //   height: 20,
                    child: Text(
                      NumberFormat.currency(
                              name: widget.infoData!.curr!.sign!,
                              customPattern: '\u00a4 ###,###')
                          .format(widget.infoData!.previous_price!)
                          .replaceAll(".00", ""),
                      style: appTextStyle.minTSBasic.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    //      height: 20,
                    child: Text(
                      NumberFormat.currency(
                              name: widget.infoData!.curr!.sign!,
                              customPattern: '\u00a4 ###,###')
                          .format(widget.infoData!.price!)
                          .replaceAll(".00", ""),
                      style: appTextStyle.minTSBasic.copyWith(
                        color: AppColors.mainRed,
                        fontWeight: FontWeight.bold,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            if (!widget.infoData!.is_discount!)
              Container(
                //  height: 20,
                child: Text(
                  NumberFormat.currency(
                          name: widget.infoData!.curr!.sign!,
                          customPattern: '\u00a4 ###,###')
                      .format(widget.infoData!.price!)
                      .replaceAll(".00", ""),
                  style: appTextStyle.minTSBasic.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    decorationStyle: TextDecorationStyle.solid,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            InkWell(
              onTap: () {
                if (widget.infoData!.is_Fav!) {
                  productsController.deleteFav(
                      widget.cancelToken, widget.infoData!.id!);
                  setState(() {
                    widget.infoData!.is_Fav = false;
                  });
                } else {
                  productsController.addFav(
                      widget.cancelToken, widget.infoData!.id!);
                  setState(() {
                    widget.infoData!.is_Fav = true;
                  });
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //  height: 20,
                    width: widget.width * 0.25,
                    alignment: Alignment.center,
                    child: Text(
                      widget.infoData!.name!,
                      style: appTextStyle.middleTSBasic.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                      softWrap: true,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    //  height: 20,
                    alignment: Alignment.center,
                    child: Icon(
                      widget.infoData!.is_Fav!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.mainRed,
                      size: 20,
                    ),
                  ),
                ],
              ),
            )
          ],
        )*/
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/models/cart/products_cart.dart';
import 'package:erp/models/home/products_model.dart';
import 'package:erp/ui/globals.dart' as globals;
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/widgets/dialog/address_dialog.dart';

import '../../../data/repo/user_management_repository.dart';
import '../../../di/components/service_locator.dart';
import '../../../models/home/category_model.dart';
import '../../../utils/routes/routes.dart';
import '../../../widgets/dialog/signup_dialog.dart';
import '../../products/controller/products_controller.dart';
import '../../products/pages/productDetails/argument/ProductDetailsArgument.dart';

class LatestOverviewWidget extends StatefulWidget {
  final LatestProductData? infoData;
  final CancelToken cancelToken;
  final List<Products> cart;
  final String? token;
  final String? address;
  final bool isAllProduct;

  const LatestOverviewWidget({
    Key? key,
    required this.cart,
    this.isAllProduct = true, 
    required this.infoData,
    required this.cancelToken,
    required this.address,
    required this.token,
  }) : super(key: key);

  @override
  LatestOverviewWidgetState createState() => LatestOverviewWidgetState();
}

class LatestOverviewWidgetState extends State<LatestOverviewWidget> {
  UserManagementRepository _repository = getIt<UserManagementRepository>();
  ProductsController productsController = Get.find();

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
                  padding: widget.isAllProduct
                      ? EdgeInsets.only(
                          bottom: 2.sp,
                        )
                      : EdgeInsets.symmetric(
                          vertical: 8.sp, horizontal: 16.sp),
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
                          width:
                              widget.isAllProduct ? double.infinity : 108.sp,
                          height: 116.sp,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  widget.isAllProduct ? 12.sp : 0),
                              topRight: Radius.circular(
                                  widget.isAllProduct ? 12.sp : 0),
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
                        padding: widget.isAllProduct
                            ? EdgeInsets.only(
                                right: 12.sp, top: 12.sp, left: 12.sp)
                            : EdgeInsets.zero,
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
                                                    .toString()! +
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.infoData!.averageRating
                                                  .toString()! +
                                              " ",
                                          style: appTextStyle.subMinTSBasic
                                              .copyWith(
                                                  color: AppColors.black,
                                                  fontWeight:
                                                      FontWeight.normal,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                          softWrap: true,
                                          maxLines: 1,
                                          textAlign: TextAlign.center,
                                        ),
                                        Container(
                                          child: RatingBarIndicator(
                                            rating: widget
                                                    .infoData?.averageRating
                                                    .toDouble() ??
                                                0,
                                            itemCount: 5,
                                            itemSize: 12.sp,
                                            unratedColor:
                                                AppColors.darkGrayColor,
                                            direction: Axis.horizontal,
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              size: 12.sp,
                                              color: AppColors
                                                  .secondaryContainColor,
                                            ),
                                          ),
                                        ),
                                      ],
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
              top: 8.sp,
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
}

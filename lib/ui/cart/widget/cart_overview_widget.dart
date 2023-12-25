import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';

import '../../../common/widgets/horizontal_padding.dart';
import '../../../data/repo/user_management_repository.dart';
import '../../../di/components/service_locator.dart';
import '../../../models/cart/cart_model.dart';
import '../../../models/cart/products_cart.dart';
import '../controller/cart_controller.dart';

class CartOverviewWidget extends StatefulWidget {
  final double width;
  final ItemsData? infoData;
  final int index;
  final VoidCallback callback;
  final cancelToken;
  final int cartId;
  final lang;
  const CartOverviewWidget({
    Key? key,
    required this.width,
    required this.index,
    required this.cartId,
    required this.infoData,
    required this.callback,
    required this.cancelToken,
    required this.lang,
  }) : super(key: key);

  @override
  CartOverviewWidgetState createState() => CartOverviewWidgetState();
}

class CartOverviewWidgetState extends State<CartOverviewWidget> {
  CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.only(
          left: AppDimens.space2, right: AppDimens.space2),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
        child: Card(
          color: AppColors.white,
          shadowColor: AppColors.mainGray.withOpacity(0.6),
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppRadius.radius10))),
          child: Container(
            width: widget.width,
            padding: const EdgeInsets.all(AppDimens.space16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(AppRadius.radius8)),
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Image.network(
                      widget.infoData!.photo!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                HorizontalPadding(
                  percentage: 0.035,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        NumberFormat.currency(
                                name: widget.infoData!.curr!.sign!,
                                customPattern: '\u00a4 ###,###')
                            .format(widget.infoData!.is_discount!
                                ? widget.infoData!.price
                                : widget.infoData!.price),
                        style: appTextStyle.minTSBasic
                            .copyWith(color: AppColors.black),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      VerticalPadding(
                        percentage: 0.01,
                      ),
                      Text(
                        widget.infoData!.product_name!,
                        style: appTextStyle.middleTSBasic
                            .copyWith(color: AppColors.gray),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      VerticalPadding(
                        percentage: 0.01,
                      ),
                      for (int i = 0;
                          i < widget.infoData!.attributes_info!.length;
                          i++)
                        Column(
                          children: [
                            Text(
                              '${widget.infoData!.attributes_info![i].attribute_name} : ${widget.infoData!.attributes_info![i].attribute_value}',
                              style: appTextStyle.middleTSBasic
                                  .copyWith(color: AppColors.gray),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            VerticalPadding(
                              percentage: 0.01,
                            ),
                          ],
                        )
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            width: 1.0,
                            color: AppColors.white,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (widget.infoData!.qty_in_cart !=
                                    null && /*int.parse(*/
                                widget.infoData!.qty_in_cart! > 0)
                              InkWell(
                                  onTap: () {
                                    // minus();
                                    cartController.addMinusProduct(
                                        widget.cancelToken,
                                        widget.cartId,
                                        widget.infoData!.product_id!,
                                        '-',
                                        widget.lang);
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: AppColors.mainColor,
                                    size: 25,
                                  )),
                            if (widget.infoData!.qty_in_cart != null &&
                                widget.infoData!.qty_in_cart! > 0)
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3, vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.white),
                                child: Text(
                                  widget.infoData!.qty_in_cart!.toString(),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            InkWell(
                                onTap: () {
                                  cartController.addMinusProduct(
                                      widget.cancelToken,
                                      widget.cartId,
                                      widget.infoData!.product_id!,
                                      '+',
                                      widget.lang);
                                },
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.mainColor,
                                  size: 25,
                                )),
                          ],
                        ),
                      ),
                      VerticalPadding(
                        percentage: 0.01,
                      ),
                      InkWell(
                        onTap: () {
                          cartController.clearCart(widget.cancelToken,
                              widget.infoData!.cart_item_id!, widget.lang);
                        },
                        child: Icon(
                          Icons.delete,
                          color: AppColors.mainRed,
                          size: 25,
                        ),
                      ),
                      VerticalPadding(
                        percentage: 0.01,
                      ),
                    ],
                  ),
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void minus() async {
    setState(() {
      if (widget.infoData!.qty_in_cart! != 0) {
        int q = widget.infoData!.qty_in_cart! - 1;
        widget.infoData!.qty_in_cart = q;
      }
    });

    //   widget.callback();
  }

  Future<void> add() async {
    setState(() {
      if (widget.infoData!.qty_in_cart == null) {
        widget.infoData!.qty_in_cart = 0;
        int q = widget.infoData!.qty_in_cart! + 1;
        widget.infoData!.qty_in_cart = q;
      } else {
        int q = widget.infoData!.qty_in_cart! + 1;
        widget.infoData!.qty_in_cart = q;
      }
    });

    //widget.callback();
  }
}

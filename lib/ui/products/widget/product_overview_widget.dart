import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/models/cart/products_cart.dart';
import 'package:erp/models/home/products_model.dart';
import 'package:erp/ui/globals.dart' as globals;
import 'package:erp/utils/locale/app_localization.dart';
import 'package:erp/widgets/dialog/address_dialog.dart';

import '../../../data/repo/user_management_repository.dart';
import '../../../di/components/service_locator.dart';
import '../../../utils/routes/routes.dart';
import '../../../widgets/dialog/signup_dialog.dart';
import '../pages/productDetails/argument/ProductDetailsArgument.dart';

class ProductOverviewWidget extends StatefulWidget {
  final double width;
  final DataData? infoData;
  final CancelToken cancelToken;
  final List<Products> cart;
  final String? token;
  final String? address;

  const ProductOverviewWidget({
    Key? key,
    required this.cart,
    required this.width,
    required this.infoData,
    required this.cancelToken,
    required this.address,
    required this.token,
  }) : super(key: key);

  @override
  ProductOverviewWidgetState createState() => ProductOverviewWidgetState();
}

class ProductOverviewWidgetState extends State<ProductOverviewWidget> {

  UserManagementRepository _repository = getIt<UserManagementRepository>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetailsPage,
          arguments: ProductDetailsArgument(widget.infoData!.id!,widget.address,widget.token),
        );
      },
      child:Column(
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(AppRadius.radius8)),
            child: Stack(
              children: [
                Container(
                  color: AppColors.white,
                  width: widget.width / 2.5,
                  height: widget.width/3.27,
                  child: Image.network(
                    widget.infoData!.photo!,
                    fit: BoxFit.fill,
                    color: widget.infoData!.coming_soon!?AppColors.gray.withOpacity(0.1):AppColors.white,
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
                if(widget.infoData!.is_discount!)
                Container(
              //    height: 25,
                  width: 35,
                  color: AppColors.mainRed,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  "+(widget.infoData!.percent_discount).toString(),
                    style: appTextStyle.subMinTSBasic.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
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
          if(widget.infoData!.is_discount!)
            Row(
              children: [
                Container(
               //   height: 20,
                  child:
                  Text(
                    NumberFormat.currency(
                        name: widget.infoData!.curr!.sign!,
                        customPattern: '\u00a4 ###,###')
                        .format(widget.infoData!.previous_price!).replaceAll(".00", ""),
                    style: appTextStyle.minTSBasic.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      decoration:  TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                      decorationStyle:
                      TextDecorationStyle.solid,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),

                Container(
              //    height: 20,
                  child:  Text(
                    NumberFormat.currency(
                        name: widget.infoData!.curr!.sign!,
                        customPattern: '\u00a4 ###,###')
                        .format(widget.infoData!.price!).replaceAll(".00", ""),
                    style: appTextStyle.minTSBasic.copyWith(
                      color: AppColors.mainRed,
                      fontWeight: FontWeight.bold,
                      decorationStyle:
                      TextDecorationStyle.solid,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          if(!widget.infoData!.is_discount!)
            Container(
            //  height: 20,
              child:
              Text(
                NumberFormat.currency(
                    name: widget.infoData!.curr!.sign!,
                    customPattern: '\u00a4 ###,###')
                    .format(widget.infoData!.price!).replaceAll(".00", ""),
                style: appTextStyle.minTSBasic.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  decorationStyle:
                  TextDecorationStyle.solid,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
              ),
            ),

          InkWell(
            onTap: () {

            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                //  height: 20,
                  width: widget.width*0.25,
                  alignment: Alignment.center,
                  child: Text(
                    widget.infoData!.name!,
                    style: appTextStyle.middleTSBasic.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis
                    ),
                    softWrap: true,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
             //     height: 20,
                  alignment: Alignment.center,
                  child:  Icon(
                    widget.infoData!.is_Fav!?Icons.favorite:
                    Icons.favorite_border,
                    color: AppColors.mainRed,
                    size: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  void minus() async {
    setState(()  {
      if (widget.infoData!.quantity! != 0) {
        widget.infoData!.quantity = widget.infoData!.quantity! - 1;
        for(int i=0;i<widget.cart.length;i++)
          if(widget.cart[i].id==widget.infoData!.id)
            widget.cart.remove(widget.cart[i]);

        if (widget.infoData!.quantity!>0)
          {

          }

      }
    });
    int? num=0;
    for(int i=0;i<widget.cart.length;i++)
      num=num! + widget.cart[i].quantity!;
    globals.numCart=num;
    await _repository.saveNumCart(num!);
    await _repository.saveCart(widget.cart);

  }

  Future<void> add() async {
    setState(() {
      if(widget.infoData!.quantity ==null) {
        widget.infoData!.quantity=0;
        widget.infoData!.quantity = widget.infoData!.quantity! + 1;
      } else
        widget.infoData!.quantity=widget.infoData!.quantity!+1;

      for(int i=0;i<widget.cart.length;i++)
        if(widget.cart[i].id==widget.infoData!.id)
          widget.cart.remove(widget.cart[i]);


    });

    int? num=0;
    for(int i=0;i<widget.cart.length;i++)
      num=num! + widget.cart[i].quantity!;
    globals.numCart=num;
    await _repository.saveNumCart(num!);
    await _repository.saveCart(widget.cart);

  }

}

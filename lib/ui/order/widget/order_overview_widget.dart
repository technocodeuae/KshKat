import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/models/order/order_model.dart';
import 'package:erp/utils/locale/app_localization.dart';

import '../../../utils/routes/routes.dart';
import '../orderDetails/argument/OrderArgument.dart';


class OrderOverviewWidget extends StatefulWidget {
  final double width;
  final OrderData? infoData;
  final CancelToken cancelToken;

  const OrderOverviewWidget({
    Key? key,
    required this.width,
    required this.infoData,
    required this.cancelToken,
  }) : super(key: key);

  @override
  OrderOverviewWidgetState createState() => OrderOverviewWidgetState();
}

class OrderOverviewWidgetState extends State<OrderOverviewWidget>
    with SingleTickerProviderStateMixin{
  TextEditingController _textFieldController = TextEditingController();
  var formatterDate = DateFormat('dd/MM/yyyy');
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    var formatCurrency = new NumberFormat.simpleCurrency(
        name: AppLocalizations.of(context).translate('sy'));
    _textFieldController.text = "0";
    return
      InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.orderDetailsPage,
            arguments: OrderArgument(widget.infoData!.id!),
          );
        }, // Handle your callback
        child:   Container(
          width: widget.width,
          padding: const EdgeInsets.only(
              left: AppDimens.space2, right: AppDimens.space2),
          child:  Padding(
            padding: const EdgeInsets.only(top:5,right: 10,left: 10),
            child: Container(
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
                      children: <Widget>[
                        Expanded(
                            child: Container(
                              padding:
                              const EdgeInsets.all(AppDimens.space4),
                              width: MediaQuery.of(context).size.width *
                                  0.35,
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                widget.infoData!.status??'',
                                style: appTextStyle.minTSBasic.copyWith(
                                  color:AppColors.mainRed,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )),
                        Spacer(),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(AppDimens.space4),
                            width: MediaQuery.of(context).size.width * 0.35,
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              NumberFormat.currency(
                                  name:'AED',// widget.infoData!.curr?.sign,
                                  customPattern: '\u00a4 ###,###')
                                  .format(double.parse(widget.infoData!.total!.toString())),//pay_amount
                              style: appTextStyle.minTSBasic.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      widget.infoData!.text_payment!,
                      style: appTextStyle.smallTSBasic.copyWith(
                          color: AppColors.dark_green,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      width: widget.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppRadius.radiusDefault)),
                      ),
                      child: Card(
                        elevation: 2.0,
                        color: AppColors.light_gray,
                        shadowColor: AppColors.gray.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppRadius.radiusDefault)),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          width: widget.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(AppRadius.radiusDefault)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('order_date'),
                                          style:
                                          appTextStyle.subMinTSBasic.copyWith(
                                            color: AppColors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  Expanded(
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('count_order_cart'),
                                          style:
                                          appTextStyle.subMinTSBasic.copyWith(
                                            color: AppColors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  Expanded(
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('count_order'),
                                          style:
                                          appTextStyle.subMinTSBasic.copyWith(
                                            color: AppColors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                ],
                              ),
                              VerticalPadding(
                                percentage: 0.02,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(widget.infoData!.created_at!.substring(0,10)
                                          // widget.infoData!
                                          //     .timestamp_update! >
                                          //     0
                                          //     ? formatterDate.format(new DateTime
                                          //     .fromMillisecondsSinceEpoch(
                                          //     widget.infoData!
                                          //         .timestamp_update!))
                                          //     : ""
                                              ,
                                          style:
                                          appTextStyle.subMinTSBasic.copyWith(
                                            color: AppColors.purple,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  Expanded(
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          widget.infoData!.Qty.toString(),
                                          style:
                                          appTextStyle.subMinTSBasic.copyWith(
                                            color: AppColors.purple,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                  Expanded(
                                      child: Container(
                                        alignment: AlignmentDirectional.center,
                                        child: Text(
                                          widget.infoData!.totalQty!.toString(),
                                          style:
                                          appTextStyle.subMinTSBasic.copyWith(
                                            color: AppColors.purple,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
                    color: AppColors.gray.withOpacity(0.1),
                    blurRadius: 1.0,
                  ),
                ],
              ),
            ),
          ),
        ),

      );

  }

}

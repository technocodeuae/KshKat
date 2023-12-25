import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import '../../../../common/widgets/vertical_padding.dart';
import '../../../../constants/app_dimens.dart';
import '../../../../constants/app_radius.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/text_style.dart';
import '../../../../models/order/order_details_model.dart';
import '../../../../models/order/order_model.dart';
import '../../../../utils/locale/app_localization.dart';

class OrderDetailsWidget extends StatefulWidget {
  final double width;
  final CartData? infoData;

  const OrderDetailsWidget({
    Key? key,
    required this.width,
    required this.infoData,
  }) : super(key: key);

  @override
  OrderDetailsWidgetState createState() => OrderDetailsWidgetState();
}

class OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: Duration(milliseconds: 500),
      duration: Duration(milliseconds: 300),
      animate: true,
      child: Container(
        width: widget.width - widget.width / 20,
        padding: const EdgeInsets.only(
            left: AppDimens.space10, right: AppDimens.space10),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
          child: Container(
            child: Card(
              elevation: 2.0,
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(AppRadius.radiusDefault)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  VerticalPadding(
                    percentage: 0.02,
                  ),
                  Text(
                    widget.infoData!.product_name!,
                    style: appTextStyle.smallTSBasic.copyWith(
                        color: AppColors.dark_green,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Text(
                        '${widget.infoData!.attributes_info![index].attribute_name} : ${widget.infoData!.attributes_info![index].attribute_value}',
                        textAlign: TextAlign.center,
                          style: appTextStyle.smallTSBasic.copyWith(
                        color: AppColors.dark_green,
                        fontWeight: FontWeight.bold),
                      );
                    },
                    itemCount: widget.infoData!.attributes_info!.length,
                  ),
                  Container(
                      alignment: AlignmentDirectional.center,
                      padding: EdgeInsets.only(left: 35, right: 35),
                      child: widget.infoData!.text != null
                          ? Text('')
                          : Html(
                              data: '''${widget.infoData!.text!.toString()}''')
                      //  Text(
                      //   2
                      //   widget.infoData!.text !=null?widget.infoData!.text!:"",
                      //   style: appTextStyle.minTSBasic.copyWith(
                      //     color: AppColors.gray,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
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
                      shadowColor: AppColors.light_gray.withOpacity(0.5),
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
                                        .translate('product_count'),
                                    style: appTextStyle.subMinTSBasic.copyWith(
                                      color: AppColors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                                /* Expanded(
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('tax'),
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
                                            .translate('total'),
                                        style:
                                        appTextStyle.subMinTSBasic.copyWith(
                                          color: AppColors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),*/
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
                                  child: Text(
                                    widget.infoData!.quantity!.toString() +
                                        " x " +
                                        NumberFormat.currency(
                                                name: 'AED',
                                                customPattern: '\u00a4 ###,###')
                                            .format(double.parse(
                                                widget.infoData!.price!)),
                                    style: appTextStyle.subMinTSBasic.copyWith(
                                      color: AppColors.purple,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                                /*  Expanded(
                                    child: Container(
                                      alignment: AlignmentDirectional.center,
                                      child: Text(
                                        NumberFormat.currency(
                                            name: 'AED',
                                            customPattern: '\u00a4 ###,###')
                                            .format(0),
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
                                        NumberFormat.currency(
                                            name: '€',
                                            customPattern: '\u00a4 ###,###')
                                            .format(widget.infoData!.price_total),
                                        style:
                                        appTextStyle.subMinTSBasic.copyWith(
                                          color: AppColors.purple,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),*/
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  VerticalPadding(
                    percentage: 0.05,
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
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/models/home/category_model.dart';
import 'package:erp/utils/locale/app_localization.dart';

import '../../../models/cart/products_cart.dart';
import '../../../../../utils/routes/routes.dart';
import '../../../models/home/products_model.dart';
import '../../products/argument/ProductsArgument.dart';

class CategorySubOverviewWidget extends StatefulWidget {
  final double width;
  final SubsData infoData;
  final CancelToken cancelToken;
  final String? token;
  final String? address;

  const CategorySubOverviewWidget({
    Key? key,
    required this.width,
    required this.infoData,
    required this.cancelToken,
    required this.address,
    required this.token,
  }) : super(key: key);

  @override
  CategorySubOverviewWidgetState createState() => CategorySubOverviewWidgetState();
}

class CategorySubOverviewWidgetState extends State<CategorySubOverviewWidget> {
  TextEditingController _textFieldController = TextEditingController();
  var formatterDate = DateFormat('dd/MM/yyyy');


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formatCurrency = new NumberFormat.simpleCurrency(
        name: AppLocalizations.of(context).translate('sy'));
    _textFieldController.text = "0";
    return InkWell(
      onTap: () {

      },
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.radius8)),
        child: Stack(
          children: [
           /* Container(
              width: widget.width / 3.5,
              height: widget.width,
              child: Image.network(
                widget.infoData.photo!,
                fit: BoxFit.fill,
              ),
            ),*/
            Container(
              width: widget.width / 3.5,
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 5),
              child: Text(
                widget.infoData.name!,
                style: appTextStyle.smallTSBasic.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

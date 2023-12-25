import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/models/home/category_model.dart';
import 'package:erp/utils/locale/app_localization.dart';

import '../../../models/cart/products_cart.dart';
import '../../../../../utils/routes/routes.dart';
import '../../products/argument/ProductsArgument.dart';
import '../argument/sub_product_argument.dart';
import '../pages/sub_category_product_page.dart';

class CategoryOverviewWidget extends StatefulWidget {
  final CategoriesData infoData;
  final CancelToken cancelToken;
  final List<CategoriesData> data;
  final List<Products> cart;
  final int index;
  final String? token;
  final String? address;
  final bool isCatrgoriesPage;
  final Function()? onTap;

  const CategoryOverviewWidget({
    Key? key,
    this.isCatrgoriesPage = false,
    this.onTap,
    required this.infoData,
    required this.cancelToken,
    required this.data,
    required this.cart,
    required this.index,
    required this.address,
    required this.token,
  }) : super(key: key);

  @override
  CategoryOverviewWidgetState createState() => CategoryOverviewWidgetState();
}

class CategoryOverviewWidgetState extends State<CategoryOverviewWidget> {
  TextEditingController _textFieldController = TextEditingController();
  var formatterDate = DateFormat('dd/MM/yyyy');
  late CategoriesData infoData;

  @override
  void initState() {
    super.initState();
    this.infoData = widget.infoData;
  }

  @override
  Widget build(BuildContext context) {
    var formatCurrency = new NumberFormat.simpleCurrency(
        name: AppLocalizations.of(context).translate('sy'));
    _textFieldController.text = "0";
    return InkWell(
        onTap: () {
          if (!widget.isCatrgoriesPage) {
            Navigator.pushNamed(
              context,
              Routes.subProductsPage,
              arguments: SubArgument(widget.infoData.name,
                  widget.infoData.id!, widget.address, widget.token),
            );
          } else {
            widget.onTap!();
          }
        },
        child: Container(
          height: 71.sp,
          width: 71.sp,
          padding: EdgeInsets.all(4.sp),
          // decoration: BoxDecoration(
          //     shape: BoxShape.circle, color: AppColors.mainContainColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30.sp,
                height: 30.sp,
                child: widget.infoData.photo!.substring(
                            widget.infoData.photo!.length - 4,
                            widget.infoData.photo!.length) ==
                        '.svg'
                    ? SvgPicture.network(
                        widget.infoData.photo!,
                        fit: BoxFit.cover,
                        width: 30.sp,
                        height: 30.sp,
                      )
                    : Image.network(
                        widget.infoData.photo!,
                        fit: BoxFit.cover,
                        width: 30.sp,
                        height: 30.sp,
                        // headers: {'Referer': 'http://tas-jeel.com'},
                      ),
              ),
              SizedBox(
                height: 4.sp,
              ),
              Text(
                widget.infoData.name!,
                style: appTextStyle.sub2MinTSBasic.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}

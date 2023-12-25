import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:erp/common/widgets/horizontal_padding.dart';
import 'package:erp/common/widgets/vertical_padding.dart';
import 'package:erp/constants/app_constants.dart';
import 'package:erp/models/address/address_model.dart';
import 'package:erp/utils/locale/app_localization.dart';

import '../../../../../data/repo/user_management_repository.dart';
import '../../../../../di/components/service_locator.dart';
import '../../../../../utils/routes/routes.dart';
import '../../checkout/argument/CheckoutArgument.dart';
import '../../splash/argument/GlobalArgument.dart';

class AddressOverviewWidget extends StatefulWidget {
  final double width;
  final Data? infoData;
  final String? token;
  final int? numCart;
  final CancelToken cancelToken;
  final bool isFromCheckout;
  final CheckoutArgument arg;
  final String? currentAddres;

  const AddressOverviewWidget({
    Key? key,
    required this.width,
    required this.arg,
    this.currentAddres,
    required this.isFromCheckout,
    required this.token,
    required this.numCart,
    required this.infoData,
    required this.cancelToken,
  }) : super(key: key);

  @override
  AddressOverviewWidgetState createState() => AddressOverviewWidgetState();
}

class AddressOverviewWidgetState extends State<AddressOverviewWidget> {
  TextEditingController _textFieldController = TextEditingController();
  var formatterDate = DateFormat('dd/MM/yyyy');

  UserManagementRepository _repository = getIt<UserManagementRepository>();

  @override
  Widget build(BuildContext context) {
    var formatCurrency = new NumberFormat.simpleCurrency(
        name: AppLocalizations.of(context).translate('sy'));
    _textFieldController.text = "0";
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.space20, vertical: AppDimens.space2),
      child: InkWell(
        onTap: () async {
          if (widget.infoData!.isValidAddress!) {
            await _repository.saveAddress(widget.infoData!.city!);
            await _repository.saveAddressId(widget.infoData!.id.toString());
            print("whasttttttttttttt isssssssssssssssss ${widget.isFromCheckout}");
            widget.isFromCheckout
                ? Navigator.of(context).pushReplacementNamed(
                    Routes.checkoutPage,
                    arguments: CheckoutArgument(
                        widget.arg.addressId,
                        widget.arg.time,
                        widget.infoData!.city!,
                        widget.arg.subtotal,
                        widget.arg.tax,
                        widget.arg.total,
                        "",
                        false,
                        widget.arg.data))
                : Navigator.of(context).pushReplacementNamed(
                    Routes.mainRootPage,
                    arguments: GlobalArgument(
                        widget.token, widget.numCart, null, null, null));
          }
        },
        child: Card(
          color: widget.currentAddres == widget.infoData!.city!
              ? AppColors.lightSecondaryColor.withOpacity(.5)
              : AppColors.white,
          shadowColor: AppColors.mainGray.withOpacity(0.6),
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: widget.currentAddres == widget.infoData!.city!
                      ? AppColors.mainColor
                      : Colors.white),
              borderRadius:
                  BorderRadius.all(Radius.circular(AppRadius.radius10))),
          child: Container(
            width: widget.width,
            padding: const EdgeInsets.all(AppDimens.space16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  color: AppColors.light_gray,
                  child: Icon(
                    Icons.location_on,
                    color: widget.infoData!.isValidAddress!
                        ? AppColors.mainColor
                        : AppColors.mainRed,
                    size: 20,
                  ),
                ),
                HorizontalPadding(
                  percentage: 0.035,
                ),
                Container(
                  width: widget.width / 1.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.infoData!.country ??
                            '' + " , ${widget.infoData!.city ?? ''}",
                        style: appTextStyle.normalTSBasicBold.copyWith(
                            color: widget.infoData!.isValidAddress!
                                ? AppColors.black
                                : AppColors.mainRed),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      VerticalPadding(
                        percentage: 0.01,
                      ),
                      Text(
                        widget.infoData!.street ??
                            '' + " , ${widget.infoData!.note ?? ''}",
                        style: appTextStyle.middleTSBasic.copyWith(
                            color: widget.infoData!.isValidAddress!
                                ? AppColors.black
                                : AppColors.mainRed),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      VerticalPadding(
                        percentage: 0.01,
                      ),
                      Text(
                        widget.infoData!.note ?? '',
                        style: appTextStyle.smallTSBasic.copyWith(
                            color: widget.infoData!.isValidAddress!
                                ? AppColors.gray
                                : AppColors.mainRed),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: widget.infoData!.isValidAddress!
                      ? AppColors.black
                      : AppColors.mainRed,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

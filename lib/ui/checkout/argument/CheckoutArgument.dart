

import '../../../models/cart/cart_validate_model.dart';

class CheckoutArgument {

  final String? addressId;
  final String? time;
  final String? address;
  final double subtotal;
  final double tax;
  final double total;
  final bool isFromCart;
  final String curr;
  final CartValidateData? data;


  CheckoutArgument(this.addressId, this.time, this.address, this.subtotal, this.tax, this.total,this.curr,this.isFromCart,this.data);
}
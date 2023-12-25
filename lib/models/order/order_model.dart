import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';



@JsonSerializable(explicitToJson: true)
class OrderModel {
  List<OrderData>? data;
  int? status;
  String? msg;
  OrderModel({
    this.data,
      this.status,
      this.msg
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
@JsonSerializable(explicitToJson: true)
class OrderData {
  int? id;
  String? user_id;
  String? method;
  int? totalQty;
  int? Qty;
  // String? pay_amount;
  int? total;
  String? payment_status;
  String? payment_status_name;
  String? text_payment;
  String? order_number;
  String? status_name;
  String? text;
  var status;
  var color;
  bool? canEdit;
  String? created_at;
  String? updated_at;
  String? pdated_at;
  int? timestamp;
  int? timestamp_update;
  CurrData? curr;


  OrderData({
    this.id,
    this.user_id,
    this.method,
    this.totalQty,
    this.Qty,
    // this.pay_amount,
    this.total,
    this.payment_status,
    this.payment_status_name,
    this.text_payment,
    this.order_number,
    this.status_name,
    this.text,
    this.status,
    this.color,
    this.canEdit,
    this.created_at,
    this.updated_at,
    this.timestamp,
    this.timestamp_update,
    this.curr,

  });

  factory OrderData.fromJson(Map<String, dynamic> json) => _$OrderDataFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OrdersData{
  int? id;
  String? name;
  String? date_order;
  bool? validity_date;
  List<OrderLineData>? order_line;
  String? invoice_status;
  String? note;
  double? amount_total;
  double? amount_tax;
  int? delivery_count;
  int? cart_quantity;
  double? amount_delivery;
  List<PartnerShippingIdData>? partner_shipping_id;
  List<dynamic>? delivery_slot_id;
  List<dynamic>? delivery_slot_time_id;

  OrdersData({
    this.id,
    this.name,
    this.delivery_slot_id,
    this.delivery_slot_time_id,
    this.date_order,
    this.validity_date,
    this.order_line,
    this.invoice_status,
    this.note,
    this.amount_total,
    this.amount_tax,
    this.delivery_count,
    this.cart_quantity,
    this.amount_delivery,
    this.partner_shipping_id,
  });

  factory OrdersData.fromJson(Map<String, dynamic> json) => _$OrdersDataFromJson(json);
  Map<String, dynamic> toJson() => _$OrdersDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class PartnerShippingIdData{
  int? id;
  bool? country_id;
  bool? state_id;
  String? comment;
  String? city;
  String? email;
  String? phone;
  String? mobile;
  String? name;
  String? parent_name;
  double? partner_latitude;
  double? partner_longitude;
  String? partner_map_address;

  PartnerShippingIdData({
    this.id,
    this.country_id,
    this.state_id,
    this.comment,
    this.city,
    this.email,
    this.phone,
    this.mobile,
    this.name,
    this.parent_name,
    this.partner_latitude,
    this.partner_longitude,
    this.partner_map_address,
  });

  factory PartnerShippingIdData.fromJson(Map<String, dynamic> json) => _$PartnerShippingIdDataFromJson(json);
  Map<String, dynamic> toJson() => _$PartnerShippingIdDataToJson(this);

}


@JsonSerializable(explicitToJson: true)
class OrderLineData{
  int? id;
  String? name;
  double? price_unit;
  double? price_subtotal;
  double? price_tax;
  double? price_total;
  String? name_short;
  double? qty_invoiced;
  double? product_qty;

  OrderLineData({
    this.id,
    this.name,
    this.price_unit,
    this.price_subtotal,
    this.price_tax,
    this.price_total,
    this.name_short,
    this.qty_invoiced,
    this.product_qty,
  });

  factory OrderLineData.fromJson(Map<String, dynamic> json) => _$OrderLineDataFromJson(json);
  Map<String, dynamic> toJson() => _$OrderLineDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class CurrData{
  String? name;
  String? sign;

  CurrData({
    this.name,
    this.sign,
  });

  factory CurrData.fromJson(Map<String, dynamic> json) => _$CurrDataFromJson(json);
  Map<String, dynamic> toJson() => _$CurrDataToJson(this);

}
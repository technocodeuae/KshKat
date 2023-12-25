import 'package:json_annotation/json_annotation.dart';

part 'order_details_model.g.dart';



@JsonSerializable(explicitToJson: true)
class OrderDetailsModel {
  List<OrderDetailsData>? data;
  int? code;
  int? message;
  OrderDetailsModel({
    this.data,
    this.code,
    this.message
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => _$OrderDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailsModelToJson(this);
}
@JsonSerializable(explicitToJson: true)
class OrderDetailsData {
  var id;
  String? user_id;
  List<CartData>? cart;
  String? method;
  int? totalQty;
  int? Qty;
  String? subamount;
  double? total;
  CurrData? curr;
  String? payment_status;
  String? payment_status_name;
  String? text_payment;
  String? order_number;
  String? status_name;
  String? text;
  var color;
  String? status;
  bool? canEdit;
  String? customer_city;
  String? customer_street;
  String? customer_zip;
  String? customer_phone;
  String? created_at;
  String? updated_at;
  int? timestamp;
  int? timestamp_update;
  String? tax;

  OrderDetailsData({
    this.id,
    this.user_id,
    this.cart,
    this.method,
    this.totalQty,
    this.Qty,
    this.subamount,
    this.total,
    this.curr,
    this.payment_status,
    this.payment_status_name,
    this.text_payment,
    this.order_number,
    this.status_name,
    this.text,
    this.color,
    this.status,
    this.canEdit,
    this.customer_city,
    this.customer_street,
    this.customer_zip,
    this.customer_phone,
    this.created_at,
    this.updated_at,
    this.timestamp,
    this.timestamp_update,
    this.tax,
  });

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) => _$OrderDetailsDataFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailsDataToJson(this);
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

@JsonSerializable(explicitToJson: true)
class CartData{
  var product_id;
  var quantity;
  String? product_name;
  PriceOptionsData? price_options;
  var selected_price_options;
  String? text;
  String? photo;
  String? price;
  String? previous_price;
  int? weight;
  bool? is_discount;
  double? percent_discount;
  List<AttributesInfo>? attributes_info;

  CartData({
    this.attributes_info,
    this.product_id,
    this.quantity,
    this.product_name,
    this.price_options,
    this.selected_price_options,
    this.text,
    this.photo,
    this.price,
    this.previous_price,
    this.weight,
    this.is_discount,
    this.percent_discount,
  });

  factory CartData.fromJson(Map<String, dynamic> json) => _$CartDataFromJson(json);
  Map<String, dynamic> toJson() => _$CartDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class PriceOptionsData{
  var id;
  String? ids;
  String? price;
  bool? is_default;
  List<AttributesData>? attributes;

  PriceOptionsData({
    this.id,
    this.ids,
    this.price,
    this.is_default,
    this.attributes,
  });

  factory PriceOptionsData.fromJson(Map<String, dynamic> json) => _$PriceOptionsDataFromJson(json);
  Map<String, dynamic> toJson() => _$PriceOptionsDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class AttributesData{
  var id;
  String? name;
  List<OptionsData>? options;

  AttributesData({
    this.id,
    this.name,
    this.options,
  });

  factory AttributesData.fromJson(Map<String, dynamic> json) => _$AttributesDataFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class OptionsData{
  var id;
  String? name;
  bool? is_default;

  OptionsData({
    this.id,
    this.name,
    this.is_default,
  });

  factory OptionsData.fromJson(Map<String, dynamic> json) => _$OptionsDataFromJson(json);
  Map<String, dynamic> toJson() => _$OptionsDataToJson(this);

}


@JsonSerializable(explicitToJson: true)
class AttributesInfo{
  
  String? attribute_value;
  String? attribute_name;
  String? price;

  AttributesInfo({
    this.attribute_value,
    this.attribute_name,
    this.price,
  });

  factory AttributesInfo.fromJson(Map<String, dynamic> json) => _$AttributesInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesInfoToJson(this);

}
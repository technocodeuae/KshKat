import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';



@JsonSerializable(explicitToJson: true)
class CartModel {
  double? total;
  CurrData? curr;
  int? id;
  List<ItemsData>? items;
  int? code;
  int? message;
  CartModel({
    this.code,
    this.message,
    this.items,
    this.total,
    this.curr,
    this.id
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Data {
  String? total;
  CurrData? curr;
  int? id;
  List<ItemsData>? items;

  Data({
    this.items,
    this.total,
    this.curr,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
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
class ItemsData{
  int? cart_item_id;
  int? product_id;
  String? product_name;
  String? text;
  String? photo;
  double? price;
  double? previous_price;
  CurrData? curr;
  bool? is_top;
  bool? is_latest;
  bool? is_featured;
  bool? is_Fav;
  int? weight;
  bool? is_discount;
  int? qty_in_cart;
  String? attributes_price_id;
  bool? has_attributes;
  List<AttributesData>? attributes;
  List<PriceOptionsData>? price_options;
  String? percent_discount;
  List<AttributeInfo>? attributes_info;

  ItemsData({
    this.cart_item_id,
    this.product_id,
    this.product_name,
    this.text,
    this.attributes_info,
    this.photo,
    this.price,
    this.previous_price,
    this.curr,
    this.is_top,
    this.is_latest,
    this.is_featured,
    this.is_Fav,
    this.weight,
    this.is_discount,
    this.qty_in_cart,
    this.attributes_price_id,
    this.has_attributes,
    this.attributes,
    this.price_options,
    this.percent_discount,
  });

  factory ItemsData.fromJson(Map<String, dynamic> json) => _$ItemsDataFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class PriceOptionsData{
  int? id;
  String? ids;
  String? price;
  bool? is_default;

  PriceOptionsData({
    this.id,
    this.ids,
    this.price,
    this.is_default,
  });

  factory PriceOptionsData.fromJson(Map<String, dynamic> json) => _$PriceOptionsDataFromJson(json);
  Map<String, dynamic> toJson() => _$PriceOptionsDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class AttributesData{
  int? id;
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
class AttributeInfo{
  String? attribute_value;
  String? attribute_name;

  AttributeInfo({
    this.attribute_value,
    this.attribute_name,
  });

  factory AttributeInfo.fromJson(Map<String, dynamic> json) => _$AttributeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AttributeInfoToJson(this);

}

@JsonSerializable(explicitToJson: true)
class OptionsData{
  int? id;
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


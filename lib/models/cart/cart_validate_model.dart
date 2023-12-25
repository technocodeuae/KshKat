
import 'package:json_annotation/json_annotation.dart';
part 'cart_validate_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CartValidateModel {
  CartValidateData? data;
  int? status;
  String? msg;
  CartValidateModel({
    this.data,
    this.status,
    this.msg
  });

  factory CartValidateModel.fromJson(Map<String, dynamic> json) => _$CartValidateModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartValidateModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartValidateData {
  List<Items> items=[];

  CartValidateData({
    required this.items,

  });

  factory CartValidateData.fromJson(Map<String, dynamic> json) => _$CartValidateDataFromJson(json);
  Map<String, dynamic> toJson() => _$CartValidateDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Items{
  int? product_id;
  int? quantity;
  int? attributes_price_id;

  Items({
    this.product_id,
    this.quantity,
    this.attributes_price_id,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);

}


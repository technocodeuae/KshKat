import 'package:json_annotation/json_annotation.dart';

part 'cart_save_model.g.dart';



@JsonSerializable(explicitToJson: true)
class CartSaveModel {
  Data? data;
  int? code;
  String? msg;
  CartSaveModel({
    this.code,
    this.msg,
    this.data
  });

  factory CartSaveModel.fromJson(Map<String, dynamic> json) => _$CartSaveModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartSaveModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Data {
  bool? success;
  int? cart_id;
  String? msg;

  Data({
    this.success,
    this.cart_id,
    this.msg,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}


import 'package:json_annotation/json_annotation.dart';
part 'cart_result_validate.g.dart';

@JsonSerializable(explicitToJson: true)
class CartResultValidate {
  CartResultValidateData? data;
  int? status;
  String? msg;
  CartResultValidate({
    this.data,
    this.status,
    this.msg
  });

  factory CartResultValidate.fromJson(Map<String, dynamic> json) => _$CartResultValidateFromJson(json);
  Map<String, dynamic> toJson() => _$CartResultValidateToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CartResultValidateData {
  String? jsonrpc;
  var id;
  ResultData? result;

  CartResultValidateData({
    this.jsonrpc,
    this.id,
    this.result,

  });

  factory CartResultValidateData.fromJson(Map<String, dynamic> json) => _$CartResultValidateDataFromJson(json);
  Map<String, dynamic> toJson() => _$CartResultValidateDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResultData{
  String? msg;
  bool? valid;
  List<DataData>? data;

  ResultData({
    this.msg,
    this.valid,
    this.data,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) => _$ResultDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResultDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class DataData{
  int? id;
  String? name;
  bool? description;
  String? api_image_url;
  int? virtual_available;
  int? qty_available;

  DataData({
    this.id,
    this.name,
    this.description,
    this.api_image_url,
    this.virtual_available,
    this.qty_available,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => _$DataDataFromJson(json);
  Map<String, dynamic> toJson() => _$DataDataToJson(this);

}


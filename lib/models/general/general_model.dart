import 'package:json_annotation/json_annotation.dart';

part 'general_model.g.dart';



@JsonSerializable(explicitToJson: true)
class GeneralModel {
  bool? success;
  int? code;
  String? message;
  ErrorsData? errors;

  GeneralModel({
    this.success,
    this.code,
    this.message,
    this.errors,
  });

  factory GeneralModel.fromJson(Map<String, dynamic> json) => _$GeneralModelFromJson(json);
  Map<String, dynamic> toJson() => _$GeneralModelToJson(this);
}
@JsonSerializable(explicitToJson: true)
class ErrorsData{
  List<String>? quantity;

  ErrorsData({
    this.quantity,
  });

  factory ErrorsData.fromJson(Map<String, dynamic> json) => _$ErrorsDataFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorsDataToJson(this);

}


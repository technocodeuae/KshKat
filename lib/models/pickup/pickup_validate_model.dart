
import 'package:json_annotation/json_annotation.dart';
part 'pickup_validate_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PickupValidateModel {
  PickupValidateData? data;
  int? status;
  String? msg;
  PickupValidateModel({
    this.data,
    this.status,
    this.msg
  });

  factory PickupValidateModel.fromJson(Map<String, dynamic> json) => _$PickupValidateModelFromJson(json);
  Map<String, dynamic> toJson() => _$PickupValidateModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PickupValidateData {
  String? jsonrpc;
  var id;
  ResultData? result;

  PickupValidateData({
    this.jsonrpc,
    this.id,
    this.result,

  });

  factory PickupValidateData.fromJson(Map<String, dynamic> json) => _$PickupValidateDataFromJson(json);
  Map<String, dynamic> toJson() => _$PickupValidateDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResultData{
  int? status;
  String? msg;
  DataData? data;

  ResultData({
    this.status,
    this.msg,
    this.data,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) => _$ResultDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResultDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class DataData{
  bool? valid;
  List<DilverySlotData>? dilvery_slot;

  DataData({
    this.valid,
    this.dilvery_slot,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => _$DataDataFromJson(json);
  Map<String, dynamic> toJson() => _$DataDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class DilverySlotData{
  int? id;
  String? name;
  List<SlotsIdsData>? slots_ids;

  DilverySlotData({
    this.id,
    this.name,
    this.slots_ids,
  });

  factory DilverySlotData.fromJson(Map<String, dynamic> json) => _$DilverySlotDataFromJson(json);
  Map<String, dynamic> toJson() => _$DilverySlotDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class SlotsIdsData{
  int? id;
  String? name;
  bool? is_disabled;

  SlotsIdsData({
    this.id,
    this.name,
    this.is_disabled,
  });

  factory SlotsIdsData.fromJson(Map<String, dynamic> json) => _$SlotsIdsDataFromJson(json);
  Map<String, dynamic> toJson() => _$SlotsIdsDataToJson(this);

}


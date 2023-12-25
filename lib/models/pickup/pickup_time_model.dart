import 'package:json_annotation/json_annotation.dart';

part 'pickup_time_model.g.dart';



@JsonSerializable(explicitToJson: true)
class PickupTimeModel {
  PickupTimeData? data;
  int? status;
  String? msg;
  PickupTimeModel({
    this.data,
    this.status,
    this.msg
  });

  factory PickupTimeModel.fromJson(Map<String, dynamic> json) => _$PickupTimeModelFromJson(json);
  Map<String, dynamic> toJson() => _$PickupTimeModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PickupTimeData {
  List<DilverySlotData>? dilvery_slot;
  int? total_count;
  int? current_page;
  int? per_page;
  bool? is_last_page;

  PickupTimeData({
    this.dilvery_slot,
    this.total_count,
    this.current_page,
    this.per_page,
    this.is_last_page,

  });

  factory PickupTimeData.fromJson(Map<String, dynamic> json) => _$PickupTimeDataFromJson(json);
  Map<String, dynamic> toJson() => _$PickupTimeDataToJson(this);
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

 
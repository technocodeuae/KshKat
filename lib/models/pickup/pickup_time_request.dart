
import 'package:json_annotation/json_annotation.dart';
part 'pickup_time_request.g.dart';

@JsonSerializable(explicitToJson: true)
class PickUpTimeRequest {
  PickUpTimeRequestData? data;
  int? status;
  String? msg;
  PickUpTimeRequest({
    this.data,
    this.status,
    this.msg
  });

  factory PickUpTimeRequest.fromJson(Map<String, dynamic> json) => _$PickUpTimeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PickUpTimeRequestToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PickUpTimeRequestData {
  int delivery_slot_id;
  int delivery_slot_time_id;

  PickUpTimeRequestData({
    required this.delivery_slot_id,
    required this.delivery_slot_time_id,

  });

  factory PickUpTimeRequestData.fromJson(Map<String, dynamic> json) => _$PickUpTimeRequestDataFromJson(json);
  Map<String, dynamic> toJson() => _$PickUpTimeRequestDataToJson(this);
}


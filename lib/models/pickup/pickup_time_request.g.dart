// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_time_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickUpTimeRequest _$PickUpTimeRequestFromJson(Map<String, dynamic> json) =>
    PickUpTimeRequest(
      data: json['data'] == null
          ? null
          : PickUpTimeRequestData.fromJson(
              json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$PickUpTimeRequestToJson(PickUpTimeRequest instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'status': instance.status,
      'msg': instance.msg,
    };

PickUpTimeRequestData _$PickUpTimeRequestDataFromJson(
        Map<String, dynamic> json) =>
    PickUpTimeRequestData(
      delivery_slot_id: json['delivery_slot_id'] as int,
      delivery_slot_time_id: json['delivery_slot_time_id'] as int,
    );

Map<String, dynamic> _$PickUpTimeRequestDataToJson(
        PickUpTimeRequestData instance) =>
    <String, dynamic>{
      'delivery_slot_id': instance.delivery_slot_id,
      'delivery_slot_time_id': instance.delivery_slot_time_id,
    };

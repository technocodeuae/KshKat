// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickupTimeModel _$PickupTimeModelFromJson(Map<String, dynamic> json) =>
    PickupTimeModel(
      data: json['data'] == null
          ? null
          : PickupTimeData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$PickupTimeModelToJson(PickupTimeModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'status': instance.status,
      'msg': instance.msg,
    };

PickupTimeData _$PickupTimeDataFromJson(Map<String, dynamic> json) =>
    PickupTimeData(
      dilvery_slot: (json['dilvery_slot'] as List<dynamic>?)
          ?.map((e) => DilverySlotData.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_count: json['total_count'] as int?,
      current_page: json['current_page'] as int?,
      per_page: json['per_page'] as int?,
      is_last_page: json['is_last_page'] as bool?,
    );

Map<String, dynamic> _$PickupTimeDataToJson(PickupTimeData instance) =>
    <String, dynamic>{
      'dilvery_slot': instance.dilvery_slot?.map((e) => e.toJson()).toList(),
      'total_count': instance.total_count,
      'current_page': instance.current_page,
      'per_page': instance.per_page,
      'is_last_page': instance.is_last_page,
    };

DilverySlotData _$DilverySlotDataFromJson(Map<String, dynamic> json) =>
    DilverySlotData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slots_ids: (json['slots_ids'] as List<dynamic>?)
          ?.map((e) => SlotsIdsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DilverySlotDataToJson(DilverySlotData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slots_ids': instance.slots_ids?.map((e) => e.toJson()).toList(),
    };

SlotsIdsData _$SlotsIdsDataFromJson(Map<String, dynamic> json) => SlotsIdsData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      is_disabled: json['is_disabled'] as bool?,
    );

Map<String, dynamic> _$SlotsIdsDataToJson(SlotsIdsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_disabled': instance.is_disabled,
    };

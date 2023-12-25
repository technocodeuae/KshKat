// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickup_validate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PickupValidateModel _$PickupValidateModelFromJson(Map<String, dynamic> json) =>
    PickupValidateModel(
      data: json['data'] == null
          ? null
          : PickupValidateData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$PickupValidateModelToJson(
        PickupValidateModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'status': instance.status,
      'msg': instance.msg,
    };

PickupValidateData _$PickupValidateDataFromJson(Map<String, dynamic> json) =>
    PickupValidateData(
      jsonrpc: json['jsonrpc'] as String?,
      id: json['id'],
      result: json['result'] == null
          ? null
          : ResultData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PickupValidateDataToJson(PickupValidateData instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.result?.toJson(),
    };

ResultData _$ResultDataFromJson(Map<String, dynamic> json) => ResultData(
      status: json['status'] as int?,
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : DataData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'data': instance.data?.toJson(),
    };

DataData _$DataDataFromJson(Map<String, dynamic> json) => DataData(
      valid: json['valid'] as bool?,
      dilvery_slot: (json['dilvery_slot'] as List<dynamic>?)
          ?.map((e) => DilverySlotData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataDataToJson(DataData instance) => <String, dynamic>{
      'valid': instance.valid,
      'dilvery_slot': instance.dilvery_slot?.map((e) => e.toJson()).toList(),
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

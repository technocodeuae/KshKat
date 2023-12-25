// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_result_validate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResultValidate _$CartResultValidateFromJson(Map<String, dynamic> json) =>
    CartResultValidate(
      data: json['data'] == null
          ? null
          : CartResultValidateData.fromJson(
              json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$CartResultValidateToJson(CartResultValidate instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'status': instance.status,
      'msg': instance.msg,
    };

CartResultValidateData _$CartResultValidateDataFromJson(
        Map<String, dynamic> json) =>
    CartResultValidateData(
      jsonrpc: json['jsonrpc'] as String?,
      id: json['id'],
      result: json['result'] == null
          ? null
          : ResultData.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartResultValidateDataToJson(
        CartResultValidateData instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.result?.toJson(),
    };

ResultData _$ResultDataFromJson(Map<String, dynamic> json) => ResultData(
      msg: json['msg'] as String?,
      valid: json['valid'] as bool?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultDataToJson(ResultData instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'valid': instance.valid,
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

DataData _$DataDataFromJson(Map<String, dynamic> json) => DataData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as bool?,
      api_image_url: json['api_image_url'] as String?,
      virtual_available: json['virtual_available'] as int?,
      qty_available: json['qty_available'] as int?,
    );

Map<String, dynamic> _$DataDataToJson(DataData instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'api_image_url': instance.api_image_url,
      'virtual_available': instance.virtual_available,
      'qty_available': instance.qty_available,
    };

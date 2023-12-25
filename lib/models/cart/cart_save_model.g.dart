// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_save_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartSaveModel _$CartSaveModelFromJson(Map<String, dynamic> json) =>
    CartSaveModel(
      code: json['code'] as int?,
      msg: json['msg'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CartSaveModelToJson(CartSaveModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'code': instance.code,
      'msg': instance.msg,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      success: json['success'] as bool?,
      cart_id: json['cart_id'] as int?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'success': instance.success,
      'cart_id': instance.cart_id,
      'msg': instance.msg,
    };

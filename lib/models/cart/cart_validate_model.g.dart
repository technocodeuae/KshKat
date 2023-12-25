// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_validate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartValidateModel _$CartValidateModelFromJson(Map<String, dynamic> json) =>
    CartValidateModel(
      data: json['data'] == null
          ? null
          : CartValidateData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$CartValidateModelToJson(CartValidateModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'status': instance.status,
      'msg': instance.msg,
    };

CartValidateData _$CartValidateDataFromJson(Map<String, dynamic> json) =>
    CartValidateData(
      items: (json['items'] as List<dynamic>)
          .map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CartValidateDataToJson(CartValidateData instance) =>
    <String, dynamic>{
      'items': instance.items.map((e) => e.toJson()).toList(),
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      product_id: json['product_id'] as int?,
      quantity: json['quantity'] as int?,
      attributes_price_id: json['attributes_price_id'] as int?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'product_id': instance.product_id,
      'quantity': instance.quantity,
      'attributes_price_id': instance.attributes_price_id,
    };

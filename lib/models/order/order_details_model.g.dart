// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetailsModel _$OrderDetailsModelFromJson(Map<String, dynamic> json) =>
    OrderDetailsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OrderDetailsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as int?,
      message: json['message'] as int?,
    );

Map<String, dynamic> _$OrderDetailsModelToJson(OrderDetailsModel instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'code': instance.code,
      'message': instance.message,
    };

OrderDetailsData _$OrderDetailsDataFromJson(Map<String, dynamic> json) =>
    OrderDetailsData(
      id: json['id'],
      user_id: json['user_id'].toString() as String?,
      cart: (json['cart'] as List<dynamic>?)
          ?.map((e) => CartData.fromJson(e as Map<String, dynamic>))
          .toList(),
      method: json['method'] as String?,
      totalQty: json['totalQty'] as int?,
      Qty: json['Qty'] as int?,
      subamount: json['subamount'] as String?,
      total: (json['total'] as num?)?.toDouble(),
      curr: json['curr'] == null
          ? null
          : CurrData.fromJson(json['curr'] as Map<String, dynamic>),
      payment_status: json['payment_status'] as String?,
      payment_status_name: json['payment_status_name'] as String?,
      text_payment: json['text_payment'] as String?,
      order_number: json['order_number'] as String?,
      status_name: json['status_name'] as String?,
      text: json['text'] as String?,
      color: json['color'],
      status: json['status'] as String?,
      canEdit: json['canEdit'] as bool?,
      customer_city: json['customer_city'] as String?,
      customer_street: json['customer_street'] as String?,
      customer_zip: json['customer_zip'] as String?,
      customer_phone: json['customer_phone'] as String?,
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      timestamp: json['timestamp'] as int?,
      timestamp_update: json['timestamp_update'] as int?,
      tax: json['tax'] as String?,
    );

Map<String, dynamic> _$OrderDetailsDataToJson(OrderDetailsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'cart': instance.cart?.map((e) => e.toJson()).toList(),
      'method': instance.method,
      'totalQty': instance.totalQty,
      'Qty': instance.Qty,
      'subamount': instance.subamount,
      'total': instance.total,
      'curr': instance.curr?.toJson(),
      'payment_status': instance.payment_status,
      'payment_status_name': instance.payment_status_name,
      'text_payment': instance.text_payment,
      'order_number': instance.order_number,
      'status_name': instance.status_name,
      'text': instance.text,
      'color': instance.color,
      'status': instance.status,
      'canEdit': instance.canEdit,
      'customer_city': instance.customer_city,
      'customer_street': instance.customer_street,
      'customer_zip': instance.customer_zip,
      'customer_phone': instance.customer_phone,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'timestamp': instance.timestamp,
      'timestamp_update': instance.timestamp_update,
      'tax': instance.tax,
    };

CurrData _$CurrDataFromJson(Map<String, dynamic> json) => CurrData(
      name: json['name'] as String?,
      sign: json['sign'] as String?,
    );

Map<String, dynamic> _$CurrDataToJson(CurrData instance) => <String, dynamic>{
      'name': instance.name,
      'sign': instance.sign,
    };

CartData _$CartDataFromJson(Map<String, dynamic> json) => CartData(
      product_id: json['product_id'],
      quantity: json['quantity'],
      product_name: json['product_name'] as String?,
      price_options: json['price_options'] == null
          ? null
          : PriceOptionsData.fromJson(
              json['price_options'] as Map<String, dynamic>),
      selected_price_options: json['selected_price_options'],
      text: json['text'] as String?,
      photo: json['photo'] as String?,
      price: json['price'].toString() as String?,
      previous_price: json['previous_price'].toString() as String?,
      weight: json['weight'] as int?,
      is_discount: json['is_discount'] as bool?,
      attributes_info: (json['attributes_info'] as List<dynamic>?)
          ?.map((e) => AttributesInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      percent_discount: json['percent_discount'] as double?,
    );

Map<String, dynamic> _$CartDataToJson(CartData instance) => <String, dynamic>{
      'product_id': instance.product_id,
      'quantity': instance.quantity,
      'product_name': instance.product_name,
      'price_options': instance.price_options?.toJson(),
      'selected_price_options': instance.selected_price_options,
      'text': instance.text,
      'photo': instance.photo,
      'price': instance.price,
      'previous_price': instance.previous_price,
      'weight': instance.weight,
      'is_discount': instance.is_discount,
      'percent_discount': instance.percent_discount,
      'attributes_info':
          instance.attributes_info?.map((e) => e.toJson()).toList(),
    };

PriceOptionsData _$PriceOptionsDataFromJson(Map<String, dynamic> json) =>
    PriceOptionsData(
      id: json['id'],
      ids: json['ids'] as String?,
      price: json['price'] as String?,
      is_default: json['is_default'] as bool?,
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => AttributesData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PriceOptionsDataToJson(PriceOptionsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ids': instance.ids,
      'price': instance.price,
      'is_default': instance.is_default,
      'attributes': instance.attributes?.map((e) => e.toJson()).toList(),
    };

AttributesData _$AttributesDataFromJson(Map<String, dynamic> json) =>
    AttributesData(
      id: json['id'],
      name: json['name'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttributesDataToJson(AttributesData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'options': instance.options?.map((e) => e.toJson()).toList(),
    };

OptionsData _$OptionsDataFromJson(Map<String, dynamic> json) => OptionsData(
      id: json['id'],
      name: json['name'] as String?,
      is_default: json['is_default'] as bool?,
    );

Map<String, dynamic> _$OptionsDataToJson(OptionsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_default': instance.is_default,
    };

AttributesInfo _$AttributesInfoFromJson(Map<String, dynamic> json) =>
    AttributesInfo(
      attribute_name: json['attribute_name'] as String?,
      attribute_value: json['attribute_value'] as String?,
      price: json['price'] != null ? json['price'].toString() : '' ,
    );

Map<String, dynamic> _$AttributesInfoToJson(AttributesInfo instance) =>
    <String, dynamic>{
      'attribute_name': instance.attribute_name,
      'attribute_value': instance.attribute_value,
      'price': instance.price,
    };

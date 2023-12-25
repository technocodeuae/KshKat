// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
      code: json['code'] as int?,
      message: json['message'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toDouble(),
      curr: json['curr'] == null
          ? null
          : CurrData.fromJson(json['curr'] as Map<String, dynamic>),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'total': instance.total,
      'curr': instance.curr?.toJson(),
      'id': instance.id,
      'items': instance.items?.map((e) => e.toJson()).toList(),
      'code': instance.code,
      'message': instance.message,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ItemsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as String?,
      curr: json['curr'] == null
          ? null
          : CurrData.fromJson(json['curr'] as Map<String, dynamic>),
      id: json['id'] as int?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'total': instance.total,
      'curr': instance.curr?.toJson(),
      'id': instance.id,
      'items': instance.items?.map((e) => e.toJson()).toList(),
    };

CurrData _$CurrDataFromJson(Map<String, dynamic> json) => CurrData(
      name: json['name'] as String?,
      sign: json['sign'] as String?,
    );

Map<String, dynamic> _$CurrDataToJson(CurrData instance) => <String, dynamic>{
      'name': instance.name,
      'sign': instance.sign,
    };

ItemsData _$ItemsDataFromJson(Map<String, dynamic> json) => ItemsData(
      cart_item_id: json['cart_item_id'] as int?,
      product_id: json['product_id'] as int?,
      product_name: json['product_name'] as String?,
      text: json['text'] as String?,
      photo: json['photo'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      previous_price: (json['previous_price'] as num?)?.toDouble(),
      curr: json['curr'] == null
          ? null
          : CurrData.fromJson(json['curr'] as Map<String, dynamic>),
      is_top: json['is_top'] as bool?,
      is_latest: json['is_latest'] as bool?,
      is_featured: json['is_featured'] as bool?,
      is_Fav: json['is_Fav'] as bool?,
      weight: json['weight'] as int?,
      is_discount: json['is_discount'] as bool?,
      qty_in_cart: json['qty_in_cart'] as int?,
      attributes_price_id: json['attributes_price_id'] as String?,
      has_attributes: json['has_attributes'] as bool?,
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => AttributesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributes_info: (json['attributes_info'] as List<dynamic>?)
          ?.map((e) => AttributeInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      price_options: (json['price_options'] as List<dynamic>?)
          ?.map((e) => PriceOptionsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      percent_discount: json['percent_discount'] as String?,
    );

Map<String, dynamic> _$ItemsDataToJson(ItemsData instance) => <String, dynamic>{
      'cart_item_id': instance.cart_item_id,
      'product_id': instance.product_id,
      'product_name': instance.product_name,
      'text': instance.text,
      'attributes_info':instance.attributes_info?.map((e) => e.toJson()).toList(),
      'photo': instance.photo,
      'price': instance.price,
      'previous_price': instance.previous_price,
      'curr': instance.curr?.toJson(),
      'is_top': instance.is_top,
      'is_latest': instance.is_latest,
      'is_featured': instance.is_featured,
      'is_Fav': instance.is_Fav,
      'weight': instance.weight,
      'is_discount': instance.is_discount,
      'qty_in_cart': instance.qty_in_cart,
      'attributes_price_id': instance.attributes_price_id,
      'has_attributes': instance.has_attributes,
      'attributes': instance.attributes?.map((e) => e.toJson()).toList(),
      'price_options': instance.price_options?.map((e) => e.toJson()).toList(),
      'percent_discount': instance.percent_discount,
    };

PriceOptionsData _$PriceOptionsDataFromJson(Map<String, dynamic> json) =>
    PriceOptionsData(
      id: json['id'] as int?,
      ids: json['ids'] as String?,
      price: json['price'] as String?,
      is_default: json['is_default'] as bool?,
    );

Map<String, dynamic> _$PriceOptionsDataToJson(PriceOptionsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ids': instance.ids,
      'price': instance.price,
      'is_default': instance.is_default,
    };

AttributesData _$AttributesDataFromJson(Map<String, dynamic> json) =>
    AttributesData(
      id: json['id'] as int?,
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

AttributeInfo _$AttributeInfoFromJson(Map<String, dynamic> json) =>
    AttributeInfo(
      attribute_value: json['attribute_value'] as String?,
      attribute_name: json['attribute_name'] as String?,
    );

Map<String, dynamic> _$AttributeInfoToJson(AttributeInfo instance) =>
    <String, dynamic>{
      'attribute_value': instance.attribute_value,
      'attribute_name': instance.attribute_name,
    };

OptionsData _$OptionsDataFromJson(Map<String, dynamic> json) => OptionsData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      is_default: json['is_default'] as bool?,
    );

Map<String, dynamic> _$OptionsDataToJson(OptionsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_default': instance.is_default,
    };

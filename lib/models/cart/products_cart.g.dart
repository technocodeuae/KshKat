// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsCart _$ProductsCartFromJson(Map<String, dynamic> json) => ProductsCart(
      products: (json['products'] as List<dynamic>)
          .map((e) => Products.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductsCartToJson(ProductsCart instance) =>
    <String, dynamic>{
      'products': instance.products.map((e) => e.toJson()).toList(),
    };

ProData _$ProDataFromJson(Map<String, dynamic> json) => ProData(
      products: json['products'] == null
          ? null
          : Products.fromJson(json['products'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProDataToJson(ProData instance) => <String, dynamic>{
      'products': instance.products?.toJson(),
    };

Products _$ProductsFromJson(Map<String, dynamic> json) => Products(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'],
      api_image_url: json['api_image_url'] as String?,
      listPrice: (json['listPrice'] as num?)?.toDouble(),
      virtual_available: (json['virtual_available'] as num?)?.toDouble(),
      qty_available: (json['qty_available'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      is_discount: json['is_discount'] as bool?,
      is_comming_soon: json['is_comming_soon'] as bool?,
      tax: json['tax'] as String?,
      disc: json['disc'] as String?,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$ProductsToJson(Products instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'api_image_url': instance.api_image_url,
      'listPrice': instance.listPrice,
      'virtual_available': instance.virtual_available,
      'qty_available': instance.qty_available,
      'price': instance.price,
      'is_discount': instance.is_discount,
      'is_comming_soon': instance.is_comming_soon,
      'tax': instance.tax,
      'disc': instance.disc,
      'quantity': instance.quantity,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_fav_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsFavModel _$ProductsFavModelFromJson(Map<String, dynamic> json) =>
    ProductsFavModel(
      data: json['data'] == null
          ? null
          : DataProducts.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'] as int?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$ProductsFavModelToJson(ProductsFavModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'status': instance.status,
      'msg': instance.msg,
    };

DataProducts _$DataProductsFromJson(Map<String, dynamic> json) => DataProducts(
      success: json['success'] as bool?,
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ProductsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      product: (json['product'] as List<dynamic>?)
          ?.map((e) => ProductsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      products_count: json['products_count'] as int?,
      product_data: (json['product_data'] as List<dynamic>?)
          ?.map((e) => ProductsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataProductsToJson(DataProducts instance) =>
    <String, dynamic>{
      'success': instance.success,
      'products': instance.products?.map((e) => e.toJson()).toList(),
      'product': instance.product?.map((e) => e.toJson()).toList(),
      'product_data': instance.product_data?.map((e) => e.toJson()).toList(),
      'products_count': instance.products_count,
    };

MetaData _$MetaDataFromJson(Map<String, dynamic> json) => MetaData(
      current_page: json['current_page'] as int?,
      from: json['from'] as int?,
      last_page: json['last_page'] as int?,
      path: json['path'] as String?,
      per_page: json['per_page'] as String?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$MetaDataToJson(MetaData instance) => <String, dynamic>{
      'current_page': instance.current_page,
      'from': instance.from,
      'last_page': instance.last_page,
      'path': instance.path,
      'per_page': instance.per_page,
      'to': instance.to,
      'total': instance.total,
    };

LinksData _$LinksDataFromJson(Map<String, dynamic> json) => LinksData(
      first: json['first'] as String?,
      last: json['last'] as String?,
      prev: json['prev'],
      next: json['next'],
    );

Map<String, dynamic> _$LinksDataToJson(LinksData instance) => <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'prev': instance.prev,
      'next': instance.next,
    };

ProductsData _$ProductsDataFromJson(Map<String, dynamic> json) => ProductsData(
      id: json['id'] as int?,
      quantity: json['quantity'] as int?,
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      details: json['details'] as String?,
      text: json['text'] as String?,
      weight: json['weight'],
      category_id: json['category_id'],
      subcategory_id: json['subcategory_id'],
      childcategory_id: json['childcategory_id'],
      coming_soon: json['coming_soon'] as bool?,
      is_top: json['is_top'] as bool?,
      is_latest: json['is_latest'] as bool?,
      is_featured: json['is_featured'] as bool?,
      is_Fav: json['is_Fav'] as bool?,
      is_discount: json['is_discount'] as bool?,
      qty_in_cart: json['qty_in_cart'] as int?,
      photo: json['photo'] as String?,
      price: json['price'],
      previous_price: json['previous_price'],
      percent_discount: json['percent_discount'],
      has_attributes: json['has_attributes'] as bool?,
      curr: json['curr'] == null
          ? null
          : CurrData.fromJson(json['curr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductsDataToJson(ProductsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'sku': instance.sku,
      'name': instance.name,
      'details': instance.details,
      'text': instance.text,
      'weight': instance.weight,
      'category_id': instance.category_id,
      'subcategory_id': instance.subcategory_id,
      'childcategory_id': instance.childcategory_id,
      'coming_soon': instance.coming_soon,
      'is_top': instance.is_top,
      'is_latest': instance.is_latest,
      'is_featured': instance.is_featured,
      'is_Fav': instance.is_Fav,
      'is_discount': instance.is_discount,
      'qty_in_cart': instance.qty_in_cart,
      'photo': instance.photo,
      'price': instance.price,
      'previous_price': instance.previous_price,
      'percent_discount': instance.percent_discount,
      'has_attributes': instance.has_attributes,
      'curr': instance.curr?.toJson(),
    };

CurrData _$CurrDataFromJson(Map<String, dynamic> json) => CurrData(
      name: json['name'] as String?,
      sign: json['sign'] as String?,
    );

Map<String, dynamic> _$CurrDataToJson(CurrData instance) => <String, dynamic>{
      'name': instance.name,
      'sign': instance.sign,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsModel _$ProductsModelFromJson(Map<String, dynamic> json) =>
    ProductsModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$ProductsModelToJson(ProductsModel instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'status': instance.status,
      'msg': instance.msg,
    };

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      photo: json['photo'] as String?,
      is_featured: json['is_featured'] as String?,
      subs: (json['subs'] as List<dynamic>?)
          ?.map((e) => SubsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: json['products'] == null
          ? null
          : ProductsData.fromJson(json['products'] as Map<String, dynamic>),
      product_count: json['product_count'] as int?,
      subs_count: json['subs_count'] as int?,
      has_attributes: json['has_attributes'] as bool?,
    );

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'photo': instance.photo,
      'is_featured': instance.is_featured,
      'subs': instance.subs?.map((e) => e.toJson()).toList(),
      'products': instance.products?.toJson(),
      'product_count': instance.product_count,
      'subs_count': instance.subs_count,
      'has_attributes': instance.has_attributes,
    };

ProductsData _$ProductsDataFromJson(Map<String, dynamic> json) => ProductsData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DataData.fromJson(e as Map<String, dynamic>))
          .toList(),
      links: json['links'] == null
          ? null
          : LinksData.fromJson(json['links'] as Map<String, dynamic>),
      meta: json['meta'] == null
          ? null
          : MetaData.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductsDataToJson(ProductsData instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'links': instance.links?.toJson(),
      'meta': instance.meta?.toJson(),
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

DataData _$DataDataFromJson(Map<String, dynamic> json) => DataData(
      id: json['id'] as int?,
      quantity: json['quantity'] as int?,
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      details: json['details'] as String?,
      text: json['text'] as String?,
      weight: json['weight'] as int?,
      category_id: json['category_id'] as int?,
      subcategory_id: json['subcategory_id'] as int?,
      childcategory_id: json['childcategory_id'] as int?,
      coming_soon: json['coming_soon'] as bool?,
      is_top: json['is_top'] as bool?,
      is_latest: json['is_latest'] as bool?,
      is_featured: json['is_featured'] as bool?,
      is_Fav: json['is_Fav'] as bool?,
      is_discount: json['is_discount'] as bool?,
      qty_in_cart: json['qty_in_cart'] as int?,
      photo: json['photo'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      previous_price: (json['previous_price'] as num?)?.toDouble(),
      percent_discount: (json['percent_discount'] as num?)?.toDouble(),
      has_attributes: json['has_attributes'] as bool?,
      curr: json['curr'] == null
          ? null
          : CurrData.fromJson(json['curr'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataDataToJson(DataData instance) => <String, dynamic>{
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

SubsData _$SubsDataFromJson(Map<String, dynamic> json) => SubsData(
      id: json['id'] as int?,
      category_id: json['category_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      products_count: json['products_count'] as int?,
      child_count: json['child_count'] as int?,
      has_attributes: json['has_attributes'] as bool?,
    );

Map<String, dynamic> _$SubsDataToJson(SubsData instance) => <String, dynamic>{
      'id': instance.id,
      'category_id': instance.category_id,
      'name': instance.name,
      'slug': instance.slug,
      'products_count': instance.products_count,
      'child_count': instance.child_count,
      'has_attributes': instance.has_attributes,
    };

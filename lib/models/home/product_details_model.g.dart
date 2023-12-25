// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsModel _$ProductDetailsModelFromJson(Map<String, dynamic> json) =>
    ProductDetailsModel(
      success: json['success'] as bool?,
      product_data: json['product_data'] == null
          ? null
          : ProductDetailsData.fromJson(
              json['product_data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      total_record: json['total_record'] as int?,
    );

Map<String, dynamic> _$ProductDetailsModelToJson(
        ProductDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'product_data': instance.product_data?.toJson(),
      'message': instance.message,
      'total_record': instance.total_record,
    };

ProductDetailsData _$ProductDetailsDataFromJson(Map<String, dynamic> json) =>
    ProductDetailsData(
      id: json['id'] as int?,
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      details: json['details'] as String?,
      slug: json['slug'] as String?,
      weight: json['weight'],
      category_id: json['category_id'] as int?,
      subcategory_id: json['subcategory_id'] as int?,
      childcategory_id: json['childcategory_id'],
      coming_soon: json['coming_soon'] as bool?,
      qty_in_cart: json['qty_in_cart'] as int?,
      galleries: json['galleries'] as List<dynamic>?,
      is_top: json['is_top'] as bool?,
      is_latest: json['is_latest'] as bool?,
      is_featured: json['is_featured'] as bool?,
      is_Fav: json['is_Fav'] as bool?,
      is_discount: json['is_discount'],
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map((e) => AttributesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      attributes_price: (json['attributes_price'] as List<dynamic>?)
          ?.map((e) => AttributesPriceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      photo: json['photo'] as String?,
      quantity: json['quantity'] as int?,
      price: json['price'],
      previous_price: json['previous_price'],
      percent_discount: json['percent_discount'] as int?,
      has_attributes: json['has_attributes'] as bool?,
      options_ids: (json['options_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      curr: json['curr'] == null
          ? null
          : CurrData.fromJson(json['curr'] as Map<String, dynamic>),
      category_name: json['category_name'] as String?,
      childcategory_name: json['childcategory_name'] as String?,
      subcategory_name: json['subcategory_name'] as String?,
    )
      ..ratings = (json['ratings'] as List<dynamic>?)
          ?.map((e) => RatingsData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..averageRating = json['averageRating'];

Map<String, dynamic> _$ProductDetailsDataToJson(ProductDetailsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'details': instance.details,
      'slug': instance.slug,
      'weight': instance.weight,
      'category_id': instance.category_id,
      'category_name': instance.category_name,
      'subcategory_id': instance.subcategory_id,
      'subcategory_name': instance.subcategory_name,
      'childcategory_id': instance.childcategory_id,
      'childcategory_name': instance.childcategory_name,
      'coming_soon': instance.coming_soon,
      'qty_in_cart': instance.qty_in_cart,
      'galleries': instance.galleries,
      'is_top': instance.is_top,
      'is_latest': instance.is_latest,
      'is_featured': instance.is_featured,
      'is_Fav': instance.is_Fav,
      'is_discount': instance.is_discount,
      'attributes': instance.attributes?.map((e) => e.toJson()).toList(),
      'attributes_price':
          instance.attributes_price?.map((e) => e.toJson()).toList(),
      'photo': instance.photo,
      'quantity': instance.quantity,
      'price': instance.price,
      'previous_price': instance.previous_price,
      'percent_discount': instance.percent_discount,
      'has_attributes': instance.has_attributes,
      'options_ids': instance.options_ids,
      'ratings': instance.ratings?.map((e) => e.toJson()).toList(),
      'curr': instance.curr?.toJson(),
      'averageRating': instance.averageRating,
    };

RatingsData _$RatingsDataFromJson(Map<String, dynamic> json) => RatingsData(
      id: json['id'] as int?,
      user_id: json['user_id'] as int?,
      product_id: json['product_id'] as int?,
      rating: json['rating'],
      review: json['review'] as String?,
      review_date: json['review_date'] as String?,
      user_name: json['user_name'] as String?,
      user_photo: json['user_photo'] as String?,
    );

Map<String, dynamic> _$RatingsDataToJson(RatingsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'product_id': instance.product_id,
      'review': instance.review,
      'review_date': instance.review_date,
      'user_name': instance.user_name,
      'user_photo': instance.user_photo,
      'rating': instance.rating,
    };

AttributesPriceData _$AttributesPriceDataFromJson(Map<String, dynamic> json) =>
    AttributesPriceData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      product_id: json['product_id'],
      qty: json['qty'],
      price: json['price'],
      ids: json['ids'],
      is_default: json['is_default'],
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      main_id: json['main_id'],
    );

Map<String, dynamic> _$AttributesPriceDataToJson(
        AttributesPriceData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'product_id': instance.product_id,
      'qty': instance.qty,
      'ids':instance.ids,
      'price': instance.price,
      'is_default': instance.is_default,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'options': instance.options?.map((e) => e.toJson()).toList(),
      'main_id': instance.main_id,
    };

AttributesData _$AttributesDataFromJson(Map<String, dynamic> json) =>
    AttributesData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      input_name: json['input_name'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => OptionsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AttributesDataToJson(AttributesData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'input_name': instance.input_name,
      'options': instance.options?.map((e) => e.toJson()).toList(),
    };

OptionsData _$OptionsDataFromJson(Map<String, dynamic> json) => OptionsData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      color: json['color'],
      is_default: json['is_default'] as bool?,
    );

Map<String, dynamic> _$OptionsDataToJson(OptionsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'is_default': instance.is_default,
    };

CurrData _$CurrDataFromJson(Map<String, dynamic> json) => CurrData(
      name: json['name'] as String?,
      sign: json['sign'] as String?,
    );

Map<String, dynamic> _$CurrDataToJson(CurrData instance) => <String, dynamic>{
      'name': instance.name,
      'sign': instance.sign,
    };

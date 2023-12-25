// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      data: json['data'] == null
          ? null
          : CategoryData.fromJson(json['data'] as Map<String, dynamic>),
      status: json['status'],
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'status': instance.status,
      'msg': instance.msg,
    };

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      success: json['success'] as bool?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoriesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      top_product: (json['top_product'] as List<dynamic>?)
          ?.map((e) => TopProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
      latest_product: (json['latest_product'] as List<dynamic>?)
          ?.map((e) => LatestProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
      categories_count: json['categories_count'],
      top_product_count: json['top_product_count'],
      latest_product_count: json['latest_product_count'],
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'categories': instance.categories?.map((e) => e.toJson()).toList(),
      'top_product': instance.top_product?.map((e) => e.toJson()).toList(),
      'latest_product':
          instance.latest_product?.map((e) => e.toJson()).toList(),
      'categories_count': instance.categories_count,
      'top_product_count': instance.top_product_count,
      'latest_product_count': instance.latest_product_count,
    };

SlotsIdsData _$SlotsIdsDataFromJson(Map<String, dynamic> json) => SlotsIdsData(
      id: json['id'],
      name: json['name'] as String?,
      is_disabled: json['is_disabled'] as bool?,
    );

Map<String, dynamic> _$SlotsIdsDataToJson(SlotsIdsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_disabled': instance.is_disabled,
    };

SubCategoryModel _$SubCategoryModelFromJson(Map<String, dynamic> json) =>
    SubCategoryModel(
      data: json['data'] == null
          ? null
          : SubCategoryData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubCategoryModelToJson(SubCategoryModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
    };

SubCategoryData _$SubCategoryDataFromJson(Map<String, dynamic> json) =>
    SubCategoryData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      subs: (json['subs'] as List<dynamic>?)
          ?.map((e) => CategoriesData.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: json['data'] == null
          ? null
          : LatestProductListData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubCategoryDataToJson(SubCategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'photo': instance.photo,
      'subs': instance.subs?.map((e) => e.toJson()).toList(),
      'data': instance.data?.toJson(),
    };

LatestProductListData _$LatestProductListDataFromJson(
        Map<String, dynamic> json) =>
    LatestProductListData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LatestProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LatestProductListDataToJson(
        LatestProductListData instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

LatestProductData _$LatestProductDataFromJson(Map<String, dynamic> json) =>
    LatestProductData(
      id: json['id'],
      sku: json['sku'] as String?,
      name: json['name'] as String?,
      details: json['details'] as String?,
      text: json['text'] as String?,
      weight: json['weight'],
      category_id: json['category_id'],
      subcategory_id: json['subcategory_id'],
      childcategory_id: json['childcategory_id'],
      qty_in_cart: json['qty_in_cart'],
      coming_soon: json['coming_soon'] as bool?,
      is_top: json['is_top'] as bool?,
      is_latest: json['is_latest'] as bool?,
      is_featured: json['is_featured'] as bool?,
      is_Fav: json['is_Fav'] as bool?,
      is_discount: json['is_discount'] as int?,
      categoryName: json['categoryName'] as String?,
      photo: json['photo'] as String?,
      price: json['price'],
      previous_price: json['previous_price'],
      percent_discount: json['percent_discount'],
      has_attributes: json['has_attributes'] as bool?,
      curr: json['curr'] == null
          ? null
          : CurrData.fromJson(json['curr'] as Map<String, dynamic>),
      averageRating: json['averageRating'],
      discount_date: json['discount_date'] as String?,
    );

Map<String, dynamic> _$LatestProductDataToJson(LatestProductData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sku': instance.sku,
      'name': instance.name,
      'details': instance.details,
      'text': instance.text,
      'weight': instance.weight,
      'category_id': instance.category_id,
      'subcategory_id': instance.subcategory_id,
      'childcategory_id': instance.childcategory_id,
      'qty_in_cart': instance.qty_in_cart,
      'categoryName': instance.categoryName,
      'coming_soon': instance.coming_soon,
      'is_top': instance.is_top,
      'is_latest': instance.is_latest,
      'is_featured': instance.is_featured,
      'is_Fav': instance.is_Fav,
      'is_discount': instance.is_discount,
      'photo': instance.photo,
      'price': instance.price,
      'previous_price': instance.previous_price,
      'averageRating': instance.averageRating,
      'percent_discount': instance.percent_discount,
      'has_attributes': instance.has_attributes,
      'curr': instance.curr?.toJson(),
      'discount_date': instance.discount_date,
    };

TopProductListData _$TopProductListDataFromJson(Map<String, dynamic> json) =>
    TopProductListData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => TopProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopProductListDataToJson(TopProductListData instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

TopProductData _$TopProductDataFromJson(Map<String, dynamic> json) =>
    TopProductData(
      id: json['id'],
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
      is_discount: json['is_discount'] as int?,
      qty_in_cart: json['qty_in_cart'],
      photo: json['photo'] as String?,
      price: json['price'],
      previous_price: json['previous_price'],
      percent_discount: json['percent_discount'],
      has_attributes: json['has_attributes'] as bool?,
      curr: json['curr'] == null
          ? null
          : CurrData.fromJson(json['curr'] as Map<String, dynamic>),
      averageRating: json['averageRating'],
    );

Map<String, dynamic> _$TopProductDataToJson(TopProductData instance) =>
    <String, dynamic>{
      'id': instance.id,
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
      'averageRating': instance.averageRating,
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

CategoriesListData _$CategoriesListDataFromJson(Map<String, dynamic> json) =>
    CategoriesListData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoriesData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoriesListDataToJson(CategoriesListData instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
    };

CategoriesData _$CategoriesDataFromJson(Map<String, dynamic> json) =>
    CategoriesData(
        id: json['id'],
        name: json['name'] as String?,
        slug: json['slug'] as String?,
        photo: json['photo'] as String?,
        is_featured: json['is_featured'],
        product_count: json['product_count'],
        subs_count: json['subs_count'],
        has_attributes: json['has_attributes'] as bool?,
        category_id: json['category_id'] as int?,
        child: (json['child'] as List<dynamic>?)
            ?.map((e) => ChildsCategory.fromJson(e as Map<String, dynamic>))
            .toList());

Map<String, dynamic> _$CategoriesDataToJson(CategoriesData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.category_id,
      'name': instance.name,
      'slug': instance.slug,
      'photo': instance.photo,
      'is_featured': instance.is_featured,
      'product_count': instance.product_count,
      'subs_count': instance.subs_count,
      'has_attributes': instance.has_attributes,
      'child': instance.child?.map((e) => e.toJson()).toList(),
    };

ChildsCategory _$ChildsCategoryFromJson(Map<String, dynamic> json) =>
    ChildsCategory(
      id: json['id'],
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      photo: json['photo'] as String?,
      subcategory_id: json['subcategory_id'] as int?,
      // name_ar: json['name_ar'] as String?,
    );

Map<String, dynamic> _$ChildsCategoryToJson(ChildsCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subcategory_id': instance.subcategory_id,
      'name': instance.name,
      'slug': instance.slug,
      'photo': instance.photo,
      // 'name_ar': instance.name_ar,
    };

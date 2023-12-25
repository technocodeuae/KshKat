import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryModel {
  CategoryData? data;
  dynamic status;
  String? msg;
  CategoryModel({this.data, this.status, this.msg});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CategoryData {
  bool? success;
  List<CategoriesData>? categories;
  List<TopProductData>? top_product;
  List<LatestProductData>? latest_product;
  dynamic categories_count;
  dynamic top_product_count;
  dynamic latest_product_count;

  CategoryData({
    this.success,
    this.categories,
    this.top_product,
    this.latest_product,
    this.categories_count,
    this.top_product_count,
    this.latest_product_count,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SlotsIdsData {
  dynamic id;
  String? name;
  bool? is_disabled;

  SlotsIdsData({
    this.id,
    this.name,
    this.is_disabled,
  });

  factory SlotsIdsData.fromJson(Map<String, dynamic> json) =>
      _$SlotsIdsDataFromJson(json);
  Map<String, dynamic> toJson() => _$SlotsIdsDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SubCategoryModel {
  SubCategoryData? data;

  SubCategoryModel({this.data});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SubCategoryData {
  int? id;
  String? name;
  String? photo;
  List<CategoriesData>? subs;
  LatestProductListData? data;

  SubCategoryData({this.id, this.name, this.photo, this.subs, this.data});

  factory SubCategoryData.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$SubCategoryDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LatestProductListData {
  List<LatestProductData>? data;
  LatestProductListData({this.data});

  factory LatestProductListData.fromJson(Map<String, dynamic> json) =>
      _$LatestProductListDataFromJson(json);
  Map<String, dynamic> toJson() => _$LatestProductListDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LatestProductData {
  dynamic id;
  String? sku;
  String? name;
  String? details;
  String? text;
  var weight;
  var category_id;
  var subcategory_id;
  var childcategory_id;
  dynamic qty_in_cart;
  String? categoryName;
  bool? coming_soon;
  bool? is_top;
  bool? is_latest;
  bool? is_featured;
  bool? is_Fav;
  int? is_discount;
  String? photo;
  dynamic price;
  dynamic previous_price;
  dynamic averageRating;
  dynamic percent_discount;
  bool? has_attributes;
  CurrData? curr;
  String? discount_date;

  LatestProductData(
      {this.id,
      this.sku,
      this.name,
      this.details,
      this.text,
      this.weight,
      this.category_id,
      this.subcategory_id,
      this.childcategory_id,
      this.qty_in_cart,
      this.coming_soon,
      this.is_top,
      this.is_latest,
      this.is_featured,
      this.is_Fav,
      this.is_discount,
      this.categoryName,
      this.photo,
      this.price,
      this.previous_price,
      this.percent_discount,
      this.has_attributes,
      this.curr,
      this.averageRating,
      this.discount_date});

  factory LatestProductData.fromJson(Map<String, dynamic> json) =>
      _$LatestProductDataFromJson(json);
  Map<String, dynamic> toJson() => _$LatestProductDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TopProductListData {
  List<TopProductData>? data;
  TopProductListData({this.data});

  factory TopProductListData.fromJson(Map<String, dynamic> json) =>
      _$TopProductListDataFromJson(json);
  Map<String, dynamic> toJson() => _$TopProductListDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TopProductData {
  dynamic id;
  String? sku;
  String? name;
  String? details;
  String? text;
  dynamic weight;
  var category_id;
  var subcategory_id;
  var childcategory_id;
  bool? coming_soon;
  bool? is_top;
  bool? is_latest;
  bool? is_featured;
  bool? is_Fav;
  int? is_discount;
  dynamic qty_in_cart;
  String? photo;
  dynamic price;
  dynamic averageRating;
  dynamic previous_price;
  dynamic percent_discount;
  bool? has_attributes;
  CurrData? curr;

  TopProductData({
    this.id,
    this.sku,
    this.name,
    this.details,
    this.text,
    this.weight,
    this.category_id,
    this.subcategory_id,
    this.childcategory_id,
    this.coming_soon,
    this.is_top,
    this.is_latest,
    this.is_featured,
    this.is_Fav,
    this.is_discount,
    this.qty_in_cart,
    this.photo,
    this.price,
    this.previous_price,
    this.percent_discount,
    this.has_attributes,
    this.curr,
    this.averageRating,
  });

  factory TopProductData.fromJson(Map<String, dynamic> json) =>
      _$TopProductDataFromJson(json);
  Map<String, dynamic> toJson() => _$TopProductDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CurrData {
  String? name;
  String? sign;

  CurrData({
    this.name,
    this.sign,
  });

  factory CurrData.fromJson(Map<String, dynamic> json) =>
      _$CurrDataFromJson(json);
  Map<String, dynamic> toJson() => _$CurrDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CategoriesListData {
  List<CategoriesData>? data;
  CategoriesListData({this.data});

  factory CategoriesListData.fromJson(Map<String, dynamic> json) =>
      _$CategoriesListDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesListDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CategoriesData {
  dynamic id;
  int? category_id;
  String? name;
  String? slug;
  String? photo;
  dynamic is_featured;
  dynamic product_count;
  dynamic subs_count;
  bool? has_attributes;
  List<ChildsCategory>? child;

  CategoriesData({
    this.id,
    this.name,
    this.slug,
    this.photo,
    this.is_featured,
    this.product_count,
    this.subs_count,
    this.has_attributes,
    this.category_id,
    this.child,
  });

  factory CategoriesData.fromJson(Map<String, dynamic> json) =>
      _$CategoriesDataFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ChildsCategory {
  dynamic id;
  int? subcategory_id;
  String? name;
  // String? name_ar;
  String? slug;
  String? photo;

  ChildsCategory({
    this.id,
    this.name,
    this.slug,
    this.photo,
    // this.name_ar,
    this.subcategory_id,
  });

  factory ChildsCategory.fromJson(Map<String, dynamic> json) =>
      _$ChildsCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ChildsCategoryToJson(this);
}

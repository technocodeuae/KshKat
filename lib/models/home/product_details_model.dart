import 'package:json_annotation/json_annotation.dart';

part 'product_details_model.g.dart';



@JsonSerializable(explicitToJson: true)
class ProductDetailsModel {
  bool? success;
  ProductDetailsData? product_data;
  String? message;
  int? total_record;
  ProductDetailsModel({
    this.success,
    this.product_data,
    this.message,
    this.total_record,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => _$ProductDetailsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductDetailsData{
  int? id;
  String? sku;
  String? name;
  String? details;
  String? slug;
  dynamic weight;
  int? category_id;
  String? category_name;
  int? subcategory_id;
  String? subcategory_name;
  dynamic childcategory_id;
  String? childcategory_name;
  bool? coming_soon;
  int? qty_in_cart;
  List<dynamic>? galleries;
  bool? is_top;
  bool? is_latest;
  bool? is_featured;
  bool? is_Fav;
  dynamic is_discount;
  List<AttributesData>? attributes;
  List<AttributesPriceData>? attributes_price;
  String? photo;
  int? quantity;// not exist
  dynamic price;
  dynamic previous_price;
  int? percent_discount;
  bool? has_attributes;
  List<String>? options_ids;// not exist 
  List<RatingsData>? ratings;
  CurrData? curr;
  dynamic averageRating;

  ProductDetailsData({
    this.id,
    this.sku,
    this.name,
    this.details,
    this.slug,
    this.weight,
    this.category_id,
    this.subcategory_id,
    this.childcategory_id,
    this.coming_soon,
    this.qty_in_cart,
    this.galleries,
    this.is_top,
    this.is_latest,
    this.is_featured,
    this.is_Fav,
    this.is_discount,
    this.attributes,
    this.attributes_price,
    this.photo,
    this.quantity,
    this.price,
    this.previous_price,
    this.percent_discount,
    this.has_attributes,
    this.options_ids,
    this.curr,
    this.category_name,
    this.childcategory_name,
    this.subcategory_name,
  });

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) => _$ProductDetailsDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailsDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class RatingsData{
  int? id;
  int? user_id;
  int? product_id;
  String? review;
  String? review_date;
  String? user_name;
  String? user_photo;
  dynamic rating;

  RatingsData({
    this.id,
    this.user_id,
    this.product_id,
    this.rating,
    this.review,
    this.review_date,
    this.user_name,
    this.user_photo,
  });

  factory RatingsData.fromJson(Map<String, dynamic> json) => _$RatingsDataFromJson(json);
  Map<String, dynamic> toJson() => _$RatingsDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class AttributesPriceData{
  int? id;
  String? name;
  dynamic product_id;
  dynamic qty;
  dynamic price;
  dynamic is_default;
  String? created_at;
  String? updated_at;
  List<OptionsData>? options;
  dynamic main_id;
  String? ids;

  AttributesPriceData({
    this.id,
    this.name,
    this.product_id,
    this.qty,
    this.price,
    this.is_default,
    this.created_at,
    this.updated_at,
    this.options,
    this.ids,
    this.main_id,
  });

  factory AttributesPriceData.fromJson(Map<String, dynamic> json) => _$AttributesPriceDataFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesPriceDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class AttributesData{
  int? id;
  String? name;
  String? input_name;
  List<OptionsData>? options;

  AttributesData({
    this.id,
    this.name,
    this.input_name,
    this.options,
  });

  factory AttributesData.fromJson(Map<String, dynamic> json) => _$AttributesDataFromJson(json);
  Map<String, dynamic> toJson() => _$AttributesDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class OptionsData{
  int? id;
  String? name;
  var color;
  bool? is_default;

  OptionsData({
    this.id,
    this.name,
    this.color,
    this.is_default,
  });

  factory OptionsData.fromJson(Map<String, dynamic> json) => _$OptionsDataFromJson(json);
  Map<String, dynamic> toJson() => _$OptionsDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class CurrData{
  String? name;
  String? sign;

  CurrData({
    this.name,
    this.sign,
  });

  factory CurrData.fromJson(Map<String, dynamic> json) => _$CurrDataFromJson(json);
  Map<String, dynamic> toJson() => _$CurrDataToJson(this);

}


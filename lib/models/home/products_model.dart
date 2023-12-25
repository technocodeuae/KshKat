import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart';



@JsonSerializable(explicitToJson: true)
class ProductsModel {
  List<ProductData>? data;
  int? status;
  String? msg;
  ProductsModel({
    this.data,
    this.status,
    this.msg
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => _$ProductsModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);
}
@JsonSerializable(explicitToJson: true)
class ProductData {
  int? id;
  String? name;
  String? slug;
  String? photo;
  String? is_featured;
  List<SubsData>? subs;
  ProductsData? products;
  int? product_count;
  int? subs_count;
  bool? has_attributes;

  ProductData({
    this.id,
    this.name,
    this.slug,
    this.photo,
    this.is_featured,
    this.subs,
    this.products,
    this.product_count,
    this.subs_count,
    this.has_attributes,

  });

  factory ProductData.fromJson(Map<String, dynamic> json) => _$ProductDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductsData{
  List<DataData>? data;
  LinksData? links;
  MetaData? meta;

  ProductsData({
    this.data,
    this.links,
    this.meta,
  });

  factory ProductsData.fromJson(Map<String, dynamic> json) => _$ProductsDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class MetaData{
  int? current_page;
  int? from;
  int? last_page;
  String? path;
  String? per_page;
  int? to;
  int? total;

  MetaData({
    this.current_page,
    this.from,
    this.last_page,
    this.path,
    this.per_page,
    this.to,
    this.total,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) => _$MetaDataFromJson(json);
  Map<String, dynamic> toJson() => _$MetaDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class LinksData{
  String? first;
  String? last;
  var prev;
  var next;

  LinksData({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory LinksData.fromJson(Map<String, dynamic> json) => _$LinksDataFromJson(json);
  Map<String, dynamic> toJson() => _$LinksDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class DataData{
  int? id;
  int? quantity;
  String? sku;
  String? name;
  String? details;
  String? text;
  int? weight;
  int? category_id;
  int? subcategory_id;
  int? childcategory_id;
  bool? coming_soon;
  bool? is_top;
  bool? is_latest;
  bool? is_featured;
  bool? is_Fav;
  bool? is_discount;
  int? qty_in_cart;
  String? photo;
  double? price;
  double? previous_price;
  double? percent_discount;
  bool? has_attributes;
  CurrData? curr;

  DataData({
    this.id,
    this.quantity,
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
  });

  factory DataData.fromJson(Map<String, dynamic> json) => _$DataDataFromJson(json);
  Map<String, dynamic> toJson() => _$DataDataToJson(this);

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

@JsonSerializable(explicitToJson: true)
class SubsData{
  int? id;
  String? category_id;
  String? name;
  String? slug;
  int? products_count;
  int? child_count;
  bool? has_attributes;

  SubsData({
    this.id,
    this.category_id,
    this.name,
    this.slug,
    this.products_count,
    this.child_count,
    this.has_attributes,
  });

  factory SubsData.fromJson(Map<String, dynamic> json) => _$SubsDataFromJson(json);
  Map<String, dynamic> toJson() => _$SubsDataToJson(this);

}


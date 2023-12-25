import 'package:erp/models/home/products_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_fav_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductsFavModel {
  DataProducts? data;
  int? status;
  String? msg;
  ProductsFavModel({this.data, this.status, this.msg});

  factory ProductsFavModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsFavModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsFavModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DataProducts {
  bool? success;
  List<ProductsData>? products;
  List<ProductsData>? product;
  List<ProductsData>? product_data;
  int? products_count;

  DataProducts({
    this.success,
    this.products,
    this.product,
    this.products_count,
    this.product_data,
  });

  factory DataProducts.fromJson(Map<String, dynamic> json) =>
      _$DataProductsFromJson(json);
  Map<String, dynamic> toJson() => _$DataProductsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MetaData {
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

  factory MetaData.fromJson(Map<String, dynamic> json) =>
      _$MetaDataFromJson(json);
  Map<String, dynamic> toJson() => _$MetaDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LinksData {
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

  factory LinksData.fromJson(Map<String, dynamic> json) =>
      _$LinksDataFromJson(json);
  Map<String, dynamic> toJson() => _$LinksDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductsData {
  int? id;
  int? quantity;
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
  bool? is_discount;
  int? qty_in_cart;
  String? photo;
  dynamic price;

  dynamic previous_price;
  dynamic percent_discount;
  bool? has_attributes;
  CurrData? curr;

  ProductsData({
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

  factory ProductsData.fromJson(Map<String, dynamic> json) =>
      _$ProductsDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsDataToJson(this);
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

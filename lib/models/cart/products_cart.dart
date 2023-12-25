import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'products_cart.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductsCart {
  List<Products> products;

  ProductsCart({required this.products});

  factory ProductsCart.fromJson(Map<String, dynamic> json) => _$ProductsCartFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsCartToJson(this);

  static Map<String, dynamic> toMap(ProductsCart products) => {
    "products": products,
  };

  static String encode(List<ProductsCart> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => ProductsCart.toMap(music))
        .toList(),
  );

  static List<ProductsCart> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<ProductsCart>((item) => ProductsCart.fromJson(item))
          .toList();

}

@JsonSerializable(explicitToJson: true)
class ProData{
  Products? products;

  ProData({
    this.products,
  });

  factory ProData.fromJson(Map<String, dynamic> json) => _$ProDataFromJson(json);
  Map<String, dynamic> toJson() => _$ProDataToJson(this);

}

@JsonSerializable(explicitToJson: true)
class Products{
  int? id;
  String? name;
  var description;
  String? api_image_url;
  double? listPrice;
  double? virtual_available;
  double? qty_available;
  double? price;
  bool? is_discount;
  bool? is_comming_soon;
  String? tax;
  String? disc;
  int? quantity;


  Products(
      {this.id,
      this.name,
      this.description,
      this.api_image_url,
      this.listPrice,
      this.virtual_available,
      this.qty_available,
      this.price,
      this.is_discount,
      this.is_comming_soon,
      this.tax,
      this.disc,
      this.quantity});

/*  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "description": this.description,
      "api_image_url": this.api_image_url,
      "listprice": this.list_price,
      "virtual_available": this.virtual_available,
      "qty_available": this.qty_available,
      "price": this.price,
      "is_comming_soon": this.is_comming_soon,
      "tax": this.tax,
      "disc": this.disc,
      "quantity": this.quantity,
    };
  }*/

  factory Products.fromJson(Map<String, dynamic> json) => _$ProductsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsToJson(this);

  /*factory Products.fromJson(Map<String, dynamic> jsonData) {
    return Products(
      id: jsonData['id'],
      name: jsonData['name'],
      description: jsonData['description'],
      api_image_url: jsonData['api_image_url'],
      list_price: jsonData['listprice'],
      virtual_available: jsonData['virtual_available'],
      qty_available: jsonData['qty_available'],
      is_comming_soon: jsonData['is_comming_soon'],
      tax: jsonData['tax'],
      disc: jsonData['disc'],
      quantity: jsonData['quantity'],
    );
  }*/

  static Map<String, dynamic> toMap(Products products) => {
    "id": products.id,
    "name": products.name,
    "description": products.description,
    "api_image_url": products.api_image_url,
    "listPrice": products.listPrice,
    "virtual_available": products.virtual_available,
    "qty_available": products.qty_available,
    "price": products.price,
    "is_comming_soon": products.is_comming_soon,
    "tax": products.tax,
    "disc": products.disc,
    "quantity": products.quantity,
    "is_discount": products.is_discount,
  };

  static String encode(List<Products> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => Products.toMap(music))
        .toList(),
  );

  static List<Products> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Products>((item) => Products.fromJson(item))
          .toList();
  
}


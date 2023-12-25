import 'dart:async';

import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';
import 'package:erp/models/home/products_model.dart';

import '../../../../models/cart/cart_save_model.dart';
import '../../../../models/home/fav_model.dart';
import '../../../../models/home/product_details_model.dart';
import '../../../../models/home/products_fav_model.dart';

class ProductsApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  ProductsApi(this._dioClient, this._restClient);

  /// Returns list of mom and actions in response
  Future<ProductsModel> getProducts({
    required CancelToken cancelToken,
    required int limit,
    required int page,
    required String lang,
  }) async {
    try {
      final res = await _dioClient.get(Endpoints.ProductsUrl,
          cancelToken: cancelToken,
          queryParameters: {'limit': limit, 'pages': page, 'lang': lang});
      return ProductsModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<DataProducts> getProductsFav({
    required CancelToken cancelToken,
    required int limit,
    required int page,
    required String lang,
    required isFav,
  }) async {
    try {
      final res;
      if (isFav)
        res = await _dioClient.get(Endpoints.ProductsFavUrl,
            cancelToken: cancelToken,
            queryParameters: {
              'limit': limit,
              'pages': page,
              'lang': lang,
              'is_Fav': isFav
            });
      else
        res = await _dioClient.get(Endpoints.ProductsFavUrl,
            cancelToken: cancelToken,
            queryParameters: {'limit': limit, 'pages': page, 'lang': lang});
      return DataProducts.fromJson(res);
    } catch (e) {
      print('here errrrrrrrror from fav page : ' + e.toString());
      throw e;
    }
  }

  Future<DataProducts> searchProducts({
    required CancelToken cancelToken,
    required int limit,
    required int page,
    required String lang,
    required search,
  }) async {
    try {
      final res = await _dioClient.post(Endpoints.NewSearchProductsUrl,
          cancelToken: cancelToken,
          data: {
            'slug': search
          },
          queryParameters: {
            'limit': limit,
            'pages': page,
            'lang': lang,
            // 'q': search
          });
      print(
          "here      response from search ${DataProducts.fromJson(res).product_data}");
      return DataProducts.fromJson(res);
    } catch (e) {
      print('here errror From search ' + e.toString());
      throw e;
    }
  }

  Future<FavModel> addFav({
    required CancelToken cancelToken,
    required id,
  }) async {
    try {
      final res = await _dioClient.post(Endpoints.ProductAddFavUrl,
          cancelToken: cancelToken, queryParameters: {'product_id': id});
      return FavModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<FavModel> deleteFav({
    required CancelToken cancelToken,
    required id,
  }) async {
    try {
      final res = await _dioClient.post(
          Endpoints.ProductDeleteFavUrl + "/" + id.toString(),
          cancelToken: cancelToken);
      return FavModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ProductDetailsModel> getProductDetails({
    required CancelToken cancelToken,
    required id,
    required String lang,
  }) async {
    try {
      print("here eeeeeeeeeeeeeee idddddddddddddd ${id}");
      final res = await _dioClient.post(
        Endpoints.ProductDetailsUrl,
        cancelToken: cancelToken,
        queryParameters: {'id': id.toString(), 'lang': lang},
      );
      print("resssssssssssss $res");
      return ProductDetailsModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<CartSaveModel> saveCart({
    required CancelToken cancelToken,
    required data,
    required List<Map<String, dynamic>> defaulAttributes,
  }) async {
    try {
      // print("${data['attributes'].length}fffffffffffuc${data['attributes']}");

      if (data['attributes'].length > 2) {
        // print("fffffffffffuc");
        for (int j = 0; j < defaulAttributes.length; j++) {
          if (data['attributes'].contains(defaulAttributes[j])) {
            // print("fffffffffffuc");
            data['attributes'].remove(defaulAttributes[j]);
            if (data['attributes'].length == 2) {
              // print('fffffffffffuc' + data);
              break;
            }
          }
        }
      }
      final res = await _dioClient.post(Endpoints.SaveCartUrl,
          cancelToken: cancelToken, data: data);

      print("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF ${data['attributes']}");
      return CartSaveModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}

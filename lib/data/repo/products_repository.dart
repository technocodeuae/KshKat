import 'dart:async';

import 'package:erp/data/network/apis/home/products_api.dart';
import 'package:erp/models/home/products_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';

import '../../models/cart/cart_model.dart';
import '../../models/cart/cart_save_model.dart';
import '../../models/home/fav_model.dart';
import '../../models/home/product_details_model.dart';
import '../../models/home/products_fav_model.dart';

class ProductsRepository {

  // api objects
  final ProductsApi _productsApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  ProductsRepository(this._productsApi, this._sharedPrefsHelper);

  /// warehouse EndPoints: ---------------------------------------------------------------------

  Future<ProductsModel> getProducts(
      {required CancelToken cancelToken,
        required int limit,
        required String lang,
      required int page}) async {
    var _info =
        await _productsApi.getProducts(cancelToken: cancelToken,limit:limit,page:page,lang:lang);
    return _info;
  }

  Future<DataProducts> getProductsFav(
      {required CancelToken cancelToken,
        required int limit,
        required String lang,
        required  isFav,
        required int page}) async {
    var _info =
    await _productsApi.getProductsFav(cancelToken: cancelToken,limit:limit,page:page,lang:lang,isFav:isFav);
    return _info;
  }

  Future<DataProducts> searchProducts(
      {required CancelToken cancelToken,
        required int limit,
        required String lang,
        required  search,
        required int page}) async {
    var _info =
    await _productsApi.searchProducts(cancelToken: cancelToken,limit:limit,page:page,lang:lang,search:search);
    return _info;
  }

  Future<FavModel> addFav(
      {required CancelToken cancelToken,
        required  id}) async {
    var _info =
    await _productsApi.addFav(cancelToken: cancelToken,id:id);
    return _info;
  }

  Future<FavModel> deleteFav(
      {required CancelToken cancelToken,
        required  id}) async {
    var _info =
    await _productsApi.deleteFav(cancelToken: cancelToken,id:id);
    return _info;
  }

  Future<ProductDetailsModel> getProductDetails(
      {required CancelToken cancelToken,
        required  id,
        required String lang,
      }) async {
    var _info =
    await _productsApi.getProductDetails(cancelToken: cancelToken,id:id,lang:lang);
    return _info;
  }

  Future<CartSaveModel> saveCart(
      {required CancelToken cancelToken,
        required  data,
required      List<Map<String, dynamic>> defaulAttributes,

      }) async {
    var _info =
    await _productsApi.saveCart(cancelToken: cancelToken,data:data,
    defaulAttributes:defaulAttributes,
    );
    return _info;
  }

}

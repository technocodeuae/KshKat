import 'dart:async';

import 'package:erp/data/network/apis/home/cart_api.dart';
import 'package:erp/data/network/apis/home/products_api.dart';
import 'package:erp/models/cart/cart_model.dart';
import 'package:erp/models/home/products_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';

import '../../models/cart/cart_result_validate.dart';
import '../../models/cart/cart_save_model.dart';
import '../../models/cart/cart_validate_model.dart';
import '../../models/pickup/pickup_validate_model.dart';

class CartRepository {
  // api objects
  final CartApi _cartApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  CartRepository(this._cartApi, this._sharedPrefsHelper);

  /// warehouse EndPoints: ---------------------------------------------------------------------

  Future<CartResultValidate> validateCart(
      {required CancelToken cancelToken, required data}) async {
    var _info =
        await _cartApi.validateCart(cancelToken: cancelToken, data: data);
    return _info;
  }

  Future<PickupValidateData> validateTime(
      {required CancelToken cancelToken, required data}) async {
    var _info =
        await _cartApi.validateTime(cancelToken: cancelToken, data: data);
    return _info;
  }

  Future<CartModel> getCart(
      {required CancelToken cancelToken,
      required int limit,
      required int page,
      required lang}) async {
    var _info = await _cartApi.getCart(
        cancelToken: cancelToken, limit: limit, page: page, lang: lang);
    return _info;
  }

  Future<CartSaveModel> clearCart(
      {required CancelToken cancelToken, required int? id}) async {
    var _info = await _cartApi.clearCart(cancelToken: cancelToken, id: id);
    return _info;
  }

  Future<CartSaveModel> addMinusProduct(
      {required CancelToken cancelToken,
      required int cart_id,
      required int product_id,
      required String operation,
      }) async {
    var _info = await _cartApi.addMinusProduct(
        product_id: product_id,
        cart_id: cart_id,
        operation: operation,
        cancelToken: cancelToken,
        );
    return _info;
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';
import 'package:erp/models/home/products_model.dart';

import '../../../../models/cart/cart_model.dart';
import '../../../../models/cart/cart_result_validate.dart';
import '../../../../models/cart/cart_save_model.dart';
import '../../../../models/cart/cart_validate_model.dart';
import '../../../../models/pickup/pickup_validate_model.dart';

class CartApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  CartApi(this._dioClient, this._restClient);

  /// Returns list of mom and actions in response
  Future<PickupValidateData> validateTime({
    required CancelToken cancelToken,
    required data,
  }) async {
    try {
      final res = await _dioClient.post(Endpoints.validateTime,
          cancelToken: cancelToken, data: data);
      return PickupValidateData.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<CartResultValidate> validateCart({
    required CancelToken cancelToken,
    required data,
  }) async {
    try {
      final res = await _dioClient.post(Endpoints.validateCart,
          cancelToken: cancelToken, data: data);
      return CartResultValidate.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<CartModel> getCart(
      {required CancelToken cancelToken,
      required int limit,
      required int page,
      required lang}) async {
    try {
      final res = await _dioClient.get(
        Endpoints.getCart,
        cancelToken: cancelToken,
        queryParameters: {/*'limit': limit,'page': page,*/ 'lang': lang},
      );
      print("cartttttttttttttttttt $res");
      return CartModel.fromJson(res);
    } catch (e) {
      print("errrorr from cartttttttttttt" + e.toString());
      throw e;
    }
  }

  Future<CartSaveModel> clearCart(
      {required CancelToken cancelToken, required int? id}) async {
    try {
      final res = await _dioClient.post(
          Endpoints.clearCart +
              "${id == null ? '' : "/$id"}", //  "/"+id.toString(),
          cancelToken: cancelToken);
      print("here Clear cart $res");
      return CartSaveModel.fromJson(res);
    } catch (e) {
      print('here clear cart errorrrrr ' + e.toString());
      throw e;
    }
  }

  Future<CartSaveModel> addMinusProduct({
    required CancelToken cancelToken,
    required int cart_id,
    required int product_id,
    required String operation,
  }) async {
    try {
      final res = await _dioClient.post(Endpoints.addMinusProductRul,
          data: {
            'cart_id': cart_id,
            'product_id': product_id,
            'operation': operation,
            'quantity': 1
          },
          // "${id == null ? '' : "/$id"}", //  "/"+id.toString(),
          cancelToken: cancelToken);
      print("here Add minus product from carttt cart $res");
      return CartSaveModel.fromJson(res);
    } catch (e) {
      print('here Add minus product from carttt cart errorrrrr ' + e.toString());
      throw e;
    }
  }
}

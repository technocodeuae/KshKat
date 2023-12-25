import 'dart:async';

import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';
import 'package:erp/models/home/products_model.dart';

import '../../../../models/cart/cart_result_validate.dart';
import '../../../../models/cart/cart_validate_model.dart';
import '../../../../models/general/general_model.dart';
import '../../../../models/pickup/pickup_validate_model.dart';

class CheckoutApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  CheckoutApi(this._dioClient, this._restClient);

  /// Returns list of mom and actions in response
  Future<GeneralModel> checkout(
      {required CancelToken cancelToken,
        required  data,
      }) async {
    try {
      final res = await _dioClient.post(Endpoints.checkout,
          cancelToken: cancelToken,data: data);
      return GeneralModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<Map> checkCopuon(
      {required CancelToken cancelToken,
        required  data,
      }) async {
    try {
      final res = await _dioClient.post(Endpoints.checkCopuon,
          cancelToken: cancelToken,data: data);
          print("o bje${res.runtimeType}ct  $res");
      return res['data'];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}

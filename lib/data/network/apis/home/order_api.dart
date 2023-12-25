import 'dart:async';

import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';
import 'package:erp/models/general/general_model.dart';
import 'package:erp/models/order/order_model.dart';

class OrderApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  OrderApi(this._dioClient, this._restClient);

  /// Returns list of mom and actions in response
  Future<OrderModel> getOrder(
      {required CancelToken cancelToken,
        required int limit,
        required int page,
        required lang
      }) async {
    try {
      final res = await _dioClient.get(Endpoints.OrderUrl,
          cancelToken: cancelToken,queryParameters: {'limit': limit,'pages': page,'lang':lang},);
      return OrderModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<GeneralModel> cancelOrder(
      {required CancelToken cancelToken,
        required int id
      }) async {
    try {
      final res = await _dioClient.delete(Endpoints.OrderUrl+"/"+id.toString(),
        cancelToken: cancelToken,);
      return GeneralModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}

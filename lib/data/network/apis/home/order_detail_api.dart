import 'dart:async';
import 'dart:convert';

import 'package:erp/models/order/order_details_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';

class OrderDetailApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  OrderDetailApi(this._dioClient, this._restClient);

  /// Returns list of mom and actions in response
  Future<OrderDetailsModel> getOrderDetail(
      {required CancelToken cancelToken,
        required  lang,
        required  id
      }) async {
    try {
      final res = await _dioClient.get(Endpoints.OrderDetailsUrl+"/"+id.toString(),
          cancelToken: cancelToken,queryParameters: {'lang': lang},);


      return OrderDetailsModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}

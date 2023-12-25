import 'dart:async';

import 'package:erp/models/pickup/pickup_time_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';

class PickUpTimeApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  PickUpTimeApi(this._dioClient, this._restClient);

  /// Returns list of mom and actions in response
  Future<PickupTimeModel> getPickUpTime(
      {required CancelToken cancelToken,
      }) async {
    try {
      final res = await _dioClient.get(Endpoints.PickupTimeUrl,
          cancelToken: cancelToken,);
      return PickupTimeModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}

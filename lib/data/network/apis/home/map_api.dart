import 'dart:async';

import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';
import 'package:erp/models/address/map_model.dart';

class MapApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  MapApi(this._dioClient, this._restClient);

  /// Returns list of mom and actions in response
  Future<MapData> saveAddress(
      {required CancelToken cancelToken,
        required Map<String, dynamic> data
      }) async {
    try {
      final res = await _dioClient.post(Endpoints.addressUrl,data:data,
          cancelToken: cancelToken,);
      return MapData.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}

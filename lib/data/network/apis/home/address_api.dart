import 'dart:async';

import 'package:erp/models/address/address_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';

class AddressApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  AddressApi(this._dioClient, this._restClient);

  /// Returns list of mom and actions in response
  Future<AddressModel> getAddress(
      {required CancelToken cancelToken,
      }) async {
    try {
      final res = await _dioClient.get(Endpoints.AddressUrl,
        cancelToken: cancelToken,);
      return AddressModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}

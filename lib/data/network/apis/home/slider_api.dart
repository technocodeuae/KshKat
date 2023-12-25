import 'dart:async';

import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';

import '../../../../models/home/slider_model.dart';



class SliderApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  SliderApi(this._dioClient, this._restClient);

  /// Returns list of mom and actions in response
  Future<SliderListData> getSlider({
    required CancelToken cancelToken,
    required String lang,
  }) async {
    try {
      final res = await _dioClient.post(Endpoints.SliderUrl,
          cancelToken: cancelToken, queryParameters: {'lang': lang});
      return SliderListData.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}

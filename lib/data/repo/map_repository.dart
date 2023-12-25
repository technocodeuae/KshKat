import 'dart:async';

import 'package:erp/data/network/apis/home/map_api.dart';
import 'package:erp/models/address/map_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';

class MapRepository {

  // api objects
  final MapApi _mapApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  MapRepository(this._mapApi, this._sharedPrefsHelper);

  /// offer EndPoints: ---------------------------------------------------------------------

  Future<MapData> saveAddress(
      {required CancelToken cancelToken,
        required Map<String, dynamic> data}) async {
    var _info =
        await _mapApi.saveAddress(cancelToken: cancelToken,data:data);
    return _info;
  }

}

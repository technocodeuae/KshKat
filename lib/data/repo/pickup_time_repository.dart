import 'dart:async';

import 'package:erp/data/network/apis/home/products_api.dart';
import 'package:erp/data/network/apis/home/pickup_time_api.dart';
import 'package:erp/models/pickup/pickup_time_model.dart';
import 'package:erp/models/home/products_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';

class PickUpTimeRepository {

  // api objects
  final PickUpTimeApi _pickupApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  PickUpTimeRepository(this._pickupApi, this._sharedPrefsHelper);

  /// warehouse EndPoints: ---------------------------------------------------------------------

  Future<PickupTimeModel> getPickUpTime(
      {required CancelToken cancelToken,
      }) async {
    var _info =
        await _pickupApi.getPickUpTime(cancelToken: cancelToken,);
    return _info;
  }

}

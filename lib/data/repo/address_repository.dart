import 'dart:async';

import 'package:erp/data/network/apis/home/address_api.dart';
import 'package:erp/models/address/address_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';

class AddressRepository {
  // api objects
  final AddressApi _itemApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  AddressRepository(this._itemApi, this._sharedPrefsHelper);

  /// item EndPoints: ---------------------------------------------------------------------

  Future<AddressModel> getAddress(
      {required CancelToken cancelToken,
       }) async {
    var _info =
    await _itemApi.getAddress(cancelToken: cancelToken);
    return _info;
  }

}

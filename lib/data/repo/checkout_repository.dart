import 'dart:async';

import 'package:erp/data/network/apis/home/cart_api.dart';
import 'package:erp/data/network/apis/home/products_api.dart';
import 'package:erp/models/general/general_model.dart';
import 'package:erp/models/home/products_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';

import '../../models/cart/cart_result_validate.dart';
import '../../models/cart/cart_validate_model.dart';
import '../../models/pickup/pickup_validate_model.dart';
import '../network/apis/home/checkout_api.dart';

class CheckoutRepository {

  // api objects
  final CheckoutApi _checkoutApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  CheckoutRepository(this._checkoutApi, this._sharedPrefsHelper);

  /// warehouse EndPoints: ---------------------------------------------------------------------

  Future<GeneralModel> checkout(
      {required CancelToken cancelToken,
        required  data}) async {
    var _info =
        await _checkoutApi.checkout(cancelToken: cancelToken,data: data);
    return _info;
  }

   Future<Map> checkCopuon(
      {required CancelToken cancelToken,
        required  data}) async {
    var _info =
        await _checkoutApi.checkCopuon(cancelToken: cancelToken,data: data);
    return _info;
  }

}

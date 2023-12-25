import 'dart:async';

import 'package:erp/data/network/apis/home/order_api.dart';
import 'package:erp/models/general/general_model.dart';
import 'package:erp/models/order/order_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';

class OrderRepository {
  // api objects
  final OrderApi _orderApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  OrderRepository(this._orderApi, this._sharedPrefsHelper);

  /// order EndPoints: ---------------------------------------------------------------------

  Future<OrderModel> getOrder(
      {required CancelToken cancelToken,
      required int limit,
      required int page,
      required lang
      }) async {
    var _info =
        await _orderApi.getOrder(cancelToken: cancelToken,limit:limit,page:page,lang:lang);
    return _info;
  }

  Future<GeneralModel> cancelOrder(
      {required CancelToken cancelToken,
        required int id}) async {
    var _info =
    await _orderApi.cancelOrder(cancelToken: cancelToken,id:id);
    return _info;
  }

}

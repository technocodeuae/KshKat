import 'dart:async';

import 'package:erp/data/network/apis/home/order_detail_api.dart';
import 'package:erp/models/order/order_details_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';

class OrderDetailRepository {

  // api objects
  final OrderDetailApi _orderDetailApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  OrderDetailRepository(this._orderDetailApi, this._sharedPrefsHelper);

  /// orderDetail EndPoints: ---------------------------------------------------------------------

  Future<OrderDetailsModel> getOrderDetail(
      {required CancelToken cancelToken,
      required  lang,
      required  id}) async {
    var _info =
        await _orderDetailApi.getOrderDetail(cancelToken: cancelToken,lang:lang,id:id);
    return _info;
  }

}

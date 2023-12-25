import 'dart:async';

import 'package:dio/dio.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';

import '../../models/home/slider_model.dart';
import '../network/apis/home/slider_api.dart';


class SliderRepository {
  // api objects
  final SliderApi _SliderApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  SliderRepository(this._SliderApi, this._sharedPrefsHelper);

  /// warehouse EndPoints: ---------------------------------------------------------------------

  Future<SliderListData> getSlider(
      {required CancelToken cancelToken, required lang}) async {
    var _info =
        await _SliderApi.getSlider(cancelToken: cancelToken, lang: lang);
    return _info;
  }
}

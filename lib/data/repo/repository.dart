import 'dart:async';
import 'package:erp/data/network/apis/app/app_api.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';

class Repository {

  // api objects
  final AppApi _appApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._appApi, this._sharedPrefsHelper);


  // Theme: -----------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  String? get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart/products_cart.dart';
import 'constants/preferences.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  // General Methods: ----------------------------------------------------------
  Future<String?> get authToken async {
    return _sharedPreference.getString(Preferences.auth_token);
  }

  Future<bool> saveAuthToken(String authToken) async {
    return _sharedPreference.setString(Preferences.auth_token, authToken);
  }

  Future<bool> removeAuthToken() async {
    return _sharedPreference.remove(Preferences.auth_token);
  }

  Future<String?> get deviceToken async {
    return _sharedPreference.getString(Preferences.device_token);
  }

  Future<bool> saveDeviceToken(String deviceToken) async {
    return _sharedPreference.setString(Preferences.device_token, deviceToken);
  }

  Future<bool> removeDeviceToken() async {
    return _sharedPreference.remove(Preferences.device_token);
  }

  Future<String?> get userInfo async {
    return _sharedPreference.getString(Preferences.user_info);
  }

  Future<bool> saveUserInfo(String authToken) async {
    return _sharedPreference.setString(Preferences.user_info, authToken);
  }

  Future<bool> removeUserInfo() async {
    return _sharedPreference.remove(Preferences.user_info);
  }

  Future<String?> get address async {
    return _sharedPreference.getString(Preferences.address);
  }

  Future<bool> saveAddress(String authToken) async {
    return _sharedPreference.setString(Preferences.address, authToken);
  }

  Future<bool> removeAddress() async {
    return _sharedPreference.remove(Preferences.address);
  }

  Future<String?> get addressId async {
    return _sharedPreference.getString(Preferences.addressId);
  }

  Future<bool> saveAddressId(String authToken) async {
    return _sharedPreference.setString(Preferences.addressId, authToken);
  }

  Future<bool> removeAddressId() async {
    return _sharedPreference.remove(Preferences.addressId);
  }

  Future<int?> get numCart async {
    return _sharedPreference.getInt(Preferences.numCart);
  }

  Future<bool> saveNumCart(int authToken) async {
    return _sharedPreference.setInt(Preferences.numCart, authToken);
  }

  Future<bool> removeNumCart() async {
    return _sharedPreference.remove(Preferences.numCart);
  }

  Future<String?> get cart async {
    return _sharedPreference.getString(Preferences.cart);
  }

  Future<bool> saveCart(List<Products> authToken) async {
    return _sharedPreference.setString(Preferences.cart, json.encode(
      authToken
          .map<Map<String, dynamic>>((music) => Products.toMap(music))
          .toList(),
    ));
  }

  Future<bool> removeCart() async {
    return _sharedPreference.remove(Preferences.cart);
  }

  Future<String?> get time async {
    return _sharedPreference.getString(Preferences.time);
  }

  Future<bool> saveTime(String authToken) async {
    return _sharedPreference.setString(Preferences.time, authToken);
  }

  Future<bool> removeTime() async {
    return _sharedPreference.remove(Preferences.time);
  }

  Future<String?> get timeId async {
    return _sharedPreference.getString(Preferences.timeId);
  }

  Future<bool> saveTimeId(String authToken) async {
    return _sharedPreference.setString(Preferences.timeId, authToken);
  }

  Future<bool> removeTimeId() async {
    return _sharedPreference.remove(Preferences.timeId);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> get isLoggedIn async {
    return _sharedPreference.getBool(Preferences.is_logged_in) ?? false;
  }

  Future<bool> saveIsLoggedIn(bool value) async {
    return _sharedPreference.setBool(Preferences.is_logged_in, value);
  }

  // Theme:------------------------------------------------------
  bool get isDarkMode {
    return _sharedPreference.getBool(Preferences.is_dark_mode) ?? false;
  }

  Future<void> changeBrightnessToDark(bool value) {
    return _sharedPreference.setBool(Preferences.is_dark_mode, value);
  }

  // Language:---------------------------------------------------
  String? get currentLanguage {
    return _sharedPreference.getString(Preferences.current_language);
  }

  Future<void> changeLanguage(String language) {
    return _sharedPreference.setString(Preferences.current_language, language);
  }

}
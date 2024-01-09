import 'dart:async';
import 'dart:convert';

import 'package:erp/models/general/general_model.dart';
import 'package:erp/models/user_management/sign_in_dashboard_response.dart';
import 'package:erp/models/user_management/signup_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/network/apis/user_management/user_management_api.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';
import 'package:erp/models/user_management/external_sign_in_response.dart';
import 'package:erp/models/user_management/forget_password_response.dart';
import 'package:erp/models/user_management/reset_password_response.dart';
import 'package:erp/models/user_management/sign_in_response.dart';
import 'package:erp/models/user_management/sign_up_complete_account_response.dart';
import 'package:erp/models/user_management/sign_up_confirmation_account_response.dart';
import 'package:erp/models/user_management/sign_up_enter_email_response.dart';
import 'package:http/http.dart' as http;
import '../../models/cart/products_cart.dart';
import '../../utils/device/app_uitls.dart';
import '../network/dio_client.dart';

class UserManagementRepository {
  // api objects
  final UserManagementApi _managementApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  UserManagementRepository(
    this._managementApi,
    this._sharedPrefsHelper,
  );

  /// SignUp EndPoints: ---------------------------------------------------------------------

  Future<SignInResultResponse> signUpComplete(
      {required Map<String, dynamic> data,
      required CancelToken cancelToken}) async {
    var _user = await _managementApi.signUpComplete(
        cancelToken: cancelToken, data: data);

    if (_user.token != null) {
      await _sharedPrefsHelper.saveAuthToken(_user.token!);
      await _sharedPrefsHelper.saveUserInfo(
          _user.info!.name + "," + _user.info!.phone + "," + _user.info!.email);
    }

    return _user;
  }

  /// SignIn EndPoint: ---------------------------------------------------------------------
  Future<SignInResultResponse> authenticates(
      {required Map<String, dynamic> data,
      required CancelToken cancelToken}) async {
    var _user = await _managementApi.authenticates(
        data: data, cancelToken: cancelToken);
    if (_user.token != null) {
      await _sharedPrefsHelper.saveAuthToken(_user.token!);
      await _sharedPrefsHelper.saveUserInfo(
          _user.info!.name + "," + _user.info!.phone + "," + _user.info!.email);
    }

    // await getDashboard(cancelToken: cancelToken);
/*
    if (_user.result) {
      await _managementDataSource.updateOrInsert(_user.user!);
    }*/
    return _user;
  }

  Future<void> saveAddress(String address) async {
    await _sharedPrefsHelper.saveAddress(address);
  }

  Future<void> saveDeviceToken(String deviceToken) async {
    await _sharedPrefsHelper.saveDeviceToken(deviceToken);
  }

  Future<void> saveTime(String time) async {
    await _sharedPrefsHelper.saveTime(time);
  }

  Future<void> saveTimeId(String timeId) async {
    await _sharedPrefsHelper.saveTimeId(timeId);
  }

  Future<void> saveAddressId(String addressId) async {
    await _sharedPrefsHelper.saveAddressId(addressId);
  }

  Future<void> saveNumCart(int numCart) async {
    await _sharedPrefsHelper.saveNumCart(numCart);
  }

  Future<void> saveCart(List<Products> cart) async {
    await _sharedPrefsHelper.saveCart(cart);
  }

  Future<String?> get authToken async {
    return _sharedPrefsHelper.authToken;
  }

  Future<String?> get deviceToken async {
    return _sharedPrefsHelper.deviceToken;
  }

  Future<String?> get userInfo async {
    return _sharedPrefsHelper.userInfo;
  }

  Future<String?> get address async {
    return _sharedPrefsHelper.address;
  }

  Future<String?> get addressId async {
    return _sharedPrefsHelper.addressId;
  }

  Future<String?> get time async {
    return _sharedPrefsHelper.time;
  }

  Future<String?> get timeId async {
    return _sharedPrefsHelper.timeId;
  }

  Future<List<Products>> get cart async {
    String? cart_ = await _sharedPrefsHelper.cart;
    return cart_ != null ? Products.decode(cart_) : [];
  }

  Future<int?> get numCart async {
    return _sharedPrefsHelper.numCart;
  }

  /// ForgetPassword EndPoint: ---------------------------------------------------------------------
  Future<GeneralModel> forgetPassword(
      {required email, required CancelToken cancelToken}) async {
    var _user = await _managementApi.forgetPassword(
        email: email, cancelToken: cancelToken);
    return _user;
  }

  Future<bool> signOut() async {
    bool isRemovedToken = await _sharedPrefsHelper.removeAuthToken();
    if (isRemovedToken) {
      await _sharedPrefsHelper.removeAddress();
      await _sharedPrefsHelper.removeAddressId();
      await _sharedPrefsHelper.removeCart();
      await _sharedPrefsHelper.removeUserInfo();
      await _sharedPrefsHelper.removeNumCart();
      await _sharedPrefsHelper.removeTime();
      await _sharedPrefsHelper.removeTimeId();
      return true;
    }
    return false;
  }

  Future<bool> deleteAccount() async {
// final Dio _dio;
//     final response = _dio.get(
//       'https://tas-jeel.com/api/user/deleteUserAndRelatedData',
//       // cancelToken: cancelToken,
//     );
    var token = await _sharedPrefsHelper.authToken;
    print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $token");

    final response = await http.get(
        Uri.parse(
          'https://tas-jeel.com/api/user/deleteUserAndRelatedData',
        ),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
          'Authorization': "Bearer $token"
        }); //{'authorization': '$token'}Bearer Token
    bool isRemovedToken = await _sharedPrefsHelper.removeAuthToken();

    print(response);
    if (isRemovedToken) {
      await _sharedPrefsHelper.removeAddress();
      await _sharedPrefsHelper.removeAddressId();
      await _sharedPrefsHelper.removeCart();
      await _sharedPrefsHelper.removeUserInfo();
      await _sharedPrefsHelper.removeNumCart();
      await _sharedPrefsHelper.removeTime();
      await _sharedPrefsHelper.removeTimeId();
      return true;
    }
    return false;
  }

  Future<bool> clearCart() async {
    await _sharedPrefsHelper.removeCart();
    await _sharedPrefsHelper.removeNumCart();
    return true;
  }
}

import 'dart:async';

import 'package:erp/models/user_management/sign_in_dashboard_response.dart';
import 'package:erp/models/user_management/signup_model.dart';
import 'package:dio/dio.dart';
import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/models/user_management/external_sign_in_response.dart';
import 'package:erp/models/user_management/forget_password_response.dart';
import 'package:erp/models/user_management/reset_password_response.dart';
import 'package:erp/models/user_management/sign_in_response.dart';
import 'package:erp/models/user_management/sign_up_complete_account_response.dart';
import 'package:erp/models/user_management/sign_up_confirmation_account_response.dart';
import 'package:erp/models/user_management/sign_up_enter_email_response.dart';
import 'package:path/path.dart' as p;

import '../../../../models/general/general_model.dart';
class UserManagementApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  UserManagementApi(this._dioClient);

  /// signUp endpoints
  Future<SignInResultResponse> signUpComplete(
      {
        required Map<String, dynamic> data,
        required CancelToken cancelToken
      }) async {
    try {
      final res = await _dioClient.post(Endpoints.SignUpComplete,data: data,
         cancelToken: cancelToken,

        //  options: Options(contentType: Headers.formUrlEncodedContentType)
      );
      return SignInResultResponse.fromJson(res);
    }on DioError catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// signIn endpoints
  Future<SignInResultResponse> authenticates(
      {required Map<String, dynamic> data,required CancelToken cancelToken}) async {
    try {
      final res = await _dioClient.post(Endpoints.Authenticates, data: data,cancelToken: cancelToken);
      print('ffffffffffffffffffffffffffff88 $res');
      return SignInResultResponse.fromJson(res);

    } on DioError catch (e) {
      print("errorr authhhhhhh${e.response!.data}"+e.toString());
      throw e;
    }
  }

  Future<GeneralModel> forgetPassword(
      {required email,required CancelToken cancelToken}) async {
    try {
      final res = await _dioClient.get(Endpoints.forgetPassword, queryParameters: {'email':email},cancelToken: cancelToken);
      return GeneralModel.fromJson(res);
    } on DioError catch (e) {
      print(e.toString());
      throw e;
    }
  }


}

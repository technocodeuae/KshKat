import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:erp/data/repo/user_management_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/profile/city_profile_model.dart';
import 'package:erp/utils/dio/dio_error_util.dart';
import 'package:erp/utils/dio/errors/base_error.dart';

import '../../../../models/user_management/sign_in_response.dart';
import '../../../../state/general_state.dart';


class SignUpSuccess extends GeneralState {
  final SignInResultResponse result;

  SignUpSuccess({required this.result});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'SignUpCompleteAccountSuccess data : ${result.toJson()}';
}
class CityProfileSuccess extends GeneralState {
  final CityProfileData result;

  CityProfileSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'ProfileDataSuccess data :${result.toJson()}';
}

class SignUpFailure extends GeneralState {
  final BaseError error;
  final VoidCallback? callback;

  SignUpFailure({
    required this.error,
    this.callback,
  });

  @override
  List<Object> get props => [error, callback!];

  @override
  String toString() => 'SignUpCompleteAccountFailure { error: $error }';
}

class SignUpController extends GetxController {

  late SignUpSuccess signUpSuccess;
  late SignUpFailure signUpFailure;

  Future<void> signUp(CancelToken cancelToken, String userName,String email,String password,String mobile) async {

    UserManagementRepository _repository = getIt<UserManagementRepository>();

    GeneralState.loading();

    try {
      final future = await _repository.signUpComplete(
          cancelToken: cancelToken,
          data:{
            'name': userName,
            'email': email,
            'password': password,
            'phone': mobile.toString().replaceAll(" ", ""),
          }
      );
      GeneralState.success();
      await unRegisterLocator();
      await setupLocator();
      signUpSuccess= SignUpSuccess(result: future);
      update();
    }  catch (err) {
      print('Caught error: $err');
      GeneralState.failure();
      signUpFailure= SignUpFailure(
          error: DioErrorUtil.handleError(err)
      );
      update();
    }
  }

}

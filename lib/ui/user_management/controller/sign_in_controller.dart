import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:erp/data/repo/user_management_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/general/general_model.dart';
import 'package:erp/state/general_state.dart';

import '../../../../models/user_management/sign_in_response.dart';
import '../../../../utils/dio/dio_error_util.dart';
import '../../../../utils/dio/errors/base_error.dart';
import '../../../utils/dio/errors/unauthorized_error.dart';

class SignInSuccess extends GeneralState {
  final SignInResultResponse result;

  SignInSuccess({required this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'SignInSuccess data :${result.toJson()}';
}

class ForgetSuccess extends GeneralState {
  final GeneralModel result;

  ForgetSuccess({required this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'ForgetSuccess data :${result.toJson()}';
}

class SignInFailure extends GeneralState {
  final BaseError error;

  SignInFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SignInFailure { error: $error }';
}

class SignInController extends GetxController {
  late SignInSuccess signInSuccess =
      SignInSuccess(result: SignInResultResponse());
  late SignInFailure signInFailure;
  late ForgetSuccess forgetSuccess = ForgetSuccess(result: GeneralModel());

  Future<void> signIn(
      CancelToken cancelToken, String userName, String password) async {
    UserManagementRepository _repository = getIt<UserManagementRepository>();

    GeneralState.loading();

    try {
      final future = await _repository.authenticates(
          cancelToken: cancelToken,
          data: {'phone': userName, 'password': password});
      GeneralState.success();
      await unRegisterLocator();
      await setupLocator();
      signInSuccess = SignInSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      GeneralState.failure();
      signInFailure = SignInFailure(error: DioErrorUtil.handleError(err));
      update();
    }
  }

  Future<void> forgetPassword(CancelToken cancelToken, String email) async {
    UserManagementRepository _repository = getIt<UserManagementRepository>();

    GeneralState.loading();

    try {
      final future = await _repository.forgetPassword(
          cancelToken: cancelToken, email: email);
      GeneralState.success();
      await unRegisterLocator();
      await setupLocator();
      forgetSuccess = ForgetSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      GeneralState.failure();
      signInFailure = SignInFailure(error: DioErrorUtil.handleError(err));
      update();
    }
  }
}

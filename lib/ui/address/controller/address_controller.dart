import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:erp/data/repo/address_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/address/address_model.dart';
import 'package:erp/utils/dio/dio_error_util.dart';
import 'package:erp/utils/dio/errors/base_error.dart';

import '../../../state/general_state.dart';
import '../../../utils/dio/errors/cancel_error.dart';
import '../../../utils/dio/errors/connection_error.dart';

class AddressSuccess extends GeneralState {
  final AddressModel result;

  AddressSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'AddressDataSuccess data :${result.toJson()}';
}

class AddressFailure extends GeneralState {
  final BaseError error;

  AddressFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'AddressFailure { error: $error }';
}

class AddressController extends GetxController {
  late AddressSuccess addressSuccess;
  late AddressFailure addressFailure;

  Future<void> getAddress(CancelToken cancelToken) async {
    AddressRepository _repository = getIt<AddressRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getAddress(cancelToken: cancelToken);

      GeneralState.success();
      addressSuccess = AddressSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      addressFailure = AddressFailure(error: DioErrorUtil.handleError(err));
      if (addressFailure.error != CancelError() &&
          addressFailure.error != DioErrorType.cancel &&
          addressFailure.error != ConnectionError() &&
          addressFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();

      update();
    }
  }
}

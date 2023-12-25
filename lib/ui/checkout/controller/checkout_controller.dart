import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:erp/data/repo/checkout_repository.dart';
import 'package:erp/data/repo/user_management_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/general/general_model.dart';
import 'package:erp/state/general_state.dart';

import '../../../../models/user_management/sign_in_response.dart';
import '../../../../utils/dio/dio_error_util.dart';
import '../../../../utils/dio/errors/base_error.dart';
import '../../../models/cart/cart_validate_model.dart';
import '../../../utils/dio/errors/cancel_error.dart';
import '../../../utils/dio/errors/connection_error.dart';

class CheckoutSuccess extends GeneralState {
  final GeneralModel result;

  CheckoutSuccess({required this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'CheckoutSuccess data :${result.toJson()}';
}

class CheckoutFailure extends GeneralState {
  final BaseError error;

  CheckoutFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CheckoutFailure { error: $error }';
}

class CheckoutController extends GetxController {
  late CheckoutSuccess checkoutSuccess;
  late CheckoutFailure checkoutFailure;
  Map? copuonResult;
  bool isLoading = false;

  void emptyCopuon() {
    copuonResult = null;
    update();
  }

  Future<void> checkout(
    CancelToken cancelToken,
    List<Items> items,
    int address_id,
    String lang,
    String paymentMethod,
    String copuon,
    // int cartId,
  ) async {
    CheckoutRepository _repository = getIt<CheckoutRepository>();
    GeneralState.loading();

    try {
      final future =
          await _repository.checkout(cancelToken: cancelToken, data: {
        'method_id': 1,
        'payment_method': paymentMethod,
        // 'cart_id':cartId,
        'coupon_code': copuon,
        'currency_id': 2,
        'address_id': address_id,
        'lang': lang,
        'items': items
      });
      GeneralState.success();
      await unRegisterLocator();
      await setupLocator();
      checkoutSuccess = CheckoutSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      checkoutFailure = CheckoutFailure(error: DioErrorUtil.handleError(err));
      if (checkoutFailure.error != CancelError() &&
          checkoutFailure.error != DioErrorType.cancel &&
          checkoutFailure.error != ConnectionError() &&
          checkoutFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();
      update();
    }
  }

  Future<void> checkCopuon(
      CancelToken cancelToken, String code, String lang) async {
    CheckoutRepository _repository = getIt<CheckoutRepository>();

    isLoading = true;
    update();

    try {
      final future = await _repository.checkCopuon(
          cancelToken: cancelToken, data: {'lang': lang, 'coupon_code': code});
      copuonResult = future;
      isLoading = false;
      update();
    } catch (err) {
      print('Caught error: $err');
      copuonResult = {'message': 'there is no exist copuon'};
      isLoading = false;
      update();
    }
  }
}

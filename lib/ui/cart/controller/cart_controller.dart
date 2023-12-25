import 'package:dio/dio.dart';
import 'package:erp/models/cart/cart_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/utils/dio/dio_error_util.dart';
import 'package:erp/utils/dio/errors/base_error.dart';

import '../../../data/repo/cart_repository.dart';
import '../../../models/cart/cart_result_validate.dart';
import '../../../models/cart/cart_save_model.dart';
import '../../../models/cart/cart_validate_model.dart';
import '../../../models/pickup/pickup_time_request.dart';
import '../../../models/pickup/pickup_validate_model.dart';
import '../../../state/general_state.dart';
import '../../../utils/dio/errors/cancel_error.dart';
import '../../../utils/dio/errors/connection_error.dart';

class CartSuccess extends GeneralState {
  final CartResultValidate result;

  CartSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'CartDataSuccess data :${result.toJson()}';
}

class CartTimeSuccess extends GeneralState {
  final PickupValidateData result;

  CartTimeSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'CartDataSuccess data :${result.toJson()}';
}

class CartAllSuccess extends GeneralState {
  final CartModel result;

  CartAllSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'CartDataSuccess data :${result.toJson()}';
}

class CartClearSuccess extends GeneralState {
  final CartSaveModel result;

  CartClearSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'CartClearSuccess data :${result.toJson()}';
}

class CartFailure extends GeneralState {
  final BaseError error;

  CartFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CartFailure { error: $error }';
}

class CartTimeFailure extends GeneralState {
  final BaseError error;

  CartTimeFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CartFailure { error: $error }';
}

class CartController extends GetxController {
  late CartSuccess cartSuccess;
  late CartTimeSuccess cartTimeSuccess;
  late CartAllSuccess cartAllSuccess;
  late CartClearSuccess cartClearSuccess;
  late CartFailure productFailure;
  late CartTimeFailure cartTimeFailure;
  int addedPrice = 0;

  void changePrice(int price) {
    addedPrice = price;
    update();
  }

  Future<void> validateCart(
      CancelToken cancelToken, CartValidateData data) async {
    CartRepository _repository = getIt<CartRepository>();
    GeneralState.loading();

    try {
      final future =
          await _repository.validateCart(cancelToken: cancelToken, data: data);

      GeneralState.success();
      cartSuccess = CartSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      productFailure = CartFailure(error: DioErrorUtil.handleError(err));
      if (productFailure.error != CancelError() &&
          productFailure.error != DioErrorType.cancel &&
          productFailure.error != ConnectionError() &&
          productFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();

      update();
    }
  }

  Future<void> validateTime(
      CancelToken cancelToken, PickUpTimeRequestData deliverySlotId) async {
    CartRepository _repository = getIt<CartRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.validateTime(
          cancelToken: cancelToken, data: deliverySlotId);

      GeneralState.success();
      cartTimeSuccess = CartTimeSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      productFailure = CartFailure(error: DioErrorUtil.handleError(err));

      if (productFailure.error != CancelError() &&
          productFailure.error != DioErrorType.cancel &&
          productFailure.error != ConnectionError() &&
          productFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();
      update();
    }
  }

  Future<void> getCart(
      CancelToken cancelToken, int limit, int page, String lang) async {
    CartRepository _repository = getIt<CartRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getCart(
          cancelToken: cancelToken, limit: limit, page: page, lang: lang);

      GeneralState.success();
      cartAllSuccess = CartAllSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      productFailure = CartFailure(error: DioErrorUtil.handleError(err));

      if (productFailure.error != CancelError() &&
          productFailure.error != DioErrorType.cancel &&
          productFailure.error != ConnectionError() &&
          productFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();
      update();
    }
  }

  Future<void> clearCart(CancelToken cancelToken, int? id, String lang) async {
    CartRepository _repository = getIt<CartRepository>();
    GeneralState.loading();

    try {
      final future =
          await _repository.clearCart(cancelToken: cancelToken, id: id);
      getCart(cancelToken, 0, 0, lang);

      /*GeneralState.success();
      cartClearSuccess= CartClearSuccess(result: future);
      update();*/
    } catch (err) {
      print('Caught error: $err');
      productFailure = CartFailure(error: DioErrorUtil.handleError(err));
      if (productFailure.error != CancelError() &&
          productFailure.error != DioErrorType.cancel &&
          productFailure.error != ConnectionError() &&
          productFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();
      update();
    }
  }

  Future<void> addMinusProduct(CancelToken cancelToken, int cart_id,
      int product_id, String operation, String lang) async {
    CartRepository _repository = getIt<CartRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.addMinusProduct(
        cancelToken: cancelToken,
        product_id: product_id,
        operation: operation,
        cart_id: cart_id,
      );
      getCart(cancelToken, 0, 0, lang);

      /*GeneralState.success();
      cartClearSuccess= CartClearSuccess(result: future);
      update();*/
    } catch (err) {
      print('Caught error: $err');
      productFailure = CartFailure(error: DioErrorUtil.handleError(err));
      if (productFailure.error != CancelError() &&
          productFailure.error != DioErrorType.cancel &&
          productFailure.error != ConnectionError() &&
          productFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();
      update();
    }
  }
}

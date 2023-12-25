import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:erp/data/repo/order_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/general/general_model.dart';
import 'package:erp/models/order/order_model.dart';
import 'package:erp/utils/dio/dio_error_util.dart';
import 'package:erp/utils/dio/errors/base_error.dart';

import '../../../state/general_state.dart';


class OrderSuccess extends GeneralState {
  final OrderModel result;

  OrderSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'OrderDataSuccess data :${result.toJson()}';
}

class OrderFailure extends GeneralState {
  final BaseError error;

  OrderFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'OrderFailure { error: $error }';
}

class OrderController extends GetxController {

  late OrderSuccess orderSuccess;
  late OrderFailure orderFailure;

  Future<void> getOrder(CancelToken cancelToken, int limit,int page,String lang) async {

    OrderRepository _repository = getIt<OrderRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getOrder(cancelToken: cancelToken,limit: limit,page: page,lang:lang);

      GeneralState.success();
      orderSuccess= OrderSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      GeneralState.failure();
      orderFailure= OrderFailure(
          error: DioErrorUtil.handleError(err)
      );
      update();
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:erp/data/repo/order_details_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/general/general_model.dart';
import 'package:erp/models/order/order_details_model.dart';
import 'package:erp/utils/dio/dio_error_util.dart';
import 'package:erp/utils/dio/errors/base_error.dart';

import '../../../../state/general_state.dart';


class OrderDetailsSuccess extends GeneralState {
  final OrderDetailsModel result;

  OrderDetailsSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'OrderDetailsDataSuccess data :${result.toJson()}';
}

class OrderDetailsFailure extends GeneralState {
  final BaseError error;

  OrderDetailsFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'OrderDetailsFailure { error: $error }';
}

class OrderDetailsController extends GetxController {

  late OrderDetailsSuccess orderSuccess;
  late OrderDetailsFailure orderFailure;

  Future<void> getOrderDetails(CancelToken cancelToken,int id, String lang) async {

    OrderDetailRepository _repository = getIt<OrderDetailRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getOrderDetail(cancelToken: cancelToken,lang: lang,id: id);

      GeneralState.success();
      orderSuccess= OrderDetailsSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      GeneralState.failure();
      orderFailure= OrderDetailsFailure(
          error: DioErrorUtil.handleError(err)
      );
      update();
    }
  }
}
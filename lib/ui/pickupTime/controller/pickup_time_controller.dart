import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:erp/data/repo/pickup_time_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/general/general_model.dart';
import 'package:erp/models/pickup/pickup_time_model.dart';
import 'package:erp/utils/dio/dio_error_util.dart';
import 'package:erp/utils/dio/errors/base_error.dart';

import '../../../state/general_state.dart';



class PickupTimeSuccess extends GeneralState {
  final PickupTimeModel result;

  PickupTimeSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'PickupTimeDataSuccess data :${result.toJson()}';
}

class PickupTimeFailure extends GeneralState {
  final BaseError error;

  PickupTimeFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PickupTimeFailure { error: $error }';
}

class PickupTimeController extends GetxController {

  late PickupTimeSuccess pickupSuccess;
  late PickupTimeFailure pickupFailure;

  Future<void> getPickupTime(CancelToken cancelToken) async {

    PickUpTimeRepository _repository = getIt<PickUpTimeRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getPickUpTime(cancelToken: cancelToken);

      GeneralState.success();
      pickupSuccess= PickupTimeSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      GeneralState.failure();
      pickupFailure= PickupTimeFailure(
          error: DioErrorUtil.handleError(err)
      );
      update();
    }
  }
}

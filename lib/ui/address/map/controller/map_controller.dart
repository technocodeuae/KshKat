import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:erp/data/repo/map_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/general/general_model.dart';
import 'package:erp/models/address/map_model.dart';
import 'package:erp/utils/dio/dio_error_util.dart';
import 'package:erp/utils/dio/errors/base_error.dart';

import '../../../../state/general_state.dart';


class MapSuccess extends GeneralState {
  final MapData result;

  MapSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'MapDataSuccess data :${result.toJson()}';
}

class MapFailure extends GeneralState {
  final BaseError error;

  MapFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'MapFailure { error: $error }';
}

class MapController extends GetxController {

  late MapSuccess mapSuccess;
  late MapFailure mapFailure;

  Future<void> saveAddress(CancelToken cancelToken,Map<String, dynamic> data) async {

    MapRepository _repository = getIt<MapRepository>();

    GeneralState.loading();

    try {
      final future = await _repository.saveAddress(cancelToken: cancelToken,data: data);

      GeneralState.success();
      mapSuccess= MapSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      GeneralState.failure();
      mapFailure= MapFailure(
          error: DioErrorUtil.handleError(err)
      );
      update();
    }
  }

}

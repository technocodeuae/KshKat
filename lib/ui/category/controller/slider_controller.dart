import 'package:dio/dio.dart';
import 'package:erp/data/repo/slider_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/utils/dio/dio_error_util.dart';
import 'package:erp/utils/dio/errors/base_error.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../models/home/slider_model.dart';
import '../../../state/general_state.dart';

class SliderSuccess extends GeneralState {
  final SliderListData result;

  SliderSuccess({required this.result});

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'SliderDataSuccess data :${result.toJson()}';
}

class SliderFailure extends GeneralState {
  final BaseError error;

  SliderFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SliderFailure { error: $error }';
}

class SliderController extends GetxController {
  SliderSuccess? sliderSuccess;

  SliderFailure? signInFailure;

  Future<void> getSlider(CancelToken cancelToken, String lang) async {
    SliderRepository _repository = getIt<SliderRepository>();
    GeneralState.loading();

    try {
      final future =
          await _repository.getSlider(cancelToken: cancelToken, lang: lang);

      GeneralState.success();
      sliderSuccess = SliderSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      GeneralState.failure();
      signInFailure = SliderFailure(error: DioErrorUtil.handleError(err));
      update();
    }
  }
}

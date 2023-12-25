import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:erp/data/repo/products_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/general/general_model.dart';
import 'package:erp/models/home/products_model.dart';
import 'package:erp/utils/dio/dio_error_util.dart';
import 'package:erp/utils/dio/errors/base_error.dart';

import '../../../models/home/fav_model.dart';
import '../../../models/home/products_fav_model.dart';
import '../../../state/general_state.dart';
import '../../../utils/dio/errors/cancel_error.dart';
import '../../../utils/dio/errors/connection_error.dart';

class ProductsSuccess extends GeneralState {
  final ProductsModel result;

  ProductsSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'ProductsDataSuccess data :${result.toJson()}';
}

class ProductsFavSuccess extends GeneralState {
  final DataProducts result;

  ProductsFavSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'ProductsDataSuccess data :${result.toJson()}';
}

class ProductsAddFavSuccess extends GeneralState {
  final FavModel result;

  ProductsAddFavSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'ProductsDataSuccess data :${result.toJson()}';
}

class ProductsFailure extends GeneralState {
  final BaseError error;

  ProductsFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ProductsFailure { error: $error }';
}

class ProductsController extends GetxController {
  late ProductsSuccess productSuccess;
  late ProductsFavSuccess productFavSuccess;
  late ProductsFavSuccess productSearchSuccess;
  late ProductsAddFavSuccess productAddFavSuccess;
  late ProductsFailure productFailure;

  Future<void> getProducts(
      CancelToken cancelToken, int limit, int page, String lang) async {
    ProductsRepository _repository = getIt<ProductsRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getProducts(
          cancelToken: cancelToken, limit: limit, page: page, lang: lang);

      GeneralState.success();
      productSuccess = ProductsSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      productFailure = ProductsFailure(error: DioErrorUtil.handleError(err));
      if (productFailure.error != CancelError() &&
          productFailure.error != DioErrorType.cancel &&
          productFailure.error != ConnectionError() &&
          productFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();

      update();
    }
  }

  Future<void> getProductsFav(CancelToken cancelToken, int limit, int page,
      String lang, bool isFav) async {
    ProductsRepository _repository = getIt<ProductsRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getProductsFav(
          cancelToken: cancelToken,
          limit: limit,
          page: page,
          lang: lang,
          isFav: isFav);

      GeneralState.success();
      productFavSuccess = ProductsFavSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      productFailure = ProductsFailure(error: DioErrorUtil.handleError(err));
      if (productFailure.error != CancelError() &&
          productFailure.error != DioErrorType.cancel &&
          productFailure.error != ConnectionError() &&
          productFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();

      update();
    }
  }

  void emptySearchList() {
    productSearchSuccess.result.product_data = null;
    update();
  }

  Future<void> searchProducts(CancelToken cancelToken, int limit, int page,
      String lang, String search) async {
    ProductsRepository _repository = getIt<ProductsRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.searchProducts(
          cancelToken: cancelToken,
          limit: limit,
          page: page,
          lang: lang,
          search: search);

      GeneralState.success();
      productSearchSuccess = ProductsFavSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      productFailure = ProductsFailure(error: DioErrorUtil.handleError(err));
      if (productFailure.error != CancelError() &&
          productFailure.error != DioErrorType.cancel &&
          productFailure.error != ConnectionError() &&
          productFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();

      update();
    }
  }

  Future<void> addFav(CancelToken cancelToken, int id) async {
    ProductsRepository _repository = getIt<ProductsRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.addFav(cancelToken: cancelToken, id: id);

      GeneralState.success();
      productAddFavSuccess = ProductsAddFavSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      productFailure = ProductsFailure(error: DioErrorUtil.handleError(err));
      if (productFailure.error != CancelError() &&
          productFailure.error != DioErrorType.cancel &&
          productFailure.error != ConnectionError() &&
          productFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();

      update();
    }
  }

  Future<void> deleteFav(CancelToken cancelToken, int id) async {
    ProductsRepository _repository = getIt<ProductsRepository>();
    GeneralState.loading();

    try {
      final future =
          await _repository.deleteFav(cancelToken: cancelToken, id: id);

      GeneralState.success();
      productAddFavSuccess = ProductsAddFavSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      productFailure = ProductsFailure(error: DioErrorUtil.handleError(err));
      if (productFailure.error != CancelError() &&
          productFailure.error != DioErrorType.cancel &&
          productFailure.error != ConnectionError() &&
          productFailure.error != DioErrorType.connectTimeout)
        GeneralState.failure();

      update();
    }
  }
}

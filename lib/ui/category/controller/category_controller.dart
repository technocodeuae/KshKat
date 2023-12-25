import 'package:dio/dio.dart';
import 'package:erp/utils/dio/errors/cancel_error.dart';
import 'package:erp/utils/dio/errors/connection_error.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:erp/data/repo/category_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/models/home/category_model.dart';
import 'package:erp/utils/dio/dio_error_util.dart';
import 'package:erp/utils/dio/errors/base_error.dart';

import '../../../state/general_state.dart';

class CategorySuccess extends GeneralState {
  final CategoriesListData result;

  CategorySuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'CategoryDataSuccess data :${result.toJson()}';
}

class SubCategorySuccess extends GeneralState {
  final SubCategoryModel result;

  SubCategorySuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'SubDataSuccess data :${result.toJson()}';
}

class SubCategoryProductsSuccess extends GeneralState {
  final LatestProductListData result;

  SubCategoryProductsSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'SubCategoryProductsSuccess data :${result.toJson()}';
}

class TopProductSuccess extends GeneralState {
  final LatestProductListData result;

  TopProductSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'TopProductSuccess data :${result.toJson()}';
}

class LatestProductSuccess extends GeneralState {
  final LatestProductListData result;

  LatestProductSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'LatestProductSuccess data :${result.toJson()}';
}

class FlashDealSuccess extends GeneralState {
  final LatestProductListData result;

  FlashDealSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'FlashDealSuccess data :${result.toJson()}';
}

class CategoryFailure extends GeneralState {
  final BaseError error;

  CategoryFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CategoryFailure { error: $error }';
}

class CategoryController extends GetxController {
  CategorySuccess? categorySuccess;
  SubCategorySuccess? subCategorySuccess;
  SubCategoryProductsSuccess? subCategoryProductsSuccess;
  LatestProductSuccess? latestProductSuccess;
  TopProductSuccess? topProductSuccess;
  TopProductSuccess? bestSellerSuccess;
  TopProductSuccess? popularProductSuccess;
  List<ChildsCategory> selectedSubChildsList = [];
  bool parentCategoryChanged = true;

  FlashDealSuccess? flashDealSuccess;
  CategoryFailure? signInFailure;
  int? categoryIndex;
  // bool isCategoryLoading = false;

  void changeParentCategory(bool v) {
    GeneralState.loading();
    parentCategoryChanged = v;
    GeneralState.success();
    update();
  }

  void changeChildList(List<ChildsCategory> data) {
    selectedSubChildsList = data;
    update();
  }

  Future<void> getCategory(
      CancelToken cancelToken, int limit, int page, String lang) async {
    CategoryRepository _repository = getIt<CategoryRepository>();
    // GeneralState.loading();
    // isCategoryLoading = true;
    update();

    try {
      final future = await _repository.getCategory(
          cancelToken: cancelToken, limit: limit, page: page, lang: lang);

      GeneralState.success();
      categorySuccess = CategorySuccess(result: future);
      // isCategoryLoading = false;
      update();
    } catch (err) {
      signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      print(
          'Caught error: ${signInFailure!.error} ${signInFailure!.error != CancelError() && signInFailure!.error != DioErrorType.cancel}');
      if (signInFailure!.error != CancelError() &&
          signInFailure!.error != DioErrorType.cancel) GeneralState.failure();
      // print('Caught error: $err');
      // GeneralState.failure();
      // signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      // isCategoryLoading = false;

      update();
    }
  }

  Future<void> getSubCategory(
      CancelToken cancelToken, int cat_id, int page, String lang) async {
    CategoryRepository _repository = getIt<CategoryRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getSubCategory(
          cancelToken: cancelToken, cat_id: cat_id, page: page, lang: lang);

      GeneralState.success();
      subCategorySuccess = SubCategorySuccess(result: future);
      update();
    } catch (err) {
      signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      print(
          'Caught error: ${signInFailure!.error} ${signInFailure!.error != CancelError() && signInFailure!.error != DioErrorType.cancel}');
      if (signInFailure!.error != CancelError() &&
          signInFailure!.error != DioErrorType.cancel) GeneralState.failure();

      update();
    }
  }

  Future<void> getSubCategoryProducts(
      CancelToken cancelToken, int cat, int subCat, int page, String lang,
      {required int? childCat}) async {
    CategoryRepository _repository = getIt<CategoryRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getSubCategoryProducts(
          cancelToken: cancelToken,
          cat: cat,
          subCat: subCat,
          page: page,
          lang: lang,
          childCat: childCat);

      GeneralState.success();
      subCategoryProductsSuccess = SubCategoryProductsSuccess(result: future);
      update();
    } catch (err) {
      signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      print(
          'Caught error: ${signInFailure!.error} ${signInFailure!.error != CancelError() && signInFailure!.error != DioErrorType.cancel}');
      if (signInFailure!.error != CancelError() &&
          signInFailure!.error != DioErrorType.cancel &&
          signInFailure!.error != ConnectionError() &&
          signInFailure!.error != DioErrorType.connectTimeout)
        GeneralState.failure();
      // print('Caught error: $err');
      // GeneralState.failure();
      // signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      update();
    }
  }

  Future<void> getTopProduct(
      CancelToken cancelToken, int limit, int page, String lang) async {
    CategoryRepository _repository = getIt<CategoryRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getTopProduct(
          cancelToken: cancelToken, limit: limit, page: page, lang: lang);

      GeneralState.success();
      topProductSuccess = TopProductSuccess(result: future);
      update();
    } catch (err) {
      signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      print(
          'Caught error: ${signInFailure!.error} ${signInFailure!.error != CancelError() && signInFailure!.error != DioErrorType.cancel}');
      if (signInFailure!.error != CancelError() &&
          signInFailure!.error != DioErrorType.cancel &&
          signInFailure!.error != ConnectionError() &&
          signInFailure!.error != DioErrorType.connectTimeout)
        GeneralState.failure();
      // print('Caught error: $err');
      // GeneralState.failure();
      // signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      update();
    }
  }

  Future<void> getBestSeller(
      CancelToken cancelToken, int limit, int page, String lang) async {
    CategoryRepository _repository = getIt<CategoryRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getBestSeller(
          cancelToken: cancelToken, limit: limit, page: page, lang: lang);

      GeneralState.success();
      bestSellerSuccess = TopProductSuccess(result: future);
      update();
    } catch (err) {
      signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      print(
          'Caught error: ${signInFailure!.error} ${signInFailure!.error != CancelError() && signInFailure!.error != DioErrorType.cancel}');
      if (signInFailure!.error != CancelError() &&
          signInFailure!.error != DioErrorType.cancel &&
          signInFailure!.error != ConnectionError() &&
          signInFailure!.error != DioErrorType.connectTimeout)
        GeneralState.failure();
      // print('Caught error: $err');
      // GeneralState.failure();
      // signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      update();
    }
  }

  Future<void> getPopularProduct(
      CancelToken cancelToken, int limit, int page, String lang) async {
    CategoryRepository _repository = getIt<CategoryRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getPopularProduct(
          cancelToken: cancelToken, limit: limit, page: page, lang: lang);

      GeneralState.success();
      popularProductSuccess = TopProductSuccess(result: future);
      update();
    } catch (err) {
      signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      print(
          'Caught error: ${signInFailure!.error} ${signInFailure!.error != CancelError() && signInFailure!.error != DioErrorType.cancel}');
      if (signInFailure!.error != CancelError() &&
          signInFailure!.error != DioErrorType.cancel &&
          signInFailure!.error != ConnectionError() &&
          signInFailure!.error != DioErrorType.connectTimeout)
        GeneralState.failure();
      // print('Caught error: $err');
      // GeneralState.failure();
      // signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      update();
    }
  }

  Future<void> setSub(int index) async {
    GeneralState.loading();

    GeneralState.success();
    categoryIndex = index;
    update();
  }

  Future<void> getLatestProduct(
      CancelToken cancelToken, int limit, int page, String lang) async {
    CategoryRepository _repository = getIt<CategoryRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getLatestProduct(
          cancelToken: cancelToken, limit: limit, page: page, lang: lang);

      GeneralState.success();
      latestProductSuccess = LatestProductSuccess(result: future);
      update();
    } catch (err) {
      signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      print(
          'Caught error: ${signInFailure!.error} ${signInFailure!.error != CancelError() && signInFailure!.error != DioErrorType.cancel}');
      if (signInFailure!.error != CancelError() &&
          signInFailure!.error != DioErrorType.cancel &&
          signInFailure!.error != ConnectionError() &&
          signInFailure!.error != DioErrorType.connectTimeout)
        GeneralState.failure();
      // print('Caught error: $err');
      // GeneralState.failure();
      // signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      update();
    }
  }

  Future<void> getFlashDeals(
      CancelToken cancelToken, int limit, int page, String lang) async {
    CategoryRepository _repository = getIt<CategoryRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getFlashDeals(
          cancelToken: cancelToken, limit: limit, page: page, lang: lang);

      GeneralState.success();
      flashDealSuccess = FlashDealSuccess(result: future);
      update();
    } catch (err) {
      signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      print(
          'Caught error: ${signInFailure!.error} ${signInFailure!.error != CancelError() && signInFailure!.error != DioErrorType.cancel}');
      if (signInFailure!.error != CancelError() &&
          signInFailure!.error != DioErrorType.cancel &&
          signInFailure!.error != ConnectionError() &&
          signInFailure!.error != DioErrorType.connectTimeout)
        GeneralState.failure();
      // print('Caught error: $err');
      // GeneralState.failure();
      // signInFailure = CategoryFailure(error: DioErrorUtil.handleError(err));
      update();
    }
  }
}

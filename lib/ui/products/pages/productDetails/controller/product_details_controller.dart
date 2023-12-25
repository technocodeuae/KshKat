import 'package:dio/dio.dart';
import 'package:erp/data/repo/products_repository.dart';
import 'package:erp/di/components/service_locator.dart';
import 'package:erp/ui/cart/controller/cart_controller.dart';
import 'package:erp/utils/dio/dio_error_util.dart';
import 'package:erp/utils/dio/errors/base_error.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../../models/cart/cart_model.dart';
import '../../../../../models/cart/cart_save_model.dart';
import '../../../../../models/home/product_details_model.dart';
import '../../../../../state/general_state.dart';

class ProductsSuccess extends GeneralState {
  final ProductDetailsModel result;

  ProductsSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'ProductsDataSuccess data :${result.toJson()}';
}

class CartSuccess extends GeneralState {
  final CartSaveModel? result;

  CartSuccess({required this.result});
  @override
  List<Object> get props => [result!];

  @override
  String toString() => 'CartModel data :${result!.toJson()}';
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

class ProductDetailsController extends GetxController {
  late ProductsSuccess productSuccess;
  late CartSuccess cartSuccess = new CartSuccess(result: null);
  late ProductsFailure productFailure;
  bool isLoading = false;

  Future<void> getProductDetails(
      CancelToken cancelToken, int id, String lang) async {
    ProductsRepository _repository = getIt<ProductsRepository>();
    GeneralState.loading();

    try {
      final future = await _repository.getProductDetails(
          cancelToken: cancelToken, id: id, lang: lang);

      GeneralState.success();
      productSuccess = ProductsSuccess(result: future);
      update();
    } catch (err) {
      print('Caught error: $err');
      GeneralState.failure();
      productFailure = ProductsFailure(error: DioErrorUtil.handleError(err));
      update();
    }
  }

  Future<void> saveCart(
      CancelToken cancelToken,
      List<Map<String, dynamic>> attributes,
      List<Map<String, dynamic>> defaulAttributes,
      String? addressId,
      String quantity,
      String productId,
      String lang) async {
    ProductsRepository _repository = getIt<ProductsRepository>();
    isLoading = true;
    update();
    GeneralState.loading();

    print("ffffffffffffffuuuuuuuuuuuuuuuuuuuuuu ${attributes}");

    try {
      final future =
          await _repository.saveCart(cancelToken: cancelToken, data: {
        'quantity': quantity,
        'attributes': attributes,
        'address_id': addressId,
        'lang': lang,
        'product_id': productId,
        // "defaulAttributes":defaulAttributes
      },
      defaulAttributes : defaulAttributes,
      );

      GeneralState.success();
      cartSuccess = CartSuccess(result: future);
      isLoading = false;
      update();
    } catch (err) {
      print('Caught error: $err');
      GeneralState.failure();
      productFailure = ProductsFailure(error: DioErrorUtil.handleError(err));
      isLoading = false;
      update();
    }
  }
}

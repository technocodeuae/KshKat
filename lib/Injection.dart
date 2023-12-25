
import 'package:erp/ui/category/controller/slider_controller.dart';
import 'package:erp/ui/products/pages/productDetails/controller/product_details_controller.dart';
import 'package:get/get.dart';
import 'package:erp/ui/address/controller/address_controller.dart';
import 'package:erp/ui/address/map/controller/map_controller.dart';
import 'package:erp/ui/cart/controller/cart_controller.dart';
import 'package:erp/ui/category/controller/category_controller.dart';
import 'package:erp/ui/checkout/controller/checkout_controller.dart';
import 'package:erp/ui/order/controller/order_controller.dart';
import 'package:erp/ui/order/orderDetails/controller/order_details_controller.dart';
import 'package:erp/ui/pickupTime/controller/pickup_time_controller.dart';
import 'package:erp/ui/products/controller/products_controller.dart';
import 'package:erp/ui/user_management/controller/sign_in_controller.dart';
import 'package:erp/ui/user_management/controller/sign_up_controller.dart';


Future initGetX() async {

  //region Auth
  Get.lazyPut<SignInController>(() => SignInController());
  Get.lazyPut<SignUpController>(() => SignUpController());
  //endregion

  //region Category
  Get.lazyPut<CategoryController>(() => CategoryController());
  //endregion

  //region Category
  Get.lazyPut<SliderController>(() => SliderController());
  //endregion

  //region Address
  Get.lazyPut<AddressController>(() => AddressController());
  Get.lazyPut<MapController>(() => MapController());
  //endregion

  //region Checkout
  Get.lazyPut<CheckoutController>(() => CheckoutController());
  //endregion

  //region Order
  Get.lazyPut<OrderController>(() => OrderController());
  Get.lazyPut<OrderDetailsController>(() => OrderDetailsController());
  //endregion

  //region PickUpTime
  Get.lazyPut<PickupTimeController>(() => PickupTimeController());
  //endregion

  //region Products
  Get.lazyPut<ProductsController>(() => ProductsController());
  Get.lazyPut<ProductDetailsController>(() => ProductDetailsController());
  //endregion

  //region Cart
  Get.lazyPut<CartController>(() => CartController());
  //endregion

}

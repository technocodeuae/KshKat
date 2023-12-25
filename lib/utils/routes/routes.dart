import 'package:erp/ui/category/pages/all_best_seller_page.dart';
import 'package:erp/ui/category/pages/all_latest_product_page.dart';
import 'package:erp/ui/category/pages/all_popular_product_page.dart';
import 'package:erp/ui/products/pages/searchProducts/pages/products_search_page.dart';
import 'package:flutter/material.dart';
import 'package:erp/ui/cart/pages/cart_page.dart';
import 'package:erp/ui/checkout/pages/checkout_page.dart';
import 'package:erp/ui/main/main_root.dart';
import 'package:erp/ui/order/orderDetails/pages/order_details_page.dart';
import 'package:erp/ui/order/pages/order_page.dart';
import 'package:erp/ui/profile/pages/my_profile_page.dart';
import 'package:erp/ui/splash/pages/splash.dart';
import 'package:erp/ui/user_management/pages/sign_in_page.dart';
import 'package:erp/ui/user_management/pages/sign_up_page.dart';

import '../../ui/address/map/pages/map_page.dart';
import '../../ui/address/pages/address_page.dart';
import '../../ui/category/pages/all_top_product_page.dart';
import '../../ui/category/pages/categories_page.dart';
import '../../ui/category/pages/sub_category_product_page.dart';
import '../../ui/pickupTime/pages/pickup_time_page.dart';
import '../../ui/products/pages/productDetails/pages/product_details_page.dart';
import '../../ui/products/pages/products_page.dart';
import '../../ui/profile/pages/account_info_page.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';

  /// user management pages
  static const String mainLoginPage = '/login/pages/mainLoginPage';
  static const String signInPage = '/login/pages/SignInPage';
  static const String signUpPage = '/login/pages/SignUpPage';
  static const String addressPage = '/ui/home/widgets/AddressWidget';
  static const String mapPage = '/ui/home/widgets/MapWidget';

  /// main pages
  static const String mainRootPage = '/ui/MainRootPage/';
  static const String paymentPage =
      '/ui/checkout/payment/CustomCardPaymentScreen/';
  static const String home = '/home';
  static const String orderPage = '/ui/order/OrderPage';
  static const String checkoutPage = '/ui/checkout/pages/OtherPage';

  /// Profile Pages
  static const String myProfilePage = '/profile/pages/MyProfilePage';
  static const String accountInformationPage = '/profile/pages/AccountInfoPage';
  static const String cartPage = '/cart/CartPage';
  static const String pickupTimePage =
      '/products/pickupTime/pages/PickUpTimeWidget';
  static const String productsPage = '/products/ProductsWidget';
  static const String subProductsPage = '/products/subProductsPage';
  static const String allLatestProductPage =
      '/category/pages/AllLatestProductPage';
  static const String allTopProductPage = '/category/pages/AllTopProductPage';
  static const String categoriesPage = '/category/pages/CategoriesPage';

  static const String allBestSellerProductPage =
      '/category/pages/AllBestSellerPage';
  static const String allPopularProductPage =
      '/category/pages/AllPopularProductPage';
  static const String productDetailsPage =
      '/products/productDetails/ProductDetailsPage';
  static const String productSearchPage =
      '/products/searchProducts/ProductSearchPage';
  static const String orderDetailsPage = '/order/orderDetails/OrderDetailsPage';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    signInPage: (BuildContext context) => SignInPage(),
    signUpPage: (BuildContext context) => SignUpPage(),
    addressPage: (BuildContext context) => AddressPage(),
    mapPage: (BuildContext context) => MapPage(),
    mainRootPage: (BuildContext context) => MainRootPage(),
    orderPage: (BuildContext context) => OrderPage(),
    checkoutPage: (BuildContext context) => CheckoutPage(),
    allLatestProductPage: (BuildContext context) => AllLatestProductPage(),
    allTopProductPage: (BuildContext context) => AllTopProductPage(),
    allBestSellerProductPage: (context) => AllBestSellerPage(),
    allPopularProductPage: (context) => AllPopularProductPage(),
    categoriesPage:(context) => CategoriesPage(),
    myProfilePage: (BuildContext context) => MyProfilePage(),
    accountInformationPage: (BuildContext context) => AccountInfoPage(),
    cartPage: (BuildContext context) => CartPage(),
    productsPage: (BuildContext context) => ProductPage(),
    subProductsPage: (BuildContext context) => SubCategoryProductPage(),
    productDetailsPage: (BuildContext context) => ProductDetailsPage(),
    productSearchPage: (BuildContext context) => ProductSearchPage(),
    pickupTimePage: (BuildContext context) => PickUpTimePage(),
    orderDetailsPage: (BuildContext context) => OrderDetailsPage(),
  };
}


import 'package:erp/ui/checkout/argument/CheckoutArgument.dart';

class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://tas-jeel.com/api/user";// "https://test.mm8market.com/api/user";
//https://marhabauae.com
  // receiveTimeout
  static const int receiveTimeout = 150000;

  // connectTimeout
  static const int connectionTimeout = 300000;


  /// user management endPoints


  static const String SignUpComplete = baseUrl + "/register";


  static const String Authenticates = baseUrl + "/login";
  static const String forgetPassword = baseUrl + "/reset_password";

  //region Cart
  static const String convertToOrder = baseUrl + "/warehouse/order/cart";
  static const String validateTime = baseUrl + "/slots/validation";
  static const String validateCart = baseUrl + "/sale/order/validate";
  static const String getCart = baseUrl + "/cart/getMyCart";
  static const String clearCart = baseUrl + "/cart/delete";
  static const String addMinusProductRul= baseUrl + "/cart/plus_minus";

  //endregion

  //region CheckoutArgument
  static const String checkout = baseUrl + "/cart/checkoutOrder";
  static const String checkCopuon = baseUrl + "/get_coupone_information";

  // endregion

  /// home
  static const String CategoryUrl = baseUrl + "/categories";
  static const String LatestProductUrl = baseUrl + "/latest_product";
  static const String GetPopularProductUrl = baseUrl + "/trending";

  static const String FlashDealsUrl = baseUrl + "/flash_deals";
  static const String TopProductUrl = baseUrl + "/top_product";
  static const String SliderUrl = baseUrl + "/sliders";
  static const String ProductFilterUrl = baseUrl + "/product/filter";
  static const String SubChildsProductUrl = 'https://tas-jeel.com/api/product/product_by_categories';
  static const String CategoryDetailUrl = baseUrl + "/category_detail";
  static const String ProductsUrl = baseUrl + "/categories_with_subs_products";
  static const String ProductsFavUrl = baseUrl + "/getProducts";///favourit/favourits 
  static const String SearchProductsUrl = baseUrl + "/search-product";
  static const String NewSearchProductsUrl = 'https://tas-jeel.com/api/product/search-productok';
  static const String ProductDetailsUrl = baseUrl + "/detail_product";
  static const String ProductAddFavUrl = baseUrl + "/favourit/store";
  static const String ProductDeleteFavUrl = baseUrl + "/favourit/delete";
  static const String SaveCartUrl = baseUrl + "/cart/store";
  static const String PickupTimeUrl = baseUrl + "/slots";
  static const String AddressUrl = baseUrl + "/address/get";
  static const String ItemInfoUrl = baseUrl + "/address/info";
  static const String OrderUrl = baseUrl + "/cart/getMyOrders";
  static const String OrderDetailsUrl = baseUrl + "/cart/getOrderById";
  static const String addressUrl = baseUrl + "/address/add";
  static const String PersonalProfileUrl = baseUrl + "/profile/personal/all";
  static const String GetBestSellerProductsUrl = baseUrl + "/Best_seller";


}
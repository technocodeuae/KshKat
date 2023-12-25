import 'package:dio/dio.dart';
import 'package:erp/data/repo/checkout_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:erp/data/network/apis/app/app_api.dart';
import 'package:erp/data/network/apis/home/address_api.dart';
import 'package:erp/data/network/apis/home/category_api.dart';
import 'package:erp/data/network/apis/home/map_api.dart';
import 'package:erp/data/network/apis/home/order_api.dart';
import 'package:erp/data/network/apis/home/order_detail_api.dart';
import 'package:erp/data/network/apis/home/pickup_time_api.dart';
import 'package:erp/data/network/apis/home/products_api.dart';
import 'package:erp/data/network/apis/user_management/user_management_api.dart';
import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';
import 'package:erp/data/repo/address_repository.dart';
import 'package:erp/data/repo/cart_repository.dart';
import 'package:erp/data/repo/category_repository.dart';
import 'package:erp/data/repo/map_repository.dart';
import 'package:erp/data/repo/order_details_repository.dart';
import 'package:erp/data/repo/order_repository.dart';
import 'package:erp/data/repo/repository.dart';
import 'package:erp/data/repo/user_management_repository.dart';
import 'package:erp/data/repo/pickup_time_repository.dart';
import 'package:erp/data/repo/products_repository.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';
import 'package:erp/di/module/local_module.dart';
import 'package:erp/di/module/network_module.dart';
import 'package:erp/stores/error/error_store.dart';
import 'package:erp/stores/form/form_store.dart';
import 'package:erp/stores/language/language_store.dart';
import 'package:erp/stores/theme/theme_store.dart';

import '../../data/network/apis/home/cart_api.dart';
import '../../data/network/apis/home/checkout_api.dart';
import '../../data/network/apis/home/slider_api.dart';
import '../../data/repo/slider_repository.dart';

final getIt = GetIt.instance;


Future<void> setupLocator() async {

  // singletons:----------------------------------------------------------------
  getIt.registerSingleton(SharedPreferenceHelper(await getIt.getAsync<SharedPreferences>()));
  getIt.registerSingleton<Dio>(NetworkModule.provideDio(getIt<SharedPreferenceHelper>()));
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(RestClient());

  // api's:---------------------------------------------------------------------
  getIt.registerSingleton(AppApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(UserManagementApi(getIt<DioClient>()));
  getIt.registerSingleton(ProductsApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(CartApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(PickUpTimeApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(CategoryApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(AddressApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(MapApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(SliderApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(OrderApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(CheckoutApi(getIt<DioClient>(), getIt<RestClient>()));
  getIt.registerSingleton(OrderDetailApi(getIt<DioClient>(), getIt<RestClient>()));

  // repository:----------------------------------------------------------------
  getIt.registerSingleton(Repository(
    getIt<AppApi>(),
    getIt<SharedPreferenceHelper>()
  ));

  getIt.registerSingleton(UserManagementRepository(
    getIt<UserManagementApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  getIt.registerSingleton(CategoryRepository(
    getIt<CategoryApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  getIt.registerSingleton(ProductsRepository(
    getIt<ProductsApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  getIt.registerSingleton(CartRepository(
    getIt<CartApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  getIt.registerSingleton(PickUpTimeRepository(
    getIt<PickUpTimeApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  getIt.registerSingleton(AddressRepository(
    getIt<AddressApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  getIt.registerSingleton(CheckoutRepository(
    getIt<CheckoutApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  getIt.registerSingleton(MapRepository(
    getIt<MapApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  getIt.registerSingleton(OrderRepository(
    getIt<OrderApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  getIt.registerSingleton(SliderRepository(
    getIt<SliderApi>(),
    getIt<SharedPreferenceHelper>(),
  ));


  getIt.registerSingleton(OrderDetailRepository(
    getIt<OrderDetailApi>(),
    getIt<SharedPreferenceHelper>(),
  ));

  // stores:--------------------------------------------------------------------
  getIt.registerSingleton(LanguageStore(getIt<Repository>()));
  getIt.registerSingleton(ThemeStore(getIt<Repository>()));
}

Future<void> singleRegister() async{

  // factories:-----------------------------------------------------------------
  getIt.registerFactory(() => ErrorStore());
  getIt.registerFactory(() => FormStore());

  // async singletons:----------------------------------------------------------
  getIt.registerSingletonAsync<SharedPreferences>(
          () => LocalModule.provideSharedPreferences());

}

Future<void> unRegisterLocator() async {

  // singletons:----------------------------------------------------------------
  getIt.unregister<SharedPreferenceHelper>();
  getIt.unregister<Dio>();
  getIt.unregister<DioClient>();
  getIt.unregister<RestClient>();

  // api's:---------------------------------------------------------------------
  getIt.unregister<AppApi>();
  getIt.unregister<UserManagementApi>();
  getIt.unregister<ProductsApi>();
  getIt.unregister<CartApi>();
  getIt.unregister<SliderApi>();
  getIt.unregister<PickUpTimeApi>();
  getIt.unregister<CategoryApi>();
  getIt.unregister<CheckoutApi>();
  getIt.unregister<AddressApi>();
  getIt.unregister<MapApi>();
  getIt.unregister<OrderApi>();
  getIt.unregister<OrderDetailApi>();


  // repository:----------------------------------------------------------------
  getIt.unregister<Repository>();

  getIt.unregister<UserManagementRepository>();

  getIt.unregister<CategoryRepository>();

  getIt.unregister<CartRepository>();

  getIt.unregister<ProductsRepository>();

  getIt.unregister<PickUpTimeRepository>();

  getIt.unregister<AddressRepository>();

  getIt.unregister<CheckoutRepository>();

  getIt.unregister<MapRepository>();

  getIt.unregister<OrderRepository>();
  getIt.unregister<SliderRepository>();

  getIt.unregister<OrderDetailRepository>();

  // stores:--------------------------------------------------------------------
  getIt.unregister<LanguageStore>();
  getIt.unregister<ThemeStore>();
}

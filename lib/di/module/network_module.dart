import 'package:erp/data/network/constants/endpoints.dart';
import 'package:erp/data/sharedpref/shared_preference_helper.dart';
import 'package:dio/dio.dart';

abstract class NetworkModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  static Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8','Accept': 'application/json','X-Requested-With': 'XMLHttpRequest',}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        error: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options,
              RequestInterceptorHandler handler) async {
            // getting token
            var token = await sharedPrefHelper.authToken;
            var lang = await sharedPrefHelper.currentLanguage;

            switch(lang)
            {
              case "ar":
                lang="ar_001";
                break;
              case "en":
                break;
              case "de":
                lang="de_DE";
                break;
            }


            if (token != null) {
              options.headers.putIfAbsent('Authorization', () => "Bearer $token");
              options.headers.putIfAbsent('Lang', () => lang);
              print('Auth token Bearer $token');
            } else {
              options.headers.putIfAbsent('Lang', () => lang);
              print('Auth token is null');
            }

            return handler.next(options);
          },
        ),
      );

    return dio;
  }
}


import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
class DioClient {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient(this._dio);

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(
      String uri, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postWithFile(
      String uri, {
        Map<String, dynamic>? data,
        required String fileKey,
        required String filePath,
        required String fileName,
        required String extension,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      Map<String, dynamic> dataMap = {};
      if (data != null) {
        dataMap.addAll(data);
      }
      if (filePath != null && fileName != null) {
        dataMap.addAll({
          fileKey: await MultipartFile.fromFile(filePath, filename: fileName, contentType: new MediaType("image", extension),),
        });
      }


      print('--------------------  Start Request Body  --------------------'
          ' \n The URL is : [$uri]');
      print('The sended Object Request is : $data');
      print('The sended dataMap Request is : $dataMap');
      // print('The headers is : ${options!.headers}');
      print('The filePath is : $filePath \n '
          '--------------------  End Request Body  --------------------'
          ' \n');

      final Response response = await _dio.post(
        uri,
        data: FormData.fromMap(dataMap),
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      throw e;
    }
  }
}

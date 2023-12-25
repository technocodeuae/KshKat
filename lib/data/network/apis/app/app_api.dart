import 'package:erp/data/network/dio_client.dart';
import 'package:erp/data/network/rest_client.dart';


/// general app api here
class AppApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  AppApi(this._dioClient, this._restClient);


}
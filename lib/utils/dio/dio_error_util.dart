import 'dart:io';

import 'package:dio/dio.dart';

import 'errors/bad_request_error.dart';
import 'errors/base_error.dart';
import 'errors/cancel_error.dart';
import 'errors/conflict_error.dart';
import 'errors/custom_error.dart';
import 'errors/forbidden_error.dart';
import 'errors/http_error.dart';
import 'errors/internal_server_error.dart';
import 'errors/net_error.dart';
import 'errors/not_found_error.dart';
import 'errors/socket_error.dart';
import 'errors/timeout_error.dart';
import 'errors/unauthorized_error.dart';
import 'errors/unknown_error.dart';

class DioErrorUtil {
  // general methods:------------------------------------------------------------
  static BaseError handleError(dynamic error) {
   // String errorDescription = "";
    if (error is DioError) {
      return _handleDioError(error);
    }
    else {
     // errorDescription = "Unexpected error occured";
      return UnknownError();
    }

  }

 static BaseError _handleDioError(DioError error) {
    if (error.type == DioErrorType.other ||
        error.type == DioErrorType.response) {
      if (error is SocketException) return SocketError();
      print(" =============== SocketException ===============");
      if (error.type == DioErrorType.response) {
        print("DioErrorType.RESPONSE message ${error.message}");
        print("DioErrorType.RESPONSE response ${error.response}");
        switch (error.response!.statusCode) {
          case 400:
            return CustomError(
                message: error.response?.data["result"]["msg"] ?? ""
            );
          case 401:
            return 
            UnauthorizedHttpError(
                // message: error.response?.data['msg'] ?? ""
            );
          case 403:
            return ForbiddenError(
                 message: error.response?.data['msg'] ?? ""
            );
          case 404:
            return NotFoundError();
          case 409:
            return ConflictError();
          case 422:
            if (error.response?.data['msg']['username'] !=null)
            return CustomError(
            message: error.response?.data['msg']['username'][0] ?? ""
            );
            if (error.response?.data['msg']['email'] !=null)
              return CustomError(
                  message: error.response?.data['msg']['email'][0] ?? ""
              );
            if (error.response?.data['msg']['password'] !=null)
              return CustomError(
                  message: error.response?.data['msg']['password'][0] ?? ""
              );
            if (error.response?.data['msg']['quantity'] !=null)
              return CustomError(
                  message: error.response?.data['msg']['quantity'][0] ?? ""
              );
            if (error.response?.data['msg']['ar.name'] !=null)
              return CustomError(
                  message: error.response?.data['msg']['ar.name'][0] ?? ""
              );
            if (error.response?.data['msg']['mobile'] !=null)
              return CustomError(
                  message: error.response?.data['msg']['mobile'][0] ?? ""
              );
            if (error.response?.data['msg']['phone'] !=null)
              return CustomError(
                  message: error.response?.data['msg']['phone'][0] ?? ""
              );
            if (error.response?.data['msg']['address 1'] !=null)
              return CustomError(
                  message: error.response?.data['msg']['address 1'][0] ?? ""
              );
            if (error.response?.data['msg']['city_id'] !=null)
              return CustomError(
                  message: error.response?.data['msg']['city_id'][0] ?? ""
              );
           else
              return CustomError(
                  message: error.response?.data['msg'] ?? ""
              );

          case 500:
            return InternalServerError(
                // message: error.response?.data['msg'] ?? ""
            );
          default:
            return HttpError(
                // message : error.response?.data['msg'] ?? ""
            );
        }
      }
      return NetError();
    } else if (error.type == DioErrorType.connectTimeout ||
        error.type == DioErrorType.sendTimeout ||
        error.type == DioErrorType.receiveTimeout) {
      return TimeoutError();
    } else if (error.type == DioErrorType.cancel) {
      return CancelError();
    }
    else
      return UnknownError(
          message : error.response?.data['msg'] ?? ""
      );
  }
}
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../constants/exception_types.dart';
import 'exceptions.dart';

AppException handleException(error) {
  if (error is Exception) {
    try {
      AppException exception = AppException(
        ExceptionType.unknownError.message(),
      );
      if (error is DioException) {
        switch (error.type) {
          //CANCEL
          case DioExceptionType.cancel:
            exception = AppException(
              ExceptionType.requestCancelled.message(),
              statusCode: error.response?.statusCode,
            );
            break;
          //CONNECT TIMEOUT
          case DioExceptionType.connectionTimeout:
            exception = AppException(
              ExceptionType.requestTimeout.message(),
              statusCode: error.response?.statusCode,
            );
            break;
          //RECEIVE TIMEOUT
          case DioExceptionType.receiveTimeout:
            exception = AppException(
              ExceptionType.timeout.message(),
              statusCode: error.response?.statusCode,
            );
            break;
          //RESPONSE
          case DioExceptionType.badResponse:
            debugPrint(error.response?.data['error']['errors'].first);
            exception = AppException(
              error.response?.data['error']['errors'].first,
              statusCode: error.response?.statusCode,
            );
            break;
          case DioExceptionType.sendTimeout:
            exception = AppException(ExceptionType.timeout.message());
            break;
          case DioExceptionType.connectionError:
            if (error.toString().contains('SocketException')) {
              // NO INTERNET CONNECTION
              exception = AppException(
                ExceptionType.noInternetConnection.message(),
                statusCode: error.response?.statusCode,
              );
              break;
            } else {
              // UNKNOWN ERROR
              exception = AppException(
                ExceptionType.unknownError.message(),
                statusCode: error.response?.statusCode,
              );
              break;
            }
          case DioExceptionType.badCertificate:
            exception = AppException(ExceptionType.internalServerError.message());
            break;
          case DioExceptionType.unknown:
            exception = AppException(ExceptionType.unknownError.message());
            break;
        }
      } else if (error is SocketException) {
        exception = AppException(
          ExceptionType.noInternetConnection.message(),
        );
      } else {
        exception = AppException(
          ExceptionType.unknownError.message(),
        );
      }
      return exception;
    } on FormatException catch (_) {
      return AppException(
        ExceptionType.formatException.message(),
      );
    } catch (_) {
      return AppException(
        ExceptionType.unknownError.message(),
      );
    }
  } else {
    return AppException(
      ExceptionType.unknownError.message(),
    );
  }
}

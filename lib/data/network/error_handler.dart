import 'package:dio/dio.dart';
import '../../app/constants.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error so its an error from response of the API  or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectionTimeout:
      return Failure(
          ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
    case DioErrorType.sendTimeout:
      return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
    case DioErrorType.receiveTimeout:
      return Failure(
          ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);

    // response from the API :
    case DioErrorType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? Constants.zero,
            error.response?.statusMessage ?? Constants.empty);
      } else {
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
      }

    case DioErrorType.cancel:
      return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
    case DioErrorType.unknown:
      return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    case DioErrorType.badCertificate:
      return Failure(ResponseCode.BAD_CERTIFICATE, ResponseMessage.DEFAULT);

    case DioErrorType.connectionError:
      return Failure(ResponseCode.CONNECTOIN_ERROR, ResponseMessage.DEFAULT);
  }
}

//  نوع مخصص من الكلاسات مخصص لتخزين القيم التي من نفس النوع enum

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAR_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);
      case DataSource.BAR_REQUEST:
        return Failure(ResponseCode.BAR_REQUEST, ResponseMessage.BAR_REQUEST);
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTORISED:
        return Failure(ResponseCode.UNAUTORISED, ResponseMessage.UNAUTORISED);
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; //  success with no data no content
  static const int BAR_REQUEST = 400; // failure , API rejected request
  static const int UNAUTORISED = 401; // failure , user is not authorized
  static const int FORBIDDEN = 403; // failure , API rejected request
  static const int NOT_FOUND = 404; // failure , not found
  static const int INTERNAL_SERVER_ERROR = 500; // failure , crash in server
  static const int BAD_CERTIFICATE = 501;
  static const int CONNECTOIN_ERROR = 502;

  // local status code (mra7ch ll API sra mchkl 9bl ma yro7 ll api)
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = 'success'; // success with data
  static const String NO_CONTENT =
      'success'; //  success with no data no content
  static const String BAR_REQUEST =
      'Bad request, Try again later'; // failure , API rejected request
  static const String UNAUTORISED =
      'User is unautorised, Try again later'; // failure , user is not authorized
  static const String FORBIDDEN =
      'Forbidden request, Try again later'; // failure , API rejected request
  static const String NOT_FOUND =
      'Some thing went wrong, Try again later'; // failure , crash in server
  static const String INTERNAL_SERVER_ERROR =
      'Some thing went wrong, Try again later'; // failure , crash in server

  // local status code (mra7ch ll API sra mchkl 9bl ma yro7 ll api)
  static const String CONNECT_TIMEOUT = 'Time out error, Try again later';
  static const String CANCEL = 'Request was cancelled, Try again later';
  static const String RECIEVE_TIMEOUT = 'Time out error, Try again later';
  static const String SEND_TIMEOUT = 'Time out error, Try again later';
  static const String CACHE_ERROR = 'Cashe error, Try again later';
  static const String NO_INTERNET_CONNECTION =
      'Pleac check your internet connection';
  static const String DEFAULT = 'Some thing went wrong, Try again later';
}

class AppInternalStatus {
  static const int SUCCESS = 200;
  static const int FAILURE = 401;
}

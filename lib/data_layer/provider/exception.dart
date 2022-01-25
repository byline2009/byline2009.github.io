import 'package:bloc_login/data_layer/provider/logger.dart';
import 'package:logger/logger.dart';

class CommonException implements Exception {
  final _message;
  final Logger _log = getLogger('LocatorInjector');

  CommonException([this._message]);

  String toString() {
    _log.d(_message);
    return "$_message";
  }
}

class BadRequestException extends CommonException {
  BadRequestException([message]) : super(message);
}

class UnauthorisedException extends CommonException {
  UnauthorisedException([message]) : super(message);
}

class FetchDataException extends CommonException {
  FetchDataException([String? message]) : super(message);
}

class UnknownException extends CommonException {
  UnknownException([String? message]) : super(message);
}

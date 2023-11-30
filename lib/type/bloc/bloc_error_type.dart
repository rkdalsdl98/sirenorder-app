// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';

class BlocException {
  final String message;
  final ExceptionType type;

  BlocException(
    this.message,
    this.type,
  );
}

final Map<DioExceptionType, String> DIOEXCEPTION = {
  DioExceptionType.badCertificate: "요청 인증정보가 유효하지 않습니다.",
  DioExceptionType.badResponse: "서버로 부터 요청에 대한 응답을 받지 못했습니다.",
  DioExceptionType.cancel: "요청이 취소되었습니다.",
  DioExceptionType.connectionError: "서버와 연결에 실패했습니다.",
  DioExceptionType.connectionTimeout: "서버와 연결시간이 만료되었습니다.",
  DioExceptionType.receiveTimeout: "서버로 부터 응답을 받는 시간이 만료되었습니다.",
  DioExceptionType.sendTimeout: "서버에 요청하는 시간이 만료되었습니다.",
  DioExceptionType.unknown: "알 수 없는 오류로 요청이 실패했습니다.",
};

enum ExceptionType {
  UnknownException,
  NotFoundException,
  NotFoundDataException,
  RepsitoryLoadException,
  RepsitoryNotDefinedException,
  APIException,
  StateException,
  UnSuitedEventException,
  ServiceUnavailableException,
  AlreadySubscribeStreamException,
}

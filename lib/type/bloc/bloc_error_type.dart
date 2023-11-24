// ignore_for_file: constant_identifier_names

class BlocException {
  final String message;
  final ExceptionType type;

  BlocException(
    this.message,
    this.type,
  );
}

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
}

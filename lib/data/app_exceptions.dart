class ConnectionExceptions implements Exception {}

class TimeoutException extends ConnectionExceptions {
  TimeoutException() : super();
}

class NetworkException extends ConnectionExceptions {
  var message;
  NetworkException(this.message);
}

class NoServiceException extends ConnectionExceptions {
  var message;
  NoServiceException(this.message);
}

class InvalidFormatException extends ConnectionExceptions {
  var message;
  InvalidFormatException(this.message);
}

class BadRequestException extends ConnectionExceptions {
  BadRequestException() : super();
}

class UnauthorisedException extends ConnectionExceptions {
  UnauthorisedException() : super();
}

class ServerException extends ConnectionExceptions {
  ServerException() : super();
}

class AppExceptions implements Exception {}

class GenericException extends AppExceptions {
  var message;
  GenericException(this.message);
}
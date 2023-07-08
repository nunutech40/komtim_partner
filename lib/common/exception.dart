class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() {
    return message;
  }
}

class ServerException extends CustomException {
  ServerException(String message) : super(message);
}

class DatabaseException extends CustomException {
  DatabaseException(String message) : super(message);
}

class UnauthorizedException extends CustomException {
  UnauthorizedException(String message) : super(message);
}

class UnknownException extends CustomException {
  UnknownException(String message) : super(message);
}

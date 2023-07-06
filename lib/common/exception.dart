class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}

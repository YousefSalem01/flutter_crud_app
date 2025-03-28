abstract class ServerException implements Exception {
  final String message;

  const ServerException([this.message = 'Server error occurred']);

  @override
  String toString() => message;
}

class FetchDataException extends ServerException {
  const FetchDataException([String message = 'Error during communication'])
      : super(message);
}

class BadRequestException extends ServerException {
  const BadRequestException([String message = 'Bad request'])
      : super(message);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([String message = 'Unauthorized'])
      : super(message);
}

class NotFoundException extends ServerException {
  const NotFoundException([String message = 'Not found'])
      : super(message);
}

class ConflictException extends ServerException {
  const ConflictException([String message = 'Conflict occurred'])
      : super(message);
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([String message = 'Internal server error'])
      : super(message);
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([String message = 'No internet connection'])
      : super(message);
}

class UnknownException extends ServerException {
  const UnknownException([String message = 'Unknown error occurred'])
      : super(message);
}

class CacheException implements Exception {
  final String message;
  
  const CacheException([this.message = 'Cache error occurred']);

  @override
  String toString() => message;
}
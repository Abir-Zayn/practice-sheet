abstract class AppException implements Exception {
  final String message;

  AppException({required this.message});

  @override
  String toString() => "$runtimeType: $message";
}

class ServerException extends AppException {
  final int? statusCode;

  ServerException({
    required super.message,
    this.statusCode,
  }); 

  @override
  String toString() =>
      "ServerException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}";
}

class NetworkException extends AppException {
  NetworkException({super.message = "No Internet Connection established."});
}

class CacheException extends AppException {
  CacheException({super.message= "Cache read error"});
}

class UnauthorizedException extends AppException {
  UnauthorizedException({super.message = "Access Denied"});
}

class FileSystemException extends AppException {
  FileSystemException({super.message = "File system error"});
}

class TokenRefreshFailedException extends AppException {
  TokenRefreshFailedException({super.message = "Failed to refresh access token"});
}
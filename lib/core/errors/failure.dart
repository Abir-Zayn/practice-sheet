
import 'package:equatable/equatable.dart';
import 'package:mockai/core/errors/exceptions.dart';

abstract class Failure extends Equatable{
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode
  });

  @override
  List<Object?> get props => [message, statusCode]; 

  @override
  String toString() => '$runtimeType: $message${statusCode != null ? '(Status: $statusCode)' : ''}';

  /// Factory to map any data layer exception to domain-layer Failure 
  factory Failure.fromException(Object e){
    if (e is ServerException){
      return ServerFailure(message: e.message, statusCode: e.statusCode); 
    }
    else if (e is NetworkException){
      return NetworkFailure(message: e.message); 
    }
    else if (e is CacheException){
      return CacheFailure(message: e.message); 
    }
    else if (e is UnauthorizedException){
      return UnauthorizedFailure(message: e.message); 
    }
    else if (e is FileSystemException){
      return FileSystemFailure(message: e.message); 
    }
    else if (e is TokenRefreshFailedException){
      return AuthFailure(message: e.message, statusCode : 401); 
    }
    else{
      return ServerFailure(message: 'An unexpected error occurred'); 
    }
  }
}

class ServerFailure extends Failure{
  const ServerFailure({required super.message, super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({
    super.message = 'Failed to load data from local cache.',
    super.statusCode,
  });
}

/// Returned when internet connectivity / socket errors occur.
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No Internet connection. Please check your network.',
    super.statusCode,
  });
}


class UnauthorizedFailure extends Failure{
  const UnauthorizedFailure({required super.message});
}

class FileSystemFailure extends Failure{
  const FileSystemFailure({required super.message});
}

class TokenRefreshFailedFailure extends Failure{
  const TokenRefreshFailedFailure({required super.message});
}


class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Authentication failed. Please log in again.',
    super.statusCode,
  });
}

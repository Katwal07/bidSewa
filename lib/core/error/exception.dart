abstract class AppException implements Exception{
  final String? message;

  AppException({required this.message});
}

class ServerException extends AppException{
  ServerException({required super.message});
}

class NetworkException extends AppException{
  NetworkException({required super.message});
}

class UnAuthorizedException extends AppException{
  UnAuthorizedException({required super.message});
}

class ValidationException extends AppException{
  ValidationException({required super.message});
}
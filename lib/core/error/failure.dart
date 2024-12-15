abstract class Failure{
  final String? message;

  Failure({required this.message});
}

class ServerFailure extends Failure{
  ServerFailure({required super.message});
}

class NetworkFailure extends Failure{
  NetworkFailure({required super.message});
}

class UnAuthorizedFailure extends Failure{
  UnAuthorizedFailure({required super.message});
}

class ValidationFailure extends Failure{
  ValidationFailure({required super.message});
}

class UnExceptedFailure extends Failure{
  UnExceptedFailure({required super.message});
}
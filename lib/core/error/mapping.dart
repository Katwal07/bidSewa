import 'exception.dart';
import 'failure.dart';

Failure mapExceptionToFailure(Exception exception){
  if(exception is ServerException){
    return ServerFailure(message: exception.message ?? "Server error occured");
  }
  else if(exception is NetworkException){
    return NetworkFailure(message: exception.message ?? "No internet connection");
  }
  else if(exception is UnAuthorizedException){
    return UnAuthorizedFailure(message: exception.message ?? "Unauthorised access");
  }
  else if(exception is ValidationException){
    return ValidationFailure(message: exception.message ?? "Invalid data provided");
  }
  else{
    return UnExceptedFailure(message: "An unexpected error occured");
  }
}
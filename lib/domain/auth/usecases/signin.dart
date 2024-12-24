part of 'usecase_imports.dart';

class SignInUseCase implements UseCase<Either<Failure, UserResponseEntity>, SigninReqParamsEntity> {
  @override
  Future<Either<Failure, UserResponseEntity>> call(
      {SigninReqParamsEntity? param}) async {
    return await sl<AuthRepository>().signin(param!);
  }
}

part of 'usecase_imports.dart';

class SignUpUseCase implements UseCase<Either<Failure, UserResponseEntity>, SignupReqParamsEntity> {
  @override
  Future<Either<Failure, UserResponseEntity>> call({SignupReqParamsEntity? param}) async {
    return await sl<AuthRepository>().signup(param!);
  }
}

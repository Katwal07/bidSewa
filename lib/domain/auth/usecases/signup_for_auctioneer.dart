part of 'usecase_imports.dart';

class SignupUseCaseForAuctioneer
    implements UseCase<Either<Failure, UserResponseEntity>, SignupReqParamsForAuctioneerEntity> {
  @override
  Future<Either<Failure, UserResponseEntity>> call({SignupReqParamsForAuctioneerEntity? param}) async {
    return await sl<AuthRepository>().signupForAuctioneer(param!);
  }
}

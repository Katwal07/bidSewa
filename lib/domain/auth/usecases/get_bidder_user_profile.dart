part of 'usecase_imports.dart';

class GetBidderUserProfileUseCase extends UseCase<Either<Failure, BidderUserEntity>, dynamic> {
  @override
  Future<Either<Failure, BidderUserEntity>> call({param}) async {
    return await sl<AuthRepository>().getBidderUserProfile();
  }
}
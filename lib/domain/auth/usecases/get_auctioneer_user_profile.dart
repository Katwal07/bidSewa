part of 'usecase_imports.dart';

class GetUserProfileUseCase extends UseCase<Either<Failure, AuctioneerUserEntity>, dynamic> {
  @override
  Future<Either<Failure, AuctioneerUserEntity>> call({param}) async {
    return await sl<AuthRepository>().getAuctioneerUserProfile();
  }
}

part of 'usecase_imports.dart';

class GetUserProfileUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({param}) async {
    return await sl<AuthRepository>().getAuctioneerUserProfile();
  }
}

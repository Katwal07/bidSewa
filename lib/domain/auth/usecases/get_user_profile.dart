import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/auth/repositories/auth.dart';
import 'package:nepa_bid/service_locator.dart';

class GetUserProfileUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({param}) async {
    return await sl<AuthRepository>().getAuctioneerUserProfile();
  }
}

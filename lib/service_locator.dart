import 'package:get_it/get_it.dart';
import 'package:nepa_bid/core/network/api_client.dart';
import 'package:nepa_bid/data/auctioneer/repositories/auction.dart';
import 'package:nepa_bid/data/auctioneer/source/auction_api_service.dart';
import 'package:nepa_bid/data/auth/repositories/auth_imports.dart';
import 'package:nepa_bid/domain/auctioneer/repositories/auction.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/auction.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/create_auction_usecase.dart';
import 'data/auth/source/auth_api_imports.dart';
import 'domain/auth/repositories/auth_imports.dart';
import 'domain/auth/usecases/usecase_imports.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  /// Http Request
  sl.registerSingleton<ApiClient>(ApiClient());

  /// APIs Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  sl.registerSingleton<AuctionApiService>(AuctionApiServiceImpl());

  /// Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<AuctionRepository>(AuctionRepositoryImpl());

  /// UseCases
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<LoggedOut>(LoggedOut());
  sl.registerSingleton<SignupUseCaseForAuctioneer>(SignupUseCaseForAuctioneer());
  sl.registerSingleton<CreateAuctionUsecase>(CreateAuctionUsecase());
  sl.registerSingleton<AuctionUseCase>(AuctionUseCase());
  sl.registerSingleton<GetUserProfileUseCase>(GetUserProfileUseCase());

}

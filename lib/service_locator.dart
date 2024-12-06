import 'package:get_it/get_it.dart';
import 'package:nepa_bid/core/network/api_client.dart';
import 'package:nepa_bid/data/auctioneer/repositories/auction.dart';
import 'package:nepa_bid/data/auctioneer/source/auction_api_service.dart';
import 'package:nepa_bid/data/auth/repositories/auth.dart';
import 'package:nepa_bid/data/auth/source/auth_api_service.dart';
import 'package:nepa_bid/data/auth/source/auth_local_service.dart';
import 'package:nepa_bid/domain/auctioneer/repositories/auction.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/create_auction_usecase.dart';
import 'package:nepa_bid/domain/auth/repositories/auth.dart';
import 'package:nepa_bid/domain/auth/usecases/is_logged_in.dart';
import 'package:nepa_bid/domain/auth/usecases/logged_out.dart';
import 'package:nepa_bid/domain/auth/usecases/signin.dart';
import 'package:nepa_bid/domain/auth/usecases/signup.dart';
import 'package:nepa_bid/domain/auth/usecases/signup_for_auctioneer.dart';

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

}

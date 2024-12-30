import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:nepa_bid/core/network/api_client.dart';
import 'package:nepa_bid/data/auctioneer/repositories/auction.dart';
import 'package:nepa_bid/data/auctioneer/source/auction_api_service.dart';
import 'package:nepa_bid/data/auth/repositories/auth_imports.dart';
import 'package:nepa_bid/data/bidder/repositories/bidder.dart';
import 'package:nepa_bid/data/bidder/sources/bidder_api_sources.dart';
import 'package:nepa_bid/data/network/network_info_impl.dart';
import 'package:nepa_bid/domain/auctioneer/repositories/auction.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/auction.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/create_auction_usecase.dart';
import 'package:nepa_bid/domain/bidder/repositories/bidder.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_bid_by_bidder_id_usecase.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_category_usecase.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_items_details_usecase.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_news_in_usecase.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_search_items_usecase.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_top_bidd_usecase.dart';
import 'package:nepa_bid/domain/bidder/usecases/place_bid_usecase.dart';
import 'package:nepa_bid/domain/network/repositories/network_info.dart';
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
  sl.registerSingleton<BidderApiSources>(BidderApiSourceImpl());

  /// Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<AuctionRepository>(AuctionRepositoryImpl());
  sl.registerSingleton<BidderRepository>(BidderRepositoryImpl());

  /// UseCases
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<LoggedOut>(LoggedOut());
  sl.registerSingleton<SignupUseCaseForAuctioneer>(
      SignupUseCaseForAuctioneer());
  sl.registerSingleton<CreateAuctionUsecase>(CreateAuctionUsecase());
  sl.registerSingleton<AuctionUseCase>(AuctionUseCase());
  sl.registerSingleton<GetUserProfileUseCase>(GetUserProfileUseCase());
  sl.registerSingleton<GetBidderUserProfileUseCase>(
      GetBidderUserProfileUseCase());
  sl.registerSingleton<GetNewsInUsecase>(GetNewsInUsecase());
  sl.registerSingleton<GetTopBiddUsecase>(GetTopBiddUsecase());
  sl.registerSingleton<GetItemsDetailsUsecase>(GetItemsDetailsUsecase());
  sl.registerSingleton<BidderPlaceBidUsecase>(BidderPlaceBidUsecase());
  sl.registerSingleton<GetSearchItemsUsecase>(GetSearchItemsUsecase());
  sl.registerSingleton<GetCategoryUsecase>(GetCategoryUsecase());
  sl.registerSingleton<GetBidByBidderIdUsecase>(GetBidByBidderIdUsecase());

  /// Connectivity
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<NetworkInfoRepository>(
      () => NetworkInfoRepositoryImpl(sl()));
}

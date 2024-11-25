import 'package:get_it/get_it.dart';
import 'package:nepa_bid/core/network/api_client.dart';
import 'package:nepa_bid/data/auth/repositories/auth.dart';
import 'package:nepa_bid/data/auth/source/auth_api_service.dart';
import 'package:nepa_bid/data/auth/source/auth_local_service.dart';
import 'package:nepa_bid/domain/auth/repositories/auth.dart';
import 'package:nepa_bid/domain/auth/usecases/is_logged_in.dart';
import 'package:nepa_bid/domain/auth/usecases/logged_out.dart';
import 'package:nepa_bid/domain/auth/usecases/signin.dart';
import 'package:nepa_bid/domain/auth/usecases/signup.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  /// Http Request
  sl.registerSingleton<ApiClient>(ApiClient());

  /// APIs Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  /// Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  /// UseCases
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<LoggedOut>(LoggedOut());
}

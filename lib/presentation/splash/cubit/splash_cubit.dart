import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/domain/auth/usecases/is_logged_in.dart';
import 'package:nepa_bid/service_locator.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitialState());

  void displaySplash() async {
    await Future.delayed(const Duration(seconds: 3));
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(SplashAuthenticatedState());
    } else {
      emit(SplashUnAuthenticatedState());
    }
  }
}

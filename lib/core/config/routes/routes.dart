import 'package:flutter/material.dart';
import '../../../presentation/auth/pages/auth_imports.dart';
import '../../../presentation/onboard/page/onboard_imports.dart';
import '../../../presentation/splash/page/splash_imports.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppRoutesName.onboardScreen:
        return MaterialPageRoute(builder: (context) => OnBoardScreen());
      case AppRoutesName.authScreen:
        return MaterialPageRoute(builder: (context) => const ChooseAuthPage());
      case AppRoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case AppRoutesName.signupScreen:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No Route Generated"),
            ),
          );
        });
    }
  }
}

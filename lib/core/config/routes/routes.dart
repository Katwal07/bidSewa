import 'package:flutter/material.dart';
import 'package:nepa_bid/domain/auctioneer/entity/product_argument.dart';
import 'package:nepa_bid/presentation/auctioneer/home/pages/home.dart';
import 'package:nepa_bid/presentation/auctioneer/profile/pages/profile.dart';
import 'package:nepa_bid/presentation/bidder/home/pages/home.dart';
import 'package:nepa_bid/presentation/bidder/home/widgets/category/see_all.dart';
import 'package:nepa_bid/presentation/bidder/search/pages/search.dart';
import 'package:nepa_bid/presentation/navigation_bar/auctioneer/pages/navigation.dart';
import '../../../presentation/auctioneer/post/pages/add_prod.dart';
import '../../../presentation/auctioneer/post/pages/add_prod_desc.dart';
import '../../../presentation/auth/pages/auth_imports.dart';
import '../../../presentation/navigation_bar/bidder/pages/navigation.dart';
import '../../../presentation/onboard/page/onboard_imports.dart';
import '../../../presentation/splash/page/splash_imports.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      /// App Intro
      case AppRoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case AppRoutesName.onboardScreen:
        return MaterialPageRoute(builder: (context) => OnBoardScreen());
      /// App Authentication
      case AppRoutesName.authScreen:
        return MaterialPageRoute(builder: (context) => const ChooseAuthPage());
      case AppRoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case AppRoutesName.signupScreen:
        return MaterialPageRoute(builder: (context) => const SignupScreen());
      /// Auctioneer
      case AppRoutesName.navPage:
        return MaterialPageRoute(builder: (context) => const NavigationScreen());
      case AppRoutesName.addPostDetailsAuctionner:
        return MaterialPageRoute(builder: (context) => AddProductDetails());
      case AppRoutesName.addPostAuctionner:
        final productArguments = settings.arguments as ProductArguments;
        return MaterialPageRoute(
          builder: (context) => AddProduct(
            productArguments: productArguments,
          ),
        );
      case AppRoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case AppRoutesName.profileScreen:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      /// Bidder
      case AppRoutesName.navPageBidder:
        return MaterialPageRoute(builder: (context) => const NavigationScreenBidder());
      case AppRoutesName.homeScreenBidder:
        return MaterialPageRoute(builder: (context) => const HomePageBidder());
      case AppRoutesName.searchPage:
        return MaterialPageRoute(builder: (context) => const SearchPageBidder());
      case AppRoutesName.seeAllCategory:
        return MaterialPageRoute(builder: (context) => const SeeAllCategorySection());
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

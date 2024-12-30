import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/domain/auth/usecases/usecase_imports.dart';
import 'package:nepa_bid/presentation/bidder/bids/pages/bids.dart';
import 'package:nepa_bid/presentation/navigation_bar/bidder/pages/navbar_items.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../core/config/theme/colors.dart';
import '../../../../core/config/utils/utils.dart';
import '../../../bidder/home/pages/home.dart';
import '../../../bidder/profile/pages/profile.dart';
import '../../../bidder/search/pages/search_page_nav.dart';
import '../bloc/navigation_cubit_bidder.dart';
import '../bloc/navigation_state_bidder.dart';

class NavigationScreenBidder extends StatefulWidget {
  const NavigationScreenBidder({super.key});

  @override
  State<NavigationScreenBidder> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreenBidder>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setStatusBarColor();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    _setStatusBarColor();
  }

  void _setStatusBarColor() {
    Future.delayed(Duration.zero, () {
      final isDarkTheme = AppUtils.isDarkTheme(context);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor:
            isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        statusBarIconBrightness:
            isDarkTheme ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigationCubitBidder(),
        ),
        BlocProvider(
          create: (context) =>
              GenericCubit()..execute(sl<GetBidderUserProfileUseCase>()),
        ),
      ],
      child: BlocBuilder<GenericCubit, GenericState>(
        builder: (context, genericState) {
          if(genericState is DataLoaded){
            final bidderUserId = genericState.data.user.id;
            List<Widget> bottomNavScreen = [
              const HomePageBidder(),
              const SearchPageNav(),
              BidPageBidder(bidderId: bidderUserId),
              const ProfilePageBidder(),
            ];
            return BlocBuilder<NavigationCubitBidder, NavigationStateBidder>(
            builder: (context, state) {
              if (state is NavigateStateBidder) {
                return Scaffold(
                  backgroundColor: isDarkTheme
                      ? AppColors.darkBgColor
                      : AppColors.lightBgColor,
                  body: SafeArea(
                    child: IndexedStack(
                      index: state.tabIndex,
                      children: bottomNavScreen,
                    ),
                  ),
                  bottomNavigationBar:
                      _buildBottomNavigationBar(context, state),
                );
              }
              return const SizedBox.shrink();
            },
          );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, NavigateStateBidder state) {
    final isDarkTheme = AppUtils.isDarkTheme(context);

    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: AppColors.lightPrimaryColor.withValues(alpha: 0.7),
            labelTextStyle:
                WidgetStateTextStyle.resolveWith((Set<WidgetState> states) {
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).textTheme.bodySmall!;
              }
              return Theme.of(context).textTheme.bodySmall!;
            })),
        child: NavigationBar(
          elevation: 0,
          backgroundColor: AppColors.transparent,
          selectedIndex: state.tabIndex,
          onDestinationSelected: (index) {
            context.read<NavigationCubitBidder>().onTabClick(index);
          },
          destinations: bottomNavigationBarItems,
        ),
      ),
    );
  }
}

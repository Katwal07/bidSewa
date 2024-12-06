import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/presentation/navigation_bar/bidder/bloc/navigation_cubit_bidder.dart';
import 'package:nepa_bid/presentation/navigation_bar/bidder/bloc/navigation_state_bidder.dart';
import '../../../../core/config/theme/colors.dart';
import '../../../../core/config/utils/utils.dart';
import 'navbar_items.dart';
import 'navbar_screens.dart';

class NavigationScreenBidder extends StatelessWidget {
  const NavigationScreenBidder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubitBidder(),
      child: BlocBuilder<NavigationCubitBidder, NavigationStateBidder>(
        builder: (context, state) {
          if (state is NavigateStateBidder) {
            return _buildNavigationScaffold(state, context);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildNavigationScaffold(NavigateStateBidder state, BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: state.tabIndex, // Determines which child is visible
          children: bottomNavScreen, // List of all possible Screens
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, state),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, NavigateStateBidder state) {
    final isDarkTheme = AppUtils.isDarkTheme(context);

    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.1),
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: AppColors.lightPrimaryColor.withOpacity(.7),
          labelTextStyle: WidgetStateTextStyle.resolveWith((Set<WidgetState> states){
            if(states.contains(WidgetState.selected)){
              return Theme.of(context).textTheme.bodySmall!;
            }
              return Theme.of(context).textTheme.bodySmall!;
          })
        ),
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

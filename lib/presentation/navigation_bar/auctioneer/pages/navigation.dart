import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/theme/colors.dart';
import '../../../../core/config/utils/utils.dart';
import '../bloc/navigation_cubit.dart';
import '../bloc/navigation_state.dart';
import 'navbar_items.dart';
import 'navbar_screens.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> with WidgetsBindingObserver {
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
        statusBarColor: isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDarkTheme ? Brightness.dark : Brightness.light,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          if (state is NavigateState) {
            return Scaffold(
              backgroundColor: isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
              body: SafeArea(
                child: IndexedStack(
                  index: state.tabIndex,
                  children: bottomNavScreen,
                ),
              ),
              bottomNavigationBar: _buildBottomNavigationBar(context, state),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, NavigateState state) {
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
            context.read<NavigationCubit>().onTabClick(index);
          },
          destinations: bottomNavigationBarItems,
        ),
      ),
    );
  }
}
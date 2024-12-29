import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/bloc/logout/logout_cubit.dart';
import 'package:nepa_bid/common/bloc/logout/logout_state.dart';
import 'package:nepa_bid/common/widgets/profile/user_details.dart';
import 'package:nepa_bid/common/widgets/profile/user_info.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../core/config/theme/colors.dart';
import '../../../../domain/auth/usecases/usecase_imports.dart';

class ProfilePageBidder extends StatelessWidget {
  const ProfilePageBidder({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LogoutCubit(),
        ),
        BlocProvider(
          create: (context) =>
              GenericCubit()..execute(sl<GetBidderUserProfileUseCase>()),
        ),
      ],
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutesName.authScreen, (route) => false);
          }
        },
        child: Scaffold(
          backgroundColor:
              isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ComponentsSizes.horizontalPadding, vertical: 0),
              child: BlocBuilder<GenericCubit, GenericState>(
                builder: (context, state) {
                  if(state is DataLoaded){
                    return Stack(
                    fit: StackFit.expand,
                    children: [
                      const UserInfo(),
                      UserDetails(userRole: state.data.user.role,),
                    ],
                  );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

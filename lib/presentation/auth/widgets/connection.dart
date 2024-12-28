import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/connectivity/connectivity_cubit.dart';
import 'package:nepa_bid/common/bloc/connectivity/connectivity_state.dart';
import 'package:nepa_bid/common/widgets/appbar/appbar.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return Scaffold(
      appBar: CustomAppBar(
        darkStatusBarColor: AppColors.darkBgColor,
        lightStatusBarColor: AppColors.lightBgColor,
      ),
      backgroundColor: isDarkTheme
          ? AppColors.darkBgColor
          : AppColors.lightBgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ComponentsSizes.horizontalPadding,
            vertical: ComponentsSizes.defaultSpace * 6),
        child: Column(
          spacing: ComponentsSizes.defaultSpace,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
              child: Image(image: AssetImage("assets/images/im_red_icon.webp")),
            ),
            Text(
              "Connection Error",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Couldn't connect to the server at the moment. Please try again",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            BlocBuilder<NetworkCubit, ConnectivityState>(
              builder: (context, state) {
                if (state is NetworkChecking) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          disabledBackgroundColor: AppColors.lightPrimaryColor),
                      onPressed: null,
                      child: Text(
                        "Please wait ...",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.white),
                      ),
                    ),
                  );
                }
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        context.read<NetworkCubit>().retryConnection(),
                    child: Text(
                      "Try again",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppColors.white),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

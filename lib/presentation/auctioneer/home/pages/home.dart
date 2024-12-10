import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/widgets/gridview/custom_gridview.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/auction.dart';
import 'package:nepa_bid/service_locator.dart';
import '../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../core/config/theme/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
      statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    ));
    return BlocProvider(
      create: (context) => GenericCubit()..execute(sl<AuctionUseCase>()),
      child: Scaffold(
        body: BlocBuilder<GenericCubit, GenericState>(
          builder: (context, state) {
            if (state is DataLoaded) {
              return CustomGridView(
                  data: state.data,
                  itemCount: state.data.length,
                );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/common/widgets/appbar/appbar.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../core/config/theme/colors.dart';
import '../../../../core/config/utils/utils.dart';
import '../../../../domain/auth/usecases/usecase_imports.dart';

class BidderPersonalInformation extends StatelessWidget {
  const BidderPersonalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
      statusBarIconBrightness: isDarkTheme ? Brightness.light : Brightness.dark,
    ));
    return BlocProvider(
      create: (context) => GenericCubit()..execute(sl<GetBidderUserProfileUseCase>()),
      child: Scaffold(
        appBar: CustomAppBar(title: "User Details", darkStatusBarColor: AppColors.darkBgColor, lightStatusBarColor: AppColors.lightBgColor,icon: Icons.arrow_back,),
        backgroundColor:
            isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ComponentsSizes.horizontalPadding),
            child: SingleChildScrollView(
              child: BlocBuilder<GenericCubit, GenericState>(
                builder: (context, state) {
                  if(state is DataLoaded){
                    final userData = state.data;
                    return Column(
                    children: [
                      _buildHeight20(),
                      _userAvatar(userData.user.profileImage.url),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeight20(),
                          _divider(),
                          _buildHeight10(),
                          _userDetailsTitle(context, "Profile Information"),
                          _buildHeight20(),
                          _userTitleAndInfo(context, "Name", userData.user.username),
                          _buildHeight10(),
                          _userTitleAndInfo(
                              context, "User Name", userData.user.username),
                          _divider(),
                          _buildHeight10(),
                          _userDetailsTitle(context, "Personal Information"),
                          _buildHeight20(),
                          _userTitleAndInfo(
                              context, "User Id", userData.user.id),
                          _buildHeight10(),
                          _userTitleAndInfo(
                              context, "Email", userData.user.email),
                          _buildHeight10(),
                          _userTitleAndInfo(context, "Phone", userData.user.phone),
                          _buildHeight10(),
                          _userTitleAndInfo(context, "Role", userData.user.role),
                          _buildHeight10(),
                          _divider(),
                          _buildHeight10(),
                        ],
                      )
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

  Widget _userAvatar(String avatar) {
    return CircleAvatar(
      radius: 14 * SizeConfigs.imageSizeMultiplier,
      child: ClipOval(
        child: Image(image: NetworkImage(avatar)),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      thickness: 1,
    );
  }

  Widget _userDetailsTitle(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _userTitleAndInfo(BuildContext context, String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            info,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildHeight20() {
    return SizedBox(
      height: 2.14 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildHeight10() {
    return SizedBox(
      height: 1.07 * SizeConfigs.heightMultiplier,
    );
  }
}

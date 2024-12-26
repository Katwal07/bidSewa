import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/core/constant/text_string.dart';
import '../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../core/config/assets/app_vectors.dart';
import '../../../../core/config/theme/colors.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.5,
      child: BlocBuilder<GenericCubit, GenericState>(
        builder: (context, state) {
          if (state is DataLoaded) {
            final userData = state.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _userAvatar(userData.user.profileImage.url),
                _buildHeight10(),
                _userName(context, userData.user.username),
                _buildHeight5(),
                _userEmail(context,userData.user.email),
                _buildHeight10(),
                _userInfoContainer(context),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _userAvatar(String userAvatar) {
    return CircleAvatar(
      radius: 14 * SizeConfigs.widthMultiplier,
      child: ClipOval(child: Image(image: NetworkImage(userAvatar),),),
    );
  }

  Widget _userName(BuildContext context, String dataLoaded) {
    return Text(
      dataLoaded,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _userEmail(BuildContext context, String email) {
    return Text(
      email,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _userInfoContainer(BuildContext context) {
    return Container(
      height: 9.37 * SizeConfigs.heightMultiplier,
      decoration: BoxDecoration(
        color: AppColors.borderPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildUserInfos(context, AppStrings.order, AppVectors.order),
          _buildUserInfos(context, AppStrings.payments, AppVectors.payment),
          _buildUserInfos(context, AppStrings.address, AppVectors.address),
        ],
      ),
    );
  }

  Widget _buildUserInfos(BuildContext context, String text, String vectors) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          width: 7.3 * SizeConfigs.widthMultiplier,
          height: 3.28 * SizeConfigs.heightMultiplier,
          vectors,
          colorFilter: const ColorFilter.mode(AppColors.grey, BlendMode.srcIn),
        ),
        _buildHeight5(),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: AppColors.white),
        )
      ],
    );
  }

  Widget _buildHeight10() {
    return SizedBox(
      height: 1.07 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildHeight5() {
    return SizedBox(
      height: 0.54 * SizeConfigs.heightMultiplier,
    );
  }
}

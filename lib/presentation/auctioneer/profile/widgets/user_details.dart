import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nepa_bid/common/bloc/logout/logout_cubit.dart';
import 'package:nepa_bid/common/bloc/logout/logout_state.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/service_locator.dart';
import '../../../../core/config/assets/app_vectors.dart';
import '../../../../core/config/theme/colors.dart';
import '../../../../domain/auth/usecases/usecase_imports.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.bottomCenter,
      heightFactor: 0.5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserDetails(context, AppVectors.user, "User Details",
                AppRoutesName.userDetails),
            _divider(),
            _buildHeight10(),
            _buildUserDetails(context, AppVectors.settings, "Settings",
                AppRoutesName.userDetails),
            _divider(),
            _buildHeight10(),
            _buildUserDetails(context, AppVectors.helpAndSupport,
                "Help & Supports", AppRoutesName.userDetails),
            _divider(),
            _buildHeight10(),
            _buildUserDetails(context, AppVectors.language, "Change Language",
                AppRoutesName.userDetails),
            _divider(),
            _buildHeight10(),
            _buildLogoutUser(context),
            _divider(),
            _buildHeight10(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserDetails(
      BuildContext context, String vectors, String text, String routesName) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routesName),
      child: Row(
        children: [
          Container(
            width: 10.7 * SizeConfigs.widthMultiplier,
            height: 5 * SizeConfigs.heightMultiplier,
            decoration: BoxDecoration(
                color: AppColors.borderPrimary,
                borderRadius: BorderRadius.circular(12)),
            child: SvgPicture.asset(
              width: 5.58 * SizeConfigs.widthMultiplier,
              height: 2.57 * SizeConfigs.heightMultiplier,
              vectors,
              fit: BoxFit.scaleDown,
            ),
          ),
          _buildWidth20(),
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          )
        ],
      ),
    );
  }

  Widget _buildHeight10() {
    return SizedBox(
      height: 1.07 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildWidth20() {
    return SizedBox(
      width: 4.65 * SizeConfigs.widthMultiplier,
    );
  }

  Widget _divider() {
    return const Divider(
      thickness: 1,
    );
  }

  Widget _buildLogoutUser(BuildContext context) {
    return BlocBuilder<LogoutCubit, LogoutState>(
      builder: (context, state) {
        if (state is LogoutInitial) {
          return GestureDetector(
            onTap: (){
              context.read<LogoutCubit>().logoutUser(usecase: sl<LoggedOut>());
            },
            child: Row(
              children: [
                Container(
                  width: 10.7 * SizeConfigs.widthMultiplier,
                  height: 5 * SizeConfigs.heightMultiplier,
                  decoration: BoxDecoration(
                    color: AppColors.borderPrimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    width: 5.58 * SizeConfigs.widthMultiplier,
                    height: 2.57 * SizeConfigs.heightMultiplier,
                    AppVectors.logout,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                _buildWidth20(),
                Text(
                  "Logout",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          );
        }
        if (state is LogoutLoading) {
          return GestureDetector(
            onTap: null,
            child: Row(
              children: [
                Container(
                  width: 10.7 * SizeConfigs.widthMultiplier,
                  height: 5 * SizeConfigs.heightMultiplier,
                  decoration: BoxDecoration(
                    color: AppColors.borderPrimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    width: 5.58 * SizeConfigs.widthMultiplier,
                    height: 2.57 * SizeConfigs.heightMultiplier,
                    AppVectors.logout,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                _buildWidth20(),
                const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: AppColors.borderPrimary,
                    )),
              ],
            ),
          );
        }
        if (state is LogoutSuccess) {
          return GestureDetector(
            onTap: null,
            child: Row(
              children: [
                Container(
                  width: 10.7 * SizeConfigs.widthMultiplier,
                  height: 5 * SizeConfigs.heightMultiplier,
                  decoration: BoxDecoration(
                    color: AppColors.borderPrimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    width: 5.58 * SizeConfigs.widthMultiplier,
                    height: 2.57 * SizeConfigs.heightMultiplier,
                    AppVectors.logout,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                _buildWidth20(),
                Text(
                  "Logout",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

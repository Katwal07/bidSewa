import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/presentation/auth/bloc/auth/auth_cubit.dart';
import '../../../core/config/theme/colors.dart';
import '../../../core/constant/sizes.dart';
import '../../res/size_configs.dart';

class AppReactiveButton extends StatelessWidget {
  const AppReactiveButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  final void Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is ButtonLoadingState) {
          return _loading(context);
        }
        return _loaded(context);
      },
    );
  }

  Widget _loading(context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        disabledForegroundColor:
            isDarkTheme ? AppColors.darkFontColor : AppColors.lightFontColor,
        disabledBackgroundColor:
            isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        side: BorderSide(
            color: isDarkTheme
                ? AppColors.lightContainerColor
                : AppColors.darkContainerColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: AppColors.lightPrimaryColor),
          ),
          SizedBox(
            width: ComponentsSizes.defaultSpace,
          ),
          SizedBox(
            width: 5.12 * SizeConfigs.widthMultiplier,
            height: 2.36 * SizeConfigs.heightMultiplier,
            child: CircularProgressIndicator(
              color: AppColors.lightPrimaryColor,
              strokeWidth: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loaded(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.darkFontColor,
            ),
      ),
    );
  }
}

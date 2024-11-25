import 'package:flutter/material.dart';
import '../../../../common/res/size_configs.dart';
import '../colors.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  /// Light ElevatedButtonTheme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.buttonPrimary,
      disabledForegroundColor: AppColors.buttonDisabled,
      disabledBackgroundColor: AppColors.buttonDisabled,
      side: const BorderSide(color: AppColors.buttonPrimary),
      padding:
          EdgeInsets.symmetric(vertical: 1.9 * (SizeConfigs.heightMultiplier)),
      textStyle: TextStyle(
          fontSize: 1.7 * (SizeConfigs.textMultiplier),
          color: AppColors.white,
          fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          1.3 * (SizeConfigs.heightMultiplier),
        ),
      ),
    ),
  );

  /// Dark ElevatedButton Theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.buttonPrimary,
      disabledForegroundColor: AppColors.buttonDisabled,
      disabledBackgroundColor: AppColors.buttonDisabled,
      side: const BorderSide(color: AppColors.buttonPrimary),
      padding:
          EdgeInsets.symmetric(vertical: 1.9 * (SizeConfigs.heightMultiplier)),
      textStyle: TextStyle(
          fontSize: 1.7 * (SizeConfigs.textMultiplier),
          color: AppColors.white,
          fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          1.9 * (SizeConfigs.heightMultiplier),
        ),
      ),
    ),
  );
}

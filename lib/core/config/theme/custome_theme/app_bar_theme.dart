import 'package:flutter/material.dart';
import 'package:nepa_bid/common/res/size_configs.dart';

import '../colors.dart';

class AppAppBarTheme {
  AppAppBarTheme._();

  /// Light AppBar Theme
  static AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.transparent,
    surfaceTintColor: AppColors.transparent,
    iconTheme: IconThemeData(
        color: AppColors.black, size: 2.57 * SizeConfigs.textMultiplier),
    actionsIconTheme: IconThemeData(
        color: AppColors.black, size: 2.57 * SizeConfigs.textMultiplier),
    titleTextStyle: TextStyle(
        fontSize: 1.93 * SizeConfigs.textMultiplier,
        fontWeight: FontWeight.w600,
        color: AppColors.black),
  );

  /// Dark AppBar Theme
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: AppColors.transparent,
    surfaceTintColor: AppColors.transparent,
    iconTheme: IconThemeData(
        color: AppColors.white, size: 2.57 * SizeConfigs.textMultiplier),
    actionsIconTheme: IconThemeData(
        color: AppColors.white, size: 2.57 * SizeConfigs.textMultiplier),
    titleTextStyle: TextStyle(
        fontSize: 1.93 * SizeConfigs.textMultiplier,
        fontWeight: FontWeight.w600,
        color: AppColors.white),
  );
}

import 'package:flutter/material.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';

class AppTextFieldTheme {
  AppTextFieldTheme._();

  /// Light TextFieldTheme
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    contentPadding:
        EdgeInsets.symmetric(vertical: 2.15 * SizeConfigs.heightMultiplier),
    errorMaxLines: 2,
    prefixIconColor: AppColors.black,
    suffixIconColor: AppColors.black,
    labelStyle: const TextStyle().copyWith(
        fontSize: 1.5 * (SizeConfigs.heightMultiplier),
        color: AppColors.lightLabelColor,
        fontWeight: FontWeight.normal),
    hintStyle: const TextStyle().copyWith(
        fontSize: 1.5 * (SizeConfigs.heightMultiplier),
        color: AppColors.lightLabelColor,
        fontWeight: FontWeight.normal),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle()
        .copyWith(color: AppColors.lightLabelColor),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(1.5 * (SizeConfigs.heightMultiplier)),
      borderSide: BorderSide(width: 1, color: AppColors.darkContainerColor),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(1.5 * (SizeConfigs.heightMultiplier)),
      borderSide: BorderSide(width: 1, color: AppColors.darkContainerColor),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(1.5 * (SizeConfigs.heightMultiplier)),
      borderSide: BorderSide(width: 1, color: AppColors.darkContainerColor),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(1.5 * (SizeConfigs.heightMultiplier)),
      borderSide: const BorderSide(width: 1, color: AppColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(1.5 * (SizeConfigs.heightMultiplier)),
      borderSide: const BorderSide(width: 2, color: AppColors.warning),
    ),
  );

  /// Dark TextField Theme
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    contentPadding:
        EdgeInsets.symmetric(vertical: 2.15 * SizeConfigs.heightMultiplier),
    errorMaxLines: 2,
    prefixIconColor: AppColors.grey,
    suffixIconColor: AppColors.grey,
    labelStyle: const TextStyle().copyWith(
        fontSize: 1.5 * (SizeConfigs.heightMultiplier),
        color: AppColors.darkLabelColor),
    hintStyle: const TextStyle().copyWith(
        fontSize: 1.5 * (SizeConfigs.heightMultiplier),
        color: AppColors.darkLabelColor),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: AppColors.grey.withOpacity(0.5)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(1.5 * (SizeConfigs.heightMultiplier)),
      borderSide: const BorderSide(width: 1, color: AppColors.grey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(1.5 * (SizeConfigs.heightMultiplier)),
      borderSide: const BorderSide(width: 1, color: AppColors.grey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(1.5 * (SizeConfigs.heightMultiplier)),
      borderSide: const BorderSide(width: 1, color: AppColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(1.5 * (SizeConfigs.heightMultiplier)),
      borderSide: const BorderSide(width: 1, color: AppColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(1.5 * (SizeConfigs.heightMultiplier)),
      borderSide: const BorderSide(width: 2, color: AppColors.warning),
    ),
  );
}

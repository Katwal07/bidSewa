import 'package:flutter/material.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';

class AppTextTheme {
  AppTextTheme._();

  ///Light TextTheme
  static TextTheme lightTextTheme = TextTheme(
    /// Headline Text
    headlineLarge: const TextStyle().copyWith(
        fontSize: 3.4 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.bold,
        color: AppColors.lightFontColor,
        fontFamily: "Poppins",
      ),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 2.5 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w500,
        color: AppColors.lightFontColor,
        fontFamily: "Poppins",
      ),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 1.9 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w500,
        color: AppColors.lightFontColor,
        fontFamily: "Poppins",
      ),

    /// Title Text
    titleLarge: const TextStyle().copyWith(
        fontSize: 1.7 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w600,
        color: AppColors.lightFontColor,
        fontFamily: "Poppins",
      ),
    titleMedium: const TextStyle().copyWith(
        fontSize: 1.7 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w500,
        color: AppColors.lightFontColor,
        fontFamily: "Poppins",
      ),
    titleSmall: const TextStyle().copyWith(
        fontSize: 1.7 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w400,
        color: AppColors.lightFontColor,
        fontFamily: "Poppins",
      ),

    /// Body Text
    bodyLarge: const TextStyle().copyWith(
        fontSize: 1.5 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w500,
        color: AppColors.lightFontColor,
        fontFamily: "Poppins",
      ),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 1.5 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.normal,
        color: AppColors.lightFontColor,
        fontFamily: "Poppins",
      ),
    bodySmall: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        color: AppColors.lightFontColor,
        fontFamily: "Poppins",
      ),

    /// Label Text
    labelLarge: const TextStyle().copyWith(
        fontSize: 1.3 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.normal,
        color: AppColors.lightLabelColor,
        fontFamily: "Poppins",
      ),
    labelSmall: const TextStyle().copyWith(
        fontSize: 1.3 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.normal,
        color: AppColors.lightLabelColor,
        fontFamily: "Poppins",
      ),
  );

  /// Dark TextTheme
  static TextTheme darkTextTheme = TextTheme(
    /// Headline Text
    headlineLarge: const TextStyle().copyWith(
        fontSize: 3.4 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.bold,
        color: AppColors.darkFontColor,
        fontFamily: "Poppins",
      ),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 2.5 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w600,
        color: AppColors.darkFontColor,
        fontFamily: "Poppins",
      ),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 1.9 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w500,
        color: AppColors.darkFontColor,
        fontFamily: "Poppins"
      ),

    /// Title Text
    titleLarge: const TextStyle().copyWith(
        fontSize: 1.7 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w600,
        color: AppColors.darkFontColor,
        fontFamily: "Poppins",
      ),
    titleMedium: const TextStyle().copyWith(
        fontSize: 1.7 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w500,
        color: AppColors.darkFontColor,
        fontFamily: "Poppins",
      ),
    titleSmall: const TextStyle().copyWith(
        fontSize: 1.7 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w400,
        color: AppColors.darkFontColor,
        fontFamily: "Poppins",
      ),

    /// Body Text
    bodyLarge: const TextStyle().copyWith(
        fontSize: 1.5 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w500,
        color: AppColors.darkFontColor,
        fontFamily: "Poppins",
      ),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 1.5 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.normal,
        color: AppColors.darkFontColor,
        fontFamily: "Poppins",
      ),
    bodySmall: const TextStyle().copyWith(
        fontSize: 1.5 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.w500,
        color: AppColors.darkFontColor,
        fontFamily: "Poppins",
      ),

    /// Label Text
    labelLarge: const TextStyle().copyWith(
        fontSize: 1.3 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.normal,
        color: AppColors.darkLabelColor,
        fontFamily: "Poppins",
      ),
    labelSmall: const TextStyle().copyWith(
        fontSize: 1.3 * (SizeConfigs.textMultiplier),
        fontWeight: FontWeight.normal,
        color: AppColors.darkLabelColor,
        fontFamily: "Poppins",
      ),
  );
}

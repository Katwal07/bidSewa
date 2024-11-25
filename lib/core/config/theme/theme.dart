import 'package:flutter/material.dart';

import 'colors.dart';
import 'custome_theme/app_bar_theme.dart';
import 'custome_theme/check_box_theme.dart';
import 'custome_theme/elevated_button_theme.dart';
import 'custome_theme/text_field_theme.dart';
import 'custome_theme/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    textTheme: AppTextTheme.lightTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: AppAppBarTheme.lightAppBarTheme,
    checkboxTheme: AppCheckBoxTheme.lightCheckBoxTheme,
    inputDecorationTheme: AppTextFieldTheme.lightInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.lightPrimaryColor,
    scaffoldBackgroundColor: Colors.black,
    textTheme: AppTextTheme.darkTextTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: AppAppBarTheme.darkAppBarTheme,
    checkboxTheme: AppCheckBoxTheme.darkCheckBoxTheme,
    inputDecorationTheme: AppTextFieldTheme.darkInputDecorationTheme,
  );
}
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Light Color Theme
  static Color lightPrimaryColor = const Color(0XFF8E6CEF);
  static Color lightBgColor = const Color(0XFFFFFFFF);
  static Color lightContainerColor = const Color(0XFFF4F4F4);
  static Color lightFontColor = const Color(0XFF272727);
  static Color lightLabelColor = const Color(0XFF272727);

  /// Dark Color Theme
  static Color darkPrimaryColor = const Color(0XFF8E6CEF);
  static Color darkBgColor = const Color(0XFF1D182A);
  static Color darkContainerColor = const Color(0XFF342F3F);
  static Color darkFontColor = const Color(0XFFFFFFFF);
  static Color darkLabelColor = const Color(0XFFFFFFFF).withOpacity(0.5);

  // Button Background Color
  static const Color buttonPrimary = Color(0xFF8E6CEF);
  static const Color buttonSecondary = Color(0xFF7C7570);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // Button Border Color
  static const Color borderPrimary = Color(0xFF8E6CEF);

  //Error and Validation Color
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  //Natural Shade
  static const Color black = Color(0xFF000000);
  static const Color darkerGrey = Color(0xFF4f4f4f);
  static const Color darkgrey = Color(0xFF939393);
  static const Color grey = Color(0xFFe0e0e0);
  static const Color softGrey = Color(0xFFf4f4f4);
  static const Color lightGrey = Color(0xFFf9f9f9);
  static const Color white = Color(0xFFffffff);
  static const Color transparent = Colors.transparent;
}

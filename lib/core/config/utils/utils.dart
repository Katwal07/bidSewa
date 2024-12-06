import 'package:flutter/material.dart';

class AppUtils{
  static bool isDarkTheme(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }
}
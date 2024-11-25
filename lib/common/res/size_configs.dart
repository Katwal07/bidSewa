import 'package:flutter/material.dart';

class SizeConfigs {
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;

  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late double widthMultiplier;
  static late double heightMultiplier;

  void init(BoxConstraints constraints, Orientation orientation) {
    _screenWidth = constraints.maxWidth;
    _screenHeight = constraints.maxHeight;

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    debugPrint("Block Width: $_blockWidth");
    debugPrint("Block Height: $_blockHeight");
  }
}

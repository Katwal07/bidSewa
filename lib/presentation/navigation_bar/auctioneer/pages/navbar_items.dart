import 'package:flutter/material.dart';
import 'package:nepa_bid/common/res/size_configs.dart';

List<NavigationDestination> bottomNavigationBarItems = [
  NavigationDestination(
    label: 'Home',
    icon: Icon(
      Icons.home_outlined,
      size: 6 * SizeConfigs.imageSizeMultiplier,
    ),
    selectedIcon: Icon(
      Icons.home,
      size: 6 * SizeConfigs.imageSizeMultiplier,
    ),
  ),
  NavigationDestination(
    label: 'Add',
    icon: Icon(
      Icons.add_outlined,
      size: 6 * SizeConfigs.imageSizeMultiplier,
    ),
    selectedIcon: Icon(
      Icons.add,
      size: 6 * SizeConfigs.imageSizeMultiplier,
    ),
  ),
  NavigationDestination(
    label: 'Profile',
    icon: Icon(
      Icons.person_2_outlined,
      size: 6 * SizeConfigs.imageSizeMultiplier,
    ),
    selectedIcon: Icon(
      Icons.person,
      size: 6 * SizeConfigs.imageSizeMultiplier,
    ),
  )
];

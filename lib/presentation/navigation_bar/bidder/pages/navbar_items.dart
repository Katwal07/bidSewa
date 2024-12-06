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
    label: 'search',
    icon: Icon(
      Icons.search_outlined,
      size: 6 * SizeConfigs.imageSizeMultiplier,
    ),
    selectedIcon: Icon(
      Icons.search,
      size: 6 * SizeConfigs.imageSizeMultiplier,
    ),
  ),
   NavigationDestination(
    label: 'wishlist',
    icon: Icon(
      Icons.favorite_outline,
      size: 6 * SizeConfigs.imageSizeMultiplier,
    ),
    selectedIcon: Icon(
      Icons.favorite,
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

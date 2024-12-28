import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import '../../res/size_configs.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color darkStatusBarColor;
  final Color lightStatusBarColor;
  final IconData? icon;
  final double? kCustomToolBarheight;
  final List<Widget>? actions;
  final Brightness? statusBarBrightness;

  const CustomAppBar({
    super.key,
    this.title,
    required this.darkStatusBarColor,
    required this.lightStatusBarColor,
    this.icon,
    this.kCustomToolBarheight,
    this.actions,
    this.statusBarBrightness,
  });
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:
                isDarkTheme ? darkStatusBarColor : lightStatusBarColor,
            statusBarIconBrightness:
                isDarkTheme ? Brightness.light : Brightness.dark,
            statusBarBrightness: statusBarBrightness ??
                (isDarkTheme ? Brightness.dark : Brightness.light)),
        automaticallyImplyLeading: false,
        title: Text(
          title ?? "",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        leading: icon == null
            ? null
            : GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  icon,
                  size: 6 * SizeConfigs.imageSizeMultiplier,
                ),
              ),
        actions: actions);
  }

  @override
  Size get preferredSize => Size.fromHeight(
      kCustomToolBarheight == null ? kToolbarHeight : kCustomToolBarheight!);
}

import 'package:flutter/material.dart';
import '../../../core/config/theme/colors.dart';
import '../../res/size_configs.dart';

class CustomSnackBar {
  static showCustomSnackBar(
      BuildContext context, Color containerColor, String snackBarText) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.transparent,
      duration: const Duration(seconds: 3),
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 3.1 * SizeConfigs.widthMultiplier,
                right: 0.5 * SizeConfigs.widthMultiplier),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.all(
                Radius.circular(1.86 * SizeConfigs.widthMultiplier),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    snackBarText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

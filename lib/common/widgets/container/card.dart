import 'package:flutter/material.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import '../../../core/config/theme/colors.dart';
import '../../res/size_configs.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.currentBid,
  });
  final String imageUrl;
  final String title;
  final int currentBid;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkTheme
              ? AppColors.darkContainerColor
              : AppColors.lightContainerColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: SizeConfigs.widthMultiplier * 50,
                height: SizeConfigs.heightMultiplier * 18.4,
                decoration: BoxDecoration(
                  color: isDarkTheme ? AppColors.darkContainerColor : AppColors.lightContainerColor,
                ),
                child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl))
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: isDarkTheme
                    ? AppColors.darkContainerColor
                    : AppColors.lightContainerColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.8 * SizeConfigs.heightMultiplier,
                  vertical: 1.07 * SizeConfigs.heightMultiplier,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Rs.$currentBid",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: AppColors.borderPrimary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

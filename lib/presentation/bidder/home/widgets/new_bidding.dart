import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nepa_bid/core/config/assets/app_vectors.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';

import '../../../../common/res/size_configs.dart';

class NewBiddingSection extends StatelessWidget {
  const NewBiddingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopBiddingHeading(context),
        _buildSpacing(),
        _buildTopBidding(context),
      ],
    );
  }

  Widget _buildSpacing() {
    return SizedBox(
      height: 0.1 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildTopBiddingHeading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "News In",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "See All",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildTopBidding(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return SizedBox(
      height: 30.26 * SizeConfigs.heightMultiplier,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: 41.86 * SizeConfigs.widthMultiplier,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 23.60 * SizeConfigs.heightMultiplier,
                      width: 41.86 * SizeConfigs.widthMultiplier,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(ComponentsSizes.borderRadiusMd),
                          topRight:
                              Radius.circular(ComponentsSizes.borderRadiusMd),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(ComponentsSizes.borderRadiusMd),
                          topRight:
                              Radius.circular(ComponentsSizes.borderRadiusMd),
                        ),
                        child: const Image(
                          image: AssetImage(
                            "assets/images/sample.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.54 * SizeConfigs.heightMultiplier,
                      right: 2.32 * SizeConfigs.widthMultiplier,
                      child: GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                            height: 2.15 * SizeConfigs.heightMultiplier,
                            width: 4.56 * SizeConfigs.widthMultiplier,
                            AppVectors.wishlist),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 6.44 * SizeConfigs.heightMultiplier,
                  width: 41.86 * SizeConfigs.widthMultiplier,
                  decoration: BoxDecoration(
                    color: isDarkTheme
                        ? AppColors.darkContainerColor
                        : AppColors.lightContainerColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(ComponentsSizes.borderRadiusMd),
                      bottomRight:
                          Radius.circular(ComponentsSizes.borderRadiusMd),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: ComponentsSizes.sm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Men's Harrington jacket",
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Rs.148.00",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 2 * SizeConfigs.heightMultiplier,
        ),
        itemCount: 10,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';

import '../../../../common/res/size_configs.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ComponentsSizes.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSpacing2(),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDarkTheme
                      ? AppColors.darkContainerColor
                      : AppColors.lightContainerColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ComponentsSizes.horizontalPadding,
                      vertical: ComponentsSizes.defaultSpace),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context,
                                  AppRoutesName.addPostDetailsAuctionner);
                            },
                            icon: const Icon(
                              Icons.post_add,
                              size: 32,
                            )),
                      ),
                      Text(
                        "Add Product",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  _buildSpacing1(),
                  _buildTopMyAuctionHeading(context),
                  _buildSpacing(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpacing() {
    return SizedBox(
      height: 0.1 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildSpacing1() {
    return SizedBox(
      height: 1 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildSpacing2() {
    return SizedBox(
      height: 2 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildTopMyAuctionHeading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "My Auctions",
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
}

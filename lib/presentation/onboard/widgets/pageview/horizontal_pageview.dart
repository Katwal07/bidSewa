import 'package:flutter/material.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/core/constant/sizes.dart';

class HorizontalPageView extends StatelessWidget {
  const HorizontalPageView({
    super.key,
    required this.image,
    required this.titleDesc,
    required this.subTitleDesc,
  });

  final String image;
  final String titleDesc;
  final String subTitleDesc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: ComponentsSizes.defaultSpace * 2,
        ),

        /// OnBoarding Image
        _onboardImage(),
        SizedBox(
          height: ComponentsSizes.spaceBtwSection,
        ),

        /// OnBoarding Title
        _onboardTitle(context),
        SizedBox(
          height: ComponentsSizes.spaceBtwItems,
        ),

        /// OnBoarding SubTitle
        _onboardSubTitle(context),
      ],
    );
  }

  Widget _onboardImage() {
    return Image.asset(
      image,
      height: 43 * SizeConfigs.heightMultiplier,
      width: 93 * SizeConfigs.widthMultiplier,
    );
  }

  Widget _onboardTitle(BuildContext context) {
    return Text(
      titleDesc,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _onboardSubTitle(BuildContext context) {
    return Text(
      subTitleDesc,
      style: Theme.of(context).textTheme.bodySmall,
      textAlign: TextAlign.center,
    );
  }
}

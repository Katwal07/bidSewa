import 'package:flutter/material.dart';
import '../../../../../core/config/theme/colors.dart';
import '../../../../../core/constant/sizes.dart';
import '../add/image.dart';
import '../add/video.dart';

class TopSizedBox2 extends StatelessWidget {
  const TopSizedBox2({
    super.key,
    required this.isDarkTheme,
    required this.startingBidCon,
  });

  final bool isDarkTheme;
  final TextEditingController startingBidCon;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.48,
      child: Container(
        decoration: BoxDecoration(
          color: isDarkTheme
              ? AppColors.darkContainerColor
              : AppColors.lightContainerColor,
          borderRadius: BorderRadius.circular(
            ComponentsSizes.productItemRadius,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: ComponentsSizes.defaultSpace / 2,
                right: ComponentsSizes.defaultSpace / 2,
                top: ComponentsSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Add Starting Bid
                      _buildTextFieldName(context),
                      _buildTextField(context),
                      _divider(),

                      /// Add Product Image
                      const AddProductImage(),

                      _divider(),

                      /// Add Product Video
                      const AddProductVideo(),

                      _divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return const Divider(
      color: AppColors.darkgrey,
      thickness: 0.5,
      indent: 0,
      endIndent: 0,
    );
  }

  Widget _buildTextFieldName(BuildContext context) {
    return Text(
      "Starting Bid",
      style: Theme.of(context).textTheme.titleMedium,
    );
  }

  Widget _buildTextField(BuildContext context) {
    return TextField(
      controller: startingBidCon,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: "set starting bid",
          hintStyle: Theme.of(context).textTheme.labelSmall,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none),
    );
  }
}

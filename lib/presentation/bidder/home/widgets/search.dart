import 'package:flutter/material.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import '../../../../common/res/size_configs.dart';
import '../../../../core/config/theme/colors.dart';
import '../../../../core/config/utils/utils.dart';
import '../../../../core/constant/sizes.dart';

class SearchBarContainer extends StatelessWidget {
  const SearchBarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return GestureDetector(
      onTap: (){

        Navigator.pushNamed(context, AppRoutesName.searchPage);
      },
      child: Container(
        height: 6.44 * SizeConfigs.heightMultiplier,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkTheme ? AppColors.darkContainerColor : AppColors.lightContainerColor,
          borderRadius: BorderRadius.all(Radius.circular(ComponentsSizes.borderRadiusLg))
        ),
        child: Row(
          children: [
            SizedBox(width: 2.32 * SizeConfigs.widthMultiplier,),
            const Icon(Icons.search_outlined),
            SizedBox(width: 2.32 * SizeConfigs.widthMultiplier,),
            Text("Search", style: Theme.of(context).textTheme.labelLarge,)
          ],
        ),
      ),
    );
  }
}

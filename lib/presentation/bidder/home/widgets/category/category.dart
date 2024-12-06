import 'package:flutter/material.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';

import '../../../../../common/res/size_configs.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCategoryHeading(context),
        _buildSpacing(),
        _buildCategories(),
      ],
    );
  }

  Widget _buildSpacing() {
    return SizedBox(
      height: 0.1 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildCategoryHeading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Categories",style: Theme.of(context).textTheme.titleLarge,),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutesName.seeAllCategory);
          },
          child: Text("See All",style: Theme.of(context).textTheme.titleSmall,),
        ),
      ],
    );
  }
  
  Widget _buildCategories() {
    return SizedBox(
      height: 11 * SizeConfigs.heightMultiplier,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index){
          return Column(
            children: [
              CircleAvatar(
                radius: 8 *SizeConfigs.imageSizeMultiplier,
              ),
              SizedBox(height: 0.54 * SizeConfigs.heightMultiplier,),
              Text("Hoodies",style: Theme.of(context).textTheme.bodyMedium,),
            ],
          );
        }, 
        separatorBuilder: (BuildContext context, int index) => SizedBox(width: 2 * SizeConfigs.heightMultiplier,), 
        itemCount: 10,
      ),
    );
  }
}

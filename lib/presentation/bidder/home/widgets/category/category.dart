import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/bloc/search_bloc/search_cubit.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/domain/bidder/entity/category_name.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_category_usecase.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_search_items_usecase.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../../common/res/size_configs.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..execute(sl<GetSearchItemsUsecase>()),
      child: BlocProvider(
        create: (context) => GenericCubit()..execute(sl<GetCategoryUsecase>()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryHeading(context),
            _buildSpacing(),
            _buildCategories(),
          ],
        ),
      ),
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
        Text(
          "Categories",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutesName.seeAllCategory);
          },
          child: Text(
            "See All",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return BlocBuilder<GenericCubit, GenericState>(
      builder: (context, state) {
        if (state is DataLoaded) {
          return SizedBox(
            height: 11 * SizeConfigs.heightMultiplier,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                CategoryNameEntity categoryNameEntity = CategoryNameEntity(name: state.data[index].name);
                return GestureDetector(
                  onTap: ()=> Navigator.pushNamed(context, AppRoutesName.categoryBasedItems, arguments: categoryNameEntity,),
                  child: Column(
                    children: [
                      ClipOval(
                        child: CircleAvatar(
                          radius: 8 * SizeConfigs.imageSizeMultiplier,
                          backgroundColor: AppColors.transparent,
                          child: Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(state.data[index].image.url)),
                        ),
                      ),
                      SizedBox(
                        height: 0.54 * SizeConfigs.heightMultiplier,
                      ),
                      Text(
                        state.data[index].name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                width: 2 * SizeConfigs.heightMultiplier,
              ),
              itemCount: state.data.length,
            ),
          );
        }
        if (state is DataFailure) {
          return Text("Failure: ${state.errorMessage}");
        }
        return const SizedBox.shrink();
      },
    );
  }
}

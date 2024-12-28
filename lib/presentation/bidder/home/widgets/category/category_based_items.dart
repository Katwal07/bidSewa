import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/search_bloc/search_cubit.dart';
import 'package:nepa_bid/common/bloc/search_bloc/search_state.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/domain/bidder/entity/category_name.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_search_items_usecase.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../../../common/res/size_configs.dart';
import '../../../../../common/widgets/container/card.dart';
import '../../../../../core/config/theme/colors.dart';
import '../../../../../core/config/utils/utils.dart';

class CategoryBasedItems extends StatelessWidget {
  const CategoryBasedItems({super.key, required this.categoryName});
  final CategoryNameEntity categoryName;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return BlocProvider(
      create: (context) => SearchCubit()..execute(sl<GetSearchItemsUsecase>(), params1: "category", params2: categoryName.name),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: true,
            title: Text(categoryName.name, style: Theme.of(context).textTheme.headlineSmall,),
            leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: ()=> Navigator.pop(context),
                child: Container(
                      decoration: BoxDecoration(
                        color: isDarkTheme
                            ? AppColors.darkContainerColor
                            : AppColors.lightContainerColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 26,
                      ),
                    ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: ComponentsSizes.horizontalPadding),
          child: BlocBuilder<SearchCubit, SearchItemState>(
              builder: (context, state) {
            if (state is SearchLoadedState) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.72 * SizeConfigs.heightMultiplier,
                  crossAxisSpacing: 4.72 * SizeConfigs.widthMultiplier,
                  childAspectRatio: (30.2 * SizeConfigs.widthMultiplier) /
                      (18.7 * SizeConfigs.heightMultiplier),
                ),
                itemBuilder: (context, index) {
                  return CustomCard(
                    imageUrl: state.data[index].images[0].url!,
                    title: state.data[index].title!,
                    currentBid: state.data[index].currentBid!,
                  );
                },
                itemCount: state.data.length,
              );
            }
            return const SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/search_bloc/search_cubit.dart';
import 'package:nepa_bid/common/widgets/container/card.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/core/network/network_const/api_endpoint_urls.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_search_items_usecase.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../../common/bloc/search_bloc/search_state.dart';
import '../../../../common/res/size_configs.dart';

class SearchPageNav extends StatelessWidget {
  const SearchPageNav({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return Scaffold(
      backgroundColor: isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.44 * SizeConfigs.heightMultiplier),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              height: 4.83 * SizeConfigs.heightMultiplier,
              width: double.infinity,
              child: TextField(
                onChanged: (value) {
                  context.read<SearchCubit>().execute(
                        sl<GetSearchItemsUsecase>(),
                        params1: ApiEndpointUrls.searchKeyword,
                        params2: value,
                      );
                },
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: Theme.of(context).textTheme.labelLarge,
                  filled: true,
                  fillColor: isDarkTheme
                      ? AppColors.darkContainerColor
                      : AppColors.lightContainerColor,
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 26,
                  ),
                  suffixIcon: const Icon(
                    Icons.clear,
                    size: 18,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ComponentsSizes.horizontalPadding,
            vertical: ComponentsSizes.defaultSpace * 2),
        child: BlocBuilder<SearchCubit, SearchItemState>(
          builder: (context, state) {
            if (state is SearchInitialState) {
              
            }
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
          },
        ),
      )),
    );
  }
}

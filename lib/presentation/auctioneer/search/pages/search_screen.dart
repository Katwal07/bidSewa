import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/bloc/search_bloc/search_cubit.dart';
import '../../../../common/bloc/search_bloc/search_state.dart';
import '../../../../common/res/size_configs.dart';
import '../../../../core/config/theme/colors.dart';
import '../../../../core/config/utils/utils.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../core/network/network_const/api_endpoint_urls.dart';
import '../../../../domain/bidder/usecases/get_search_items_usecase.dart';
import '../../../../service_locator.dart';
import '../widgets/grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(6.44 * SizeConfigs.heightMultiplier),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:
                isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
            statusBarIconBrightness:
                isDarkTheme ? Brightness.light : Brightness.dark,
            statusBarBrightness:
                isDarkTheme ? Brightness.dark : Brightness.light,
          ),
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
              return GridViewForSearch(
                hasMore: state.hasMore,
                state: state,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      )),
    );
  }
}

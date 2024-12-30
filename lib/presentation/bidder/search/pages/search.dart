import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_category_usecase.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../common/widgets/appbar/appbar.dart';

class SearchPageBidder extends StatelessWidget {
  const SearchPageBidder({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return BlocProvider(
      create: (context) => GenericCubit()..execute(sl<GetCategoryUsecase>()),
      child: Scaffold(
        backgroundColor:
            isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        appBar: CustomAppBar(
          darkStatusBarColor: AppColors.darkBgColor,
          lightStatusBarColor: AppColors.lightBgColor,
          icon: Icons.arrow_back,
          prefixIcon: Icons.search,
          kCustomToolBarheight: 50,
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ComponentsSizes.horizontalPadding,
              vertical: ComponentsSizes.defaultSpace * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shop by Categories",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: BlocBuilder<GenericCubit, GenericState>(
                  builder: (context, state) {
                    if (state is DataLoaded) {
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: isDarkTheme
                                  ? AppColors.darkContainerColor
                                  : AppColors.lightContainerColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                ClipOval(
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 30,
                                    child: Image(
                                      image: NetworkImage(state.data[index].image.url),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  state.data[index].name,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: state.data.length,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

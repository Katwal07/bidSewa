import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/domain/bidder/entity/item_entity.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_top_bidd_usecase.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../common/res/size_configs.dart';

class TopBiddingSection extends StatelessWidget {
  const TopBiddingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenericCubit()..execute(sl<GetTopBiddUsecase>()),
      child: Column(
        children: [
          _buildTopBiddingHeading(context),
          _buildSpacing(),
          _buildTopBidding(context),
        ],
      ),
    );
  }

  Widget _buildSpacing() {
    return SizedBox(
      height: 0.1 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildTopBiddingHeading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Top Bidding",
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

  Widget _buildTopBidding(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return BlocBuilder<GenericCubit, GenericState>(builder: (context, state) {
      if (state is DataLoaded) {
        return SizedBox(
          height: 30.26 * SizeConfigs.heightMultiplier,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 41.86 * SizeConfigs.widthMultiplier,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 23.60 * SizeConfigs.heightMultiplier,
                      width: 41.86 * SizeConfigs.widthMultiplier,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(ComponentsSizes.borderRadiusMd),
                          topRight:
                              Radius.circular(ComponentsSizes.borderRadiusMd),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutesName.detailsPage,
                            arguments: ItemEntity(
                              itemId: state.data[index].id,
                              endTime: state.data[index].endTime,
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(ComponentsSizes.borderRadiusMd),
                            topRight:
                                Radius.circular(ComponentsSizes.borderRadiusMd),
                          ),
                          child: Image(
                            image: NetworkImage(
                              state.data[index].images[0].url,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 6.44 * SizeConfigs.heightMultiplier,
                      width: 41.86 * SizeConfigs.widthMultiplier,
                      decoration: BoxDecoration(
                        color: isDarkTheme
                            ? AppColors.darkContainerColor
                            : AppColors.lightContainerColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(ComponentsSizes.borderRadiusMd),
                          bottomRight:
                              Radius.circular(ComponentsSizes.borderRadiusMd),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: ComponentsSizes.sm),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.data[index].title,
                              style: Theme.of(context).textTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Rs.${state.data[index].currentBid}",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(
              width: 2 * SizeConfigs.heightMultiplier,
            ),
            itemCount: 10,
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

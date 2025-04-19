import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/core/constant/text_string.dart';
import 'package:nepa_bid/domain/bidder/entity/item_entity.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_bid_by_bidder_id_usecase.dart';
import 'package:nepa_bid/service_locator.dart';
import '../../../../common/bloc/generic_bloc/generic_state.dart';

class BidPageBidder extends StatelessWidget {
  const BidPageBidder({super.key, required this.bidderId});
  final String bidderId;

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GenericCubit()
            ..execute(sl<GetBidByBidderIdUsecase>(), params: bidderId),
        ),
      ],
      child: Scaffold(
        backgroundColor:
            isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(
            left: ComponentsSizes.horizontalPadding,
            right: ComponentsSizes.horizontalPadding,
            top: 2.1 * SizeConfigs.heightMultiplier,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4.3 * SizeConfigs.heightMultiplier,
            children: [
              _myBidsTitle(context),
              _myBids(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _myBidsTitle(BuildContext context) {
    return Text(
      AppStrings.bidHistry,
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _myBids(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return SizedBox(
      height: 70 * SizeConfigs.heightMultiplier,
      child: BlocBuilder<GenericCubit, GenericState>(
        builder: (context, state) {
          if (state is DataLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutesName.detailsPage,
                    arguments: ItemEntity(
                      itemId: state.data[index].auctionItem.id,
                      endTime: state.data[index].auctionItem.endTime,
                    ),
                  ),
                  child: Container(
                    height: 10.73 * SizeConfigs.heightMultiplier,
                    decoration: BoxDecoration(
                      color: isDarkTheme
                          ? AppColors.darkContainerColor
                          : AppColors.lightContainerColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(2.32 * SizeConfigs.widthMultiplier),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.32 * SizeConfigs.widthMultiplier),
                      child: Row(
                        spacing: 4.65 * SizeConfigs.widthMultiplier,
                        children: [
                          _profileImage(state.data[index].bidder.profileImage),
                          Expanded(
                            child: _bidDetails(
                              context,
                              state.data[index].auctionItem.title,
                              state.data[index].auctionItem.description,
                              state.data[index].auctionItem.currentBid,
                              state.data[index].amount,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, height) => SizedBox(
                height: 2.14 * SizeConfigs.heightMultiplier,
              ),
              itemCount: state.data.length,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _profileImage(String imageUrl) {
    return ClipOval(
      child: CircleAvatar(
        radius: 9.30 * SizeConfigs.imageSizeMultiplier,
        child: Image(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _bidDetails(
      BuildContext context, String title, String des, int curBid, int myBid) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          des,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "Current Bid: $curBid",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          "Your Bid: $myBid",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: AppColors.lightPrimaryColor),
        ),
      ],
    );
  }
}

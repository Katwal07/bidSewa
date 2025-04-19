import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/widgets/container/card.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/get_my_auction_item_usecase.dart';
import 'package:nepa_bid/presentation/auctioneer/post/bloc/my_auction_item_bloc/my_auction_item_bloc.dart';
import 'package:nepa_bid/presentation/auctioneer/post/bloc/my_auction_item_bloc/my_auction_item_event.dart';
import 'package:nepa_bid/service_locator.dart';
import '../../../../common/res/size_configs.dart';
import '../bloc/my_auction_item_bloc/my_auction_item_state.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return SafeArea(
      child: BlocProvider(
        create: (context) => MyAuctionItemBloc(),
        child: Scaffold(
          backgroundColor:
              isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
          body: LayoutBuilder(builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ComponentsSizes.horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSpacing2(),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDarkTheme
                          ? AppColors.darkContainerColor
                          : AppColors.lightContainerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ComponentsSizes.horizontalPadding,
                          vertical: ComponentsSizes.defaultSpace),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context,
                                      AppRoutesName.addPostDetailsAuctionner);
                                },
                                icon: const Icon(
                                  Icons.post_add,
                                  size: 32,
                                )),
                          ),
                          Text(
                            "Add Product",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildSpacing1(),
                  _buildTopMyAuctionHeading(context),
                  _buildSpacing(),
                  Expanded(
                    child: BlocBuilder<MyAuctionItemBloc, MyAuctionItemState>(
                      builder: (context, state) {
                        if (state is MyAuctionItemInitialState) {
                          context.read<MyAuctionItemBloc>().add(
                                MyAuctionItemFetchedEvent(
                                  usecase: sl<GetMyAuctionItemUsecase>(),
                                ),
                              );
                        }
                        if (state is MyAuctionItemLoadedState) {
                          return _buildMyAuctionItems(state);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSpacing() {
    return SizedBox(
      height: 0.1 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildSpacing1() {
    return SizedBox(
      height: 1 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildSpacing2() {
    return SizedBox(
      height: 2 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildTopMyAuctionHeading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "My Auctions",
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

  Widget _buildMyAuctionItems(MyAuctionItemLoadedState state) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: state.entity.auctions.length,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 1.72 * SizeConfigs.heightMultiplier,
        crossAxisSpacing: 4.72 * SizeConfigs.widthMultiplier,
        childAspectRatio: (30.2 * SizeConfigs.widthMultiplier) /
            (18.7 * SizeConfigs.heightMultiplier),
      ),
      itemBuilder: (context, index) {
        return CustomCard(
          imageUrl: state.entity.auctions[index].images[0].url ?? '',
          title: state.entity.auctions[index].title ?? '',
          currentBid: state.entity.auctions[index].currentBid ?? 0,
        );
      },
    );
  }
}

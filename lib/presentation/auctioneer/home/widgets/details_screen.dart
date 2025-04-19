import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/domain/bidder/entity/item_entity.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../common/bloc/place_bid/place_bid_cubit.dart';
import '../../../../common/bloc/place_bid/place_bid_state.dart';
import '../../../../common/bloc/timer_bloc/timer_cubit.dart';
import '../../../../common/res/size_configs.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/snackbar/snackbar.dart' show CustomSnackBar;
import '../../../../core/config/theme/colors.dart';
import '../../../../core/config/utils/utils.dart';
import '../../../../core/constant/sizes.dart';
import '../../../../domain/bidder/usecases/get_items_details_usecase.dart';
import '../../../../service_locator.dart';
import 'video_player_widget.dart';

class AuctioneerItemsDetailsScreen extends StatelessWidget {
  final ItemEntity itemEntity;
  const AuctioneerItemsDetailsScreen({
    super.key,
    required this.itemEntity,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    final format = DateFormat('yyyy-MM-dd H:mm');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GenericCubit()
            ..execute(
              sl<GetItemsDetailsUsecase>(),
              params: itemEntity.toString(),
            ),
        ),
        BlocProvider(
          create: (context) => TimerCubit(
            endTime: format.parse(itemEntity.endTime!),
          ),
        ),
        BlocProvider(create: (context) => PlaceBidCubit()),
      ],
      child: BlocListener<PlaceBidCubit, PlaceBidState>(
        listener: (context, state) {
          if (state is BidLoaded) {
            CustomSnackBar.showCustomSnackBar(
              context,
              AppColors.borderPrimary,
              state.message,
            );
          }
          if (state is BidFailure) {
            CustomSnackBar.showCustomSnackBar(
              context,
              AppColors.warning,
              state.errorMessage,
            );
          }
        },
        child: Scaffold(
          backgroundColor:
              isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
          appBar: CustomAppBar(
            darkStatusBarColor: AppColors.darkBgColor,
            lightStatusBarColor: AppColors.lightBgColor,
            icon: Icons.arrow_back,
            title: '',
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ComponentsSizes.horizontalPadding,
                vertical: 2.15 * SizeConfigs.heightMultiplier,
              ),
              child: BlocBuilder<GenericCubit, GenericState>(
                builder: (context, state) {
                  if (state is DataLoaded) {
                    final auction = state.data.auction;
                    final images = auction.images;
                    final videos = auction.videos;
                    final mediaLength = images.length + videos.length;

                    return Column(
                      children: [
                        SizedBox(
                          height: 32.2 * SizeConfigs.heightMultiplier,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: mediaLength,
                            separatorBuilder: (context, index) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              if (index < images.length) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    images[index].url,
                                    width: 250,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedBox(
                                    width: SizeConfigs.widthMultiplier * 77,
                                    child: VideoPlayerWidget(
                                      videoUrl: videos[index - images.length].url,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Rs.${auction.currentBid}",
                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                    color: AppColors.lightPrimaryColor,
                                  ),
                            ),
                            BlocBuilder<TimerCubit, Duration>(
                              builder: (context, remainingTime) {
                                if (remainingTime.inSeconds <= 0) {
                                  return const Text(
                                    'Expired',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }

                                final days = remainingTime.inDays;
                                final months = days ~/ 30;
                                final years = days ~/ 365;
                                final hours = remainingTime.inHours % 24;
                                final minutes = remainingTime.inMinutes % 60;
                                final seconds = remainingTime.inSeconds % 60;

                                String timeLeft = '';
                                if (years > 0) timeLeft += '$years years, ';
                                if (months % 12 > 0) timeLeft += '${months % 12} months, ';
                                if (days % 30 > 0) timeLeft += '${days % 30} days, ';

                                timeLeft +=
                                    '${hours.toString().padLeft(2, '0')}:'
                                    '${minutes.toString().padLeft(2, '0')}:'
                                    '${seconds.toString().padLeft(2, '0')}';

                                return Text(
                                  timeLeft,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            auction.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            auction.description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Condition: ${auction.condition}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    );
                  }
                  // Show shimmer while loading
                  return Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 250,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

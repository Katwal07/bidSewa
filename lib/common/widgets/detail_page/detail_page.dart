import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/bloc/place_bid/place_bid_cubit.dart';
import 'package:nepa_bid/common/bloc/timer_bloc/timer_cubit.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/common/widgets/appbar/appbar.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/domain/bidder/entity/item_entity.dart';
import 'package:nepa_bid/domain/bidder/entity/place_bid.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_items_details_usecase.dart';
import 'package:nepa_bid/domain/bidder/usecases/place_bid_usecase.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../bloc/generic_bloc/generic_state.dart';
import '../../bloc/place_bid/place_bid_state.dart';
import '../snackbar/snackbar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.itemEntity});
  final ItemEntity itemEntity;

  @override
  Widget build(BuildContext context) {
    final TextEditingController amountCon = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
              padding: EdgeInsets.only(
                left: ComponentsSizes.horizontalPadding,
                right: ComponentsSizes.horizontalPadding,
                top: 2.15 * SizeConfigs.heightMultiplier,
              ),
              child: BlocBuilder<GenericCubit, GenericState>(
                builder: (context, state) {
                  if (state is DataLoaded) {
                    return Column(
                      spacing: 3.22 * SizeConfigs.heightMultiplier,
                      children: [
                        Container(
                          decoration:
                              const BoxDecoration(color: AppColors.transparent),
                          height: 32.2 * SizeConfigs.heightMultiplier,
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if (state.data.auction.images.length == 1) {
                                return Container(
                                  height: 32.2 * SizeConfigs.heightMultiplier,
                                  width: 70 * SizeConfigs.widthMultiplier,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                        state.data.auction.images[index].url,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4)),
                                  width: 250,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image(
                                      image: NetworkImage(
                                        state.data.auction.images[index].url,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 4.65 * SizeConfigs.widthMultiplier,
                            ),
                            itemCount: state.data.auction.images.length,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 4.65 * SizeConfigs.widthMultiplier,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rs.${state.data.auction.currentBid}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: AppColors.lightPrimaryColor),
                                ),
                                BlocBuilder<TimerCubit, Duration>(
                                  builder: (context, remainingTime) {
                                    final days = remainingTime.inDays;
                                    final month = (days ~/ 30);
                                    final year = (days ~/ 365);
                                    final hour = remainingTime.inHours % 24;
                                    final minute = remainingTime.inMinutes % 60;
                                    final sec = remainingTime.inSeconds % 60;
                                    return Expanded(
                                      child: Text(
                                        '$year years, ${month % 12} months, ${days % 30} days, '
                                        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    );
                                  },
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              state.data.auction.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              state.data.auction.description,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "Condition: ${state.data.auction.condition}",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            BlocBuilder<PlaceBidCubit, PlaceBidState>(
                              builder: (context, state) {
                                if (state is BidInitial) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      context.read<PlaceBidCubit>().onClick();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: Text(
                                        "Place Your Bid",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  );
                                }
                                if (state is ShowState) {
                                  return Column(
                                    children: [
                                      Form(
                                        key: formKey,
                                        child: SizedBox(
                                          width:
                                              28 * SizeConfigs.widthMultiplier,
                                          child: TextField(
                                            controller: amountCon,
                                            decoration: const InputDecoration(
                                              prefixIcon:
                                                  Icon(Icons.assessment),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          context.read<PlaceBidCubit>().execute(
                                                sl<BidderPlaceBidUsecase>(),
                                                params1: PlaceBidEntity(
                                                    amount: int.tryParse(
                                                        amountCon.text)),
                                                params2: itemEntity.itemId,
                                              );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          child: Text(
                                            "Place Your Bid",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    color: AppColors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                if (state is BidLoaded) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      context.read<PlaceBidCubit>().onClick();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: Text(
                                        "Place Your Bid Again",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  );
                                }
                                if (state is BidFailure) {
                                  return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.warning,
                                    ),
                                    onPressed: () {
                                      context.read<PlaceBidCubit>().onClick();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                        "Place Your Bid Again",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

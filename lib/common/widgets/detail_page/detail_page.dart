import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/bloc/place_bid/place_bid_cubit.dart';
import 'package:nepa_bid/common/bloc/timer_bloc/timer_cubit.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/domain/bidder/entity/item_entity.dart';
import 'package:nepa_bid/domain/bidder/entity/place_bid.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_items_details_usecase.dart';
import 'package:nepa_bid/domain/bidder/usecases/place_bid_usecase.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../bloc/generic_bloc/generic_state.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.itemEntity});
  final ItemEntity itemEntity;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _amountCon = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      child: Scaffold(
        backgroundColor:
            isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: ComponentsSizes.horizontalPadding,
                right: ComponentsSizes.horizontalPadding,
                top: 20),
            child: BlocBuilder<GenericCubit, GenericState>(
              builder: (context, state) {
                if (state is DataLoaded) {
                  return Column(
                    spacing: 30,
                    children: [
                      Container(
                        decoration:
                            const BoxDecoration(color: AppColors.transparent),
                        height: 300,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (state.data.auction.images.length == 1) {
                              return Container(
                                height: 300,
                                width: 300,
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
                                        state.data.auction.images[index].url),
                                  ),
                                ),
                              );
                            }
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 20,
                          ),
                          itemCount: state.data.auction.images.length,
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                                    return Text(
                                      '$year years, ${month % 12} months, ${days % 30} days, '
                                      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
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
                            Builder(builder: (context) {
                              return Column(
                                children: [
                                  Form(
                                    key: _formKey,
                                    child: SizedBox(
                                      width: 120,
                                      child: TextField(
                                        controller: _amountCon,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.assessment),
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
                                            params1: PlaceBidEntity(amount: int.tryParse(_amountCon.text)),
                                            params2: itemEntity.itemId,
                                          );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(
                                        "Place Your Bid",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
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
    );
  }
}

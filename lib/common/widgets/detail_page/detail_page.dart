import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/bloc/place_bid/place_bid_cubit.dart';
import 'package:nepa_bid/common/bloc/timer_bloc/timer_cubit.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/common/widgets/appbar/appbar.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/domain/bidder/entity/item_entity.dart';
import 'package:nepa_bid/domain/bidder/entity/place_bid.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_items_details_usecase.dart';
import 'package:nepa_bid/domain/bidder/usecases/place_bid_usecase.dart';
import 'package:nepa_bid/service_locator.dart';
import 'package:shimmer/shimmer.dart';
import '../../../presentation/auctioneer/home/widgets/video_player_widget.dart';
import '../../bloc/generic_bloc/generic_state.dart';
import '../../bloc/place_bid/place_bid_state.dart';
import '../snackbar/snackbar.dart';

// class DetailPage extends StatelessWidget {
//   const DetailPage({super.key, required this.itemEntity});
//   final ItemEntity itemEntity;

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController amountCon = TextEditingController();
//     final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//     final isDarkTheme = AppUtils.isDarkTheme(context);
//     final format = DateFormat('yyyy-MM-dd H:mm');
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => GenericCubit()
//             ..execute(
//               sl<GetItemsDetailsUsecase>(),
//               params: itemEntity.toString(),
//             ),
//         ),
//         BlocProvider(
//           create: (context) => TimerCubit(
//             endTime: format.parse(itemEntity.endTime!),
//           ),
//         ),
//         BlocProvider(create: (context) => PlaceBidCubit()),
//       ],
//       child: BlocListener<PlaceBidCubit, PlaceBidState>(
//         listener: (context, state) {
//           if (state is BidLoaded) {
//             CustomSnackBar.showCustomSnackBar(
//               context,
//               AppColors.borderPrimary,
//               state.message,
//             );
//           }
//           if (state is BidFailure) {
//             CustomSnackBar.showCustomSnackBar(
//               context,
//               AppColors.warning,
//               state.errorMessage,
//             );
//           }
//         },
//         child: Scaffold(
//           backgroundColor:
//               isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
//           appBar: CustomAppBar(
//             darkStatusBarColor: AppColors.darkBgColor,
//             lightStatusBarColor: AppColors.lightBgColor,
//             icon: Icons.arrow_back,
//             title: '',
//           ),
//           body: SafeArea(
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: ComponentsSizes.horizontalPadding,
//                 right: ComponentsSizes.horizontalPadding,
//                 top: 2.15 * SizeConfigs.heightMultiplier,
//               ),
//               child: BlocBuilder<GenericCubit, GenericState>(
//                 builder: (context, state) {
//                   if (state is DataLoaded) {
//                     return Column(
//                       spacing: 3.22 * SizeConfigs.heightMultiplier,
//                       children: [
//                         Container(
//                           decoration:
//                               const BoxDecoration(color: AppColors.transparent),
//                           height: 32.2 * SizeConfigs.heightMultiplier,
//                           child: ListView.separated(
//                             shrinkWrap: true,
//                             scrollDirection: Axis.horizontal,
//                             itemBuilder: (context, index) {
//                               if (state.data.auction.images.length == 1) {
//                                 return Container(
//                                   height: 32.2 * SizeConfigs.heightMultiplier,
//                                   width: 70 * SizeConfigs.widthMultiplier,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(4),
//                                     child: Image(
//                                       fit: BoxFit.contain,
//                                       image: NetworkImage(
//                                         state.data.auction.images[index].url,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               } else {
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   width: 250,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(4),
//                                     child: Image(
//                                       image: NetworkImage(
//                                         state.data.auction.images[index].url,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//                             },
//                             separatorBuilder: (context, index) => SizedBox(
//                               width: 4.65 * SizeConfigs.widthMultiplier,
//                             ),
//                             itemCount: state.data.auction.images.length,
//                           ),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               spacing: 4.65 * SizeConfigs.widthMultiplier,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Rs.${state.data.auction.currentBid}",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .headlineSmall!
//                                       .copyWith(
//                                           color: AppColors.lightPrimaryColor),
//                                 ),
//                                 BlocBuilder<TimerCubit, Duration>(
//                                   builder: (context, remainingTime) {
//                                     final days = remainingTime.inDays;
//                                     final month = (days ~/ 30);
//                                     final year = (days ~/ 365);
//                                     final hour = remainingTime.inHours % 24;
//                                     final minute = remainingTime.inMinutes % 60;
//                                     final sec = remainingTime.inSeconds % 60;
//                                     return Expanded(
//                                       child: Text(
//                                         '$year years, ${month % 12} months, ${days % 30} days, '
//                                         '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyMedium,
//                                       ),
//                                     );
//                                   },
//                                 )
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               state.data.auction.title,
//                               style: Theme.of(context).textTheme.titleLarge,
//                             ),
//                             Text(
//                               state.data.auction.description,
//                               style: Theme.of(context).textTheme.bodyLarge,
//                             ),
//                             Text(
//                               "Condition: ${state.data.auction.condition}",
//                               style: Theme.of(context).textTheme.bodyLarge,
//                             ),
//                             const SizedBox(
//                               height: 30,
//                             ),
//                             BlocBuilder<PlaceBidCubit, PlaceBidState>(
//                               builder: (context, state) {
//                                 if (state is BidInitial) {
//                                   return ElevatedButton(
//                                     onPressed: () {
//                                       context.read<PlaceBidCubit>().onClick();
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                         left: 10,
//                                         right: 10,
//                                       ),
//                                       child: Text(
//                                         "Place Your Bid",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyLarge!
//                                             .copyWith(color: AppColors.white),
//                                       ),
//                                     ),
//                                   );
//                                 }
//                                 if (state is ShowState) {
//                                   return Column(
//                                     children: [
//                                       Form(
//                                         key: formKey,
//                                         child: SizedBox(
//                                           width:
//                                               28 * SizeConfigs.widthMultiplier,
//                                           child: TextField(
//                                             controller: amountCon,
//                                             decoration: const InputDecoration(
//                                               prefixIcon:
//                                                   Icon(Icons.assessment),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           context.read<PlaceBidCubit>().execute(
//                                                 sl<BidderPlaceBidUsecase>(),
//                                                 params1: PlaceBidEntity(
//                                                     amount: int.tryParse(
//                                                         amountCon.text)),
//                                                 params2: itemEntity.itemId,
//                                               );
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                             left: 10,
//                                             right: 10,
//                                           ),
//                                           child: Text(
//                                             "Place Your Bid",
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyLarge!
//                                                 .copyWith(
//                                                     color: AppColors.white),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 }
//                                 if (state is BidLoaded) {
//                                   return ElevatedButton(
//                                     onPressed: () {
//                                       context.read<PlaceBidCubit>().onClick();
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                         left: 10,
//                                         right: 10,
//                                       ),
//                                       child: Text(
//                                         "Place Your Bid Again",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyLarge,
//                                       ),
//                                     ),
//                                   );
//                                 }
//                                 if (state is BidFailure) {
//                                   return ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: AppColors.warning,
//                                     ),
//                                     onPressed: () {
//                                       context.read<PlaceBidCubit>().onClick();
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 10, right: 10),
//                                       child: Text(
//                                         "Place Your Bid Again",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyLarge!
//                                             .copyWith(color: AppColors.white),
//                                       ),
//                                     ),
//                                   );
//                                 }
//                                 return const SizedBox.shrink();
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     );
//                   }
//                   return const SizedBox.shrink();
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
// import 'package:nepa_bid/common/bloc/place_bid/place_bid_cubit.dart';
// import 'package:nepa_bid/common/bloc/timer_bloc/timer_cubit.dart';
// import 'package:nepa_bid/common/res/size_configs.dart';
// import 'package:nepa_bid/common/widgets/appbar/appbar.dart';
// import 'package:nepa_bid/core/config/theme/colors.dart';
// import 'package:nepa_bid/core/config/utils/utils.dart';
// import 'package:nepa_bid/core/constant/sizes.dart';
// import 'package:nepa_bid/domain/bidder/entity/item_entity.dart';
// import 'package:nepa_bid/domain/bidder/entity/place_bid.dart';
// import 'package:nepa_bid/domain/bidder/usecases/get_items_details_usecase.dart';
// import 'package:nepa_bid/domain/bidder/usecases/place_bid_usecase.dart';
// import 'package:nepa_bid/service_locator.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../presentation/auctioneer/home/widgets/video_player_widget.dart';
// import '../../bloc/generic_bloc/generic_state.dart';
// import '../../bloc/place_bid/place_bid_state.dart';
// import '../snackbar/snackbar.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.itemEntity});
  final ItemEntity itemEntity;

  DateTime? _parseEndTime(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      debugPrint('Date string is null or empty');
      return null;
    }
    
    try {
      // Try parsing with expected format first
      return DateFormat('yyyy-MM-dd H:mm').parse(dateString);
    } catch (e) {
      debugPrint('Primary format failed, trying alternative formats');
      
      // Try common alternative formats
      try {
        return DateTime.parse(dateString); // ISO 8601 format
      } catch (e) {
        debugPrint('ISO format failed, trying custom formats');
        
        // Handle cases where time might be missing
        try {
          return DateFormat('yyyy-MM-dd').parse(dateString);
        } catch (e) {
          debugPrint('All date parsing attempts failed for: $dateString');
          return null;
        }
      }
    }
  }

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
          create: (context) {
            final endTime = _parseEndTime(itemEntity.endTime);
            return TimerCubit(
              endTime: endTime ?? DateTime.now().add(const Duration(days: 1)),
            );
          },
        ),
        BlocProvider(
          create: (context) => PlaceBidCubit(),
        ),
      ],
      child: BlocListener<PlaceBidCubit, PlaceBidState>(
        listener: (context, state) {
          if (state is BidLoaded) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutesName.navPageBidder,
              (route) => false,
            );
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<GenericCubit, GenericState>(
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
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 8),
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
                                          videoUrl:
                                              videos[index - images.length].url,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
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
                                    final minutes =
                                        remainingTime.inMinutes % 60;
                                    final seconds =
                                        remainingTime.inSeconds % 60;

                                    String timeLeft = '';
                                    if (years > 0) timeLeft += '$years years, ';
                                    if (months % 12 > 0)
                                      timeLeft += '${months % 12} months, ';
                                    if (days % 30 > 0)
                                      timeLeft += '${days % 30} days, ';

                                    timeLeft +=
                                        '${hours.toString().padLeft(2, '0')}:'
                                        '${minutes.toString().padLeft(2, '0')}:'
                                        '${seconds.toString().padLeft(2, '0')}';

                                    return Text(
                                      timeLeft,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
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
                                width: 28 * SizeConfigs.widthMultiplier,
                                child: TextField(
                                  controller: amountCon,
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
                                      params1: PlaceBidEntity(
                                          amount: int.tryParse(amountCon.text)),
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
                                      .copyWith(color: AppColors.white),
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
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        );
                      }
                      if (state is BidFailure) {
                        debugPrint("Error is: ${state.errorMessage}");
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.warning,
                          ),
                          onPressed: () {
                            context.read<PlaceBidCubit>().onClick();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
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
            ),
          ),
        ),
      ),
    );
  }
}

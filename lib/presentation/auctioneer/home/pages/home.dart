import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/widgets/search/search_container.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/auction.dart';
import 'package:nepa_bid/domain/auth/usecases/usecase_imports.dart';
import 'package:nepa_bid/presentation/auctioneer/home/bloc/pagination_bloc.dart';
import 'package:nepa_bid/presentation/auctioneer/home/bloc/pagination_event.dart';
import 'package:nepa_bid/presentation/auctioneer/home/bloc/pagination_state.dart';
import 'package:nepa_bid/presentation/auctioneer/home/widgets/grid_view.dart';
import 'package:nepa_bid/service_locator.dart';
import '../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../common/res/size_configs.dart';
import '../../../../core/constant/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GenericCubit()..execute(sl<GetUserProfileUseCase>()),
        ),
      ],
      child: Scaffold(
        backgroundColor:
            isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:
                isDarkTheme ? AppColors.darkBgColor : AppColors.lightBgColor,
            statusBarIconBrightness:
                isDarkTheme ? Brightness.light : Brightness.dark,
            statusBarBrightness:
                isDarkTheme ? Brightness.dark : Brightness.light,
          ),
          toolbarHeight: 7.51 * SizeConfigs.heightMultiplier,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ComponentsSizes.horizontalPadding / 2,
            ),
            child: _buildAppBarLeading(context),
          ),
          actions: [_buildAppBarAction()],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ComponentsSizes.horizontalPadding),
          child: Column(
            children: [
              const SearchBarContainer(
                routesName: AppRoutesName.searchScreen,
              ),
              SizedBox(
                height: 2.14 * SizeConfigs.heightMultiplier,
              ),
              Expanded(
                child: _buildItemsGridView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarLeading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome back !!",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        BlocBuilder<GenericCubit, GenericState>(
          builder: (context, state) {
            if (state is DataLoading || state is DataInitial) {
              return _buildShimmerEffect();
            } else if (state is DataLoaded) {
              return Text(
                state.data.user.username,
                style: Theme.of(context).textTheme.headlineSmall,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildItemsGridView() {
    return BlocBuilder<PaginationBlocForAuctioneer,
        PaginationStateForAuctioneer>(
      builder: (context, state) {
        if (state is PaginationInitialStateForAuctioneer) {
          context.read<PaginationBlocForAuctioneer>().add(
                PaginatedEventForAuctioneer(
                  usecase: sl<AuctionUseCase>(),
                ),
              );
        }
        if (state is PaginationLoadingStateForAuctioneer) {
          return _buildShimmerEffect();
        }
        if (state is PaginationLoadedStateForAuctioneer) {
          return GridViewOfAuctioneer(
            hasMore: state.hasMore,
            state: state,
          );
        }
        if (state is PaginationFailureStateForAuctioneer) {
          debugPrint("Error: ${state.errMessage}");
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAppBarAction() {
    return BlocBuilder<GenericCubit, GenericState>(
      builder: (context, state) {
        if (state is DataLoaded) {
          return Padding(
            padding: EdgeInsets.only(right: ComponentsSizes.horizontalPadding),
            child: ClipOval(
              child: CircleAvatar(
                radius: 6 * SizeConfigs.imageSizeMultiplier,
                child: Image(
                    image: NetworkImage(state.data.user.profileImage.url)),
              ),
            ),
          );
        }
        if (state is DataInitial) {
          return Padding(
            padding: EdgeInsets.only(right: ComponentsSizes.horizontalPadding),
            child: CircleAvatar(
              radius: 6 * SizeConfigs.imageSizeMultiplier,
            ),
          );
        }
        if (state is DataFailure) {
          debugPrint("Error: ${state.errorMessage}");
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 16.0,
        color: Colors.white,
      ),
    );
  }
}

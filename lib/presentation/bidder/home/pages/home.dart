import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/bloc/geolocator/geolocator_cubit.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/domain/auth/usecases/usecase_imports.dart';
import 'package:nepa_bid/presentation/bidder/home/widgets/new_bidding.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../common/bloc/geolocator/geolocator_state.dart';
import '../../../../common/widgets/search/search_container.dart';
import '../widgets/category/category.dart';
import '../widgets/top_bidding.dart';

class HomePageBidder extends StatefulWidget {
  const HomePageBidder({super.key});

  @override
  State<HomePageBidder> createState() => _HomePageBidderState();
}

class _HomePageBidderState extends State<HomePageBidder> {
  @override
  void initState() {
    super.initState();
    context.read<GeolocatorCubit>().determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = AppUtils.isDarkTheme(context);
    return BlocProvider(
      create: (context) =>
          GenericCubit()..execute(sl<GetBidderUserProfileUseCase>()),
      child: Scaffold(
        backgroundColor: isDarkTheme? AppColors.darkBgColor: AppColors.lightBgColor,
        appBar: AppBar(
          title: Padding(
            padding:
                EdgeInsets.only(left: 3.48 * SizeConfigs.widthMultiplier),
            child: _buildAppBarLeading(),
          ),
          actions: [
            _buildAppBarAction(),
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ComponentsSizes.horizontalPadding,
          ),
          child: Column(
            children: [
              _buildSpacing(),
              const SearchBarContainer(
                routesName: AppRoutesName.searchPage,
              ),
              _buildSpacing(),
              const CategorySection(),
              _buildSpacing(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  child: Column(
                    children: [
                      const TopBiddingSection(),
                      _buildSpacing(),
                      const NewBiddingSection(),
                      _buildSpacing(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ),
      ),
    );
  }

  Widget _buildUserName() {
    return BlocBuilder<GenericCubit, GenericState>(
      builder: (context, state) {
        if (state is DataLoaded) {
          return Text(
            state.data.user.username,
            style: Theme.of(context).textTheme.titleLarge,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildSpacing() {
    return SizedBox(
      height: 2.14 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildAppBarLeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildUserName(),
        BlocBuilder<GeolocatorCubit, GeolocatorState>(
          builder: (context, state) {
            if (state is LocationSuccess) {
              return Text(
                state.address,
                style: Theme.of(context).textTheme.titleMedium,
              );
            }
            if (state is LocationFailure) {
              return Text(state.error);
            }
            return const SizedBox.shrink();
          },
        ),
      ],
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
}

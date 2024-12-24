import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/geolocator/geolocator_cubit.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/constant/sizes.dart';
import 'package:nepa_bid/presentation/bidder/home/widgets/new_bidding.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 3.48 * SizeConfigs.widthMultiplier),
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
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              _buildSpacing(),
              const SearchBarContainer(
                routesName: AppRoutesName.searchPage,
              ),
              _buildSpacing(),
              const CategorySection(),
              _buildSpacing(),
              const TopBiddingSection(),
              _buildSpacing(),
              const NewBiddingSection(),
              _buildSpacing(),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildUserName() {
    return Text(
      "Rohan Katwal",
      style: Theme.of(context).textTheme.titleLarge,
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
    return Padding(
      padding: EdgeInsets.only(right: ComponentsSizes.horizontalPadding),
      child: CircleAvatar(
        radius: 7 * SizeConfigs.imageSizeMultiplier,
      ),
    );
  }
}

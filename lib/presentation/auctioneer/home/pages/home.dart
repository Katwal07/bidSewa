import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/widgets/search/search_container.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/config/theme/colors.dart';
import 'package:nepa_bid/core/config/utils/utils.dart';
import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/auction.dart';
import 'package:nepa_bid/domain/auth/usecases/usecase_imports.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../../common/bloc/generic_bloc/generic_state.dart';
import '../../../../common/bloc/pagination/auctioneer/pagination_cubit_auction.dart';
import '../../../../common/bloc/pagination/auctioneer/pagination_state_auction.dart';
import '../../../../common/res/size_configs.dart';
import '../../../../common/widgets/container/card.dart';
import '../../../../core/constant/sizes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();
  late PaginationCubitAuctioneer _paginationCubit;

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        _paginationCubit.loadPost(sl<AuctionUseCase>());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _paginationCubit = context.read<PaginationCubitAuctioneer>();
    setupScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

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
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                const SearchBarContainer(
                  routesName: AppRoutesName.searchScreen,
                ),
                SizedBox(
                  height: 2.14 * SizeConfigs.heightMultiplier,
                ),
                _buildItemsGridView(),
              ],
            ),
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
              return Text(
                ".....",
                style: Theme.of(context).textTheme.headlineSmall,
              );
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
    return BlocBuilder<PaginationCubitAuctioneer, PaginationStateAuctioneer>(
      builder: (context, state) {
        if (state is PaginationLoadingState && state.isFirstFetch) {
          return _loadingIndicator();
        }

        List<AuctionItemEntity> posts = [];
        bool isLoading = false;

        if (state is PaginationLoadingState) {
          posts = state.oldPost;
          isLoading = true;
        } else if (state is PaginationLoadedState) {
          posts = state.post;
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 1.72 * SizeConfigs.heightMultiplier,
            crossAxisSpacing: 4.72 * SizeConfigs.widthMultiplier,
            childAspectRatio: (30.2 * SizeConfigs.widthMultiplier) /
                (18.7 * SizeConfigs.heightMultiplier),
          ),
          itemBuilder: (context, index) {
            if (index < posts.length) {
              return _post(posts[index], context);
            } else {
              Future.delayed(const Duration(seconds: 2), () {
                scrollController.jumpTo(scrollController.position.maxScrollExtent);
              });
            
        
              return const SizedBox.shrink();
            }
          },
          
          itemCount: posts.length + (isLoading ? 1 : 0),
        );
      },
    );
  }

  Widget _post(AuctionItemEntity post, BuildContext context) {
    return CustomCard(
      imageUrl: post.images[0].url!,
      title: post.title!,
      currentBid: post.currentBid!,
    );
  }

  Widget _loadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator()),
      ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_cubit.dart';
import 'package:nepa_bid/common/bloc/pagination/pagination_cubit.dart';
import 'package:nepa_bid/common/bloc/pagination/pagination_state.dart';
import 'package:nepa_bid/common/widgets/gridview/custom_gridview.dart';
import 'package:nepa_bid/common/widgets/search/search_container.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/auction.dart';
import 'package:nepa_bid/domain/auth/usecases/usecase_imports.dart';
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
  final scrollController = ScrollController();
  late PaginationCubit _paginationCubit;

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
        _paginationCubit.loadPost(usecase: sl<AuctionUseCase>());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _paginationCubit = context.read<PaginationCubit>();
    setupScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PaginationCubit()..loadPost(usecase: sl<AuctionUseCase>()),
        ),
        BlocProvider(
          create: (_) => GenericCubit()..execute(sl<GetUserProfileUseCase>()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 7.51 * SizeConfigs.heightMultiplier,
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ComponentsSizes.horizontalPadding / 2,
            ),
            child: _buildAppBarLeading(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ComponentsSizes.horizontalPadding),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                const SearchBarContainer(
                  routesName: AppRoutesName.navPage,
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
    return BlocBuilder<PaginationCubit, PaginationState>(
      builder: (context, state) {
        if (state is PaginationLoadingState && state.isFirstFetch) {
          return _loadingIndicator();
        } else if (state is PaginationLoadingState) {
          return _buildItems(state.oldPost, isLoading: true);
        } else if (state is PaginationLoadedState) {
          return _buildItems(state.post);
        } else if (state is PaginationLoadFailure) {
          return Text('Error: ${state.errorMessage}');
        } else {
          return _loadingIndicator();
        }
      },
    );
  }

Widget _buildItems(List<AuctionItemEntity> post, {bool isLoading = false}) {
  return Column(
    children: [
      CustomGridView(
        itemCount: post.length + (isLoading ? 1 : 0),
        data: post,
        scrollController: scrollController,
        isLoading: isLoading,
      ),
      if (isLoading) _loadingIndicator(),
      if (!isLoading && post.isEmpty)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No more posts available.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
    ],
  );
}


  Widget _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
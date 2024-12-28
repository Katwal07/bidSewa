import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/pagination/bidder/pagination_cubit.dart';
import 'package:nepa_bid/common/bloc/pagination/bidder/pagination_state.dart';
import 'package:nepa_bid/common/widgets/container/card.dart';
import 'package:nepa_bid/domain/bidder/entity/bidder.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_news_in_usecase.dart';
import 'package:nepa_bid/service_locator.dart';
import '../../../../common/res/size_configs.dart';

class NewBiddingSection extends StatefulWidget {
  const NewBiddingSection({super.key});

  @override
  State<NewBiddingSection> createState() => _NewBiddingSectionState();
}

class _NewBiddingSectionState extends State<NewBiddingSection> {
  final scrollController = ScrollController();
  late PaginationCubit paginationCubit;

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
        paginationCubit.loadPost(sl<GetNewsInUsecase>());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    paginationCubit = context.read<PaginationCubit>();
    setupScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNewsBiddingHeading(context),
        _buildSpacing(),
        _buildNewsBidding(),
      ],
    );
  }

  Widget _buildSpacing() {
    return SizedBox(
      height: 0.1 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildNewsBiddingHeading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "News In",
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

  Widget _buildNewsBidding() {
    return BlocBuilder<PaginationCubit, PaginationState>(
        builder: (context, state) {
      if (state is PaginationLoadingState && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<BidderItemEntity> posts = [];
      bool isLoading = false;

      if (state is PaginationLoadingState) {
        posts = state.oldPost;
        isLoading = true;
      } else if (state is PaginationLoadedState) {
        posts = state.post;
      }

      return SizedBox(
        height: 30.26 * SizeConfigs.heightMultiplier,
        child: ListView.separated(
          shrinkWrap: true,
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index < posts.length) {
              return _post(posts[index], context);
            } else {
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });

              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 2 * SizeConfigs.heightMultiplier,
          ),
          itemCount: posts.length + (isLoading ? 1 : 0),
        ),
      );
    });
  }

  Widget _post(BidderItemEntity post, BuildContext context) {

    return CustomCard(imageUrl: post.images[0].url!, title: post.title!, currentBid: post.currentBid!);
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

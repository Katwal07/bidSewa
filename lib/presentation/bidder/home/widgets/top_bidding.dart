import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/pagination_bloc/pagination_bloc.dart';
import 'package:nepa_bid/common/bloc/pagination_bloc/pagination_event.dart';
import 'package:nepa_bid/common/widgets/container/card.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/domain/bidder/entity/item_entity.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_top_bidd_usecase.dart';
import 'package:nepa_bid/service_locator.dart';
import '../../../../common/bloc/pagination_bloc/pagination_state.dart';
import '../../../../common/res/size_configs.dart';

class TopBiddingSection extends StatefulWidget {
  const TopBiddingSection(
      {super.key, required this.hasMore, required this.state});
  final bool hasMore;
  final PaginationLoadedState state;

  @override
  State<TopBiddingSection> createState() => _TopBiddingSectionState();
}

class _TopBiddingSectionState extends State<TopBiddingSection> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent && widget.hasMore) {
      context.read<PaginationBloc>().add(
            PaginatedEvent(
              useCase: sl<GetTopBiddUsecase>(),
            ),
          );
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTopBiddingHeading(context),
        _buildSpacing(),
        _buildTopBidding(),
      ],
    );
  }

  Widget _buildSpacing() {
    return SizedBox(
      height: 0.1 * SizeConfigs.heightMultiplier,
    );
  }

  Widget _buildTopBiddingHeading(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Top Bidding",
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

  Widget _buildTopBidding() {
    return SizedBox(
      height: 30.26 * SizeConfigs.heightMultiplier,
      child: ListView.separated(
        shrinkWrap: true,
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index >= widget.state.entity.length) {
            return _loadingIndicator();
          }
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutesName.detailsPage,
              arguments: ItemEntity(
                itemId: widget.state.entity[index].id,
                endTime: widget.state.entity[index].endTime,
              ),
            ),
            child: CustomCard(
              imageUrl: widget.state.entity[index].images[0].url!,
              title: widget.state.entity[index].title!,
              currentBid: widget.state.entity[index].currentBid!,
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
          width: 2 * SizeConfigs.heightMultiplier,
        ),
        itemCount: widget.hasMore
            ? widget.state.entity.length + 1
            : widget.state.entity.length,
      ),
    );
  }


  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

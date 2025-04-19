import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/common/widgets/container/card.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/auction.dart';
import 'package:nepa_bid/domain/bidder/entity/item_entity.dart';
import 'package:nepa_bid/presentation/auctioneer/home/bloc/pagination_bloc.dart';
import 'package:nepa_bid/presentation/auctioneer/home/bloc/pagination_event.dart';
import 'package:nepa_bid/presentation/auctioneer/home/bloc/pagination_state.dart';
import 'package:nepa_bid/service_locator.dart';

class GridViewOfAuctioneer extends StatefulWidget {
  final bool hasMore;
  final PaginationLoadedStateForAuctioneer state;
  const GridViewOfAuctioneer({
    super.key,
    required this.hasMore,
    required this.state,
  });

  @override
  State<GridViewOfAuctioneer> createState() => _GridViewOfAuctioneerState();
}

class _GridViewOfAuctioneerState extends State<GridViewOfAuctioneer> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    debugPrint(widget.state.hasMore.toString());
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        widget.state.hasMore) {
      context.read<PaginationBlocForAuctioneer>().add(
            PaginatedEventForAuctioneer(
              usecase: sl<AuctionUseCase>(),
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
    return _buildItemsGridView();
  }

  Widget _buildItemsGridView() {
    return GridView.builder(
      controller: _scrollController,
      shrinkWrap: false,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 1.72 * SizeConfigs.heightMultiplier,
        crossAxisSpacing: 4.72 * SizeConfigs.widthMultiplier,
        childAspectRatio: (30.2 * SizeConfigs.widthMultiplier) /
            (18.7 * SizeConfigs.heightMultiplier),
      ),
      itemBuilder: (context, index) {
        if (index >= widget.state.entity.length) {
          return _loadingIndicator();
        }
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutesName.auctioneerDetailsScreen,
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
      itemCount: widget.state.hasMore
          ? widget.state.entity.length + 1
          : widget.state.entity.length,
    );
  }

  Widget _loadingIndicator() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.sizeOf(context).width * 0.45,
        ),
        child: const Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

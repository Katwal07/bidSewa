import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/search_bloc/search_cubit.dart';
import 'package:nepa_bid/common/bloc/search_bloc/search_state.dart';
import 'package:nepa_bid/common/res/size_configs.dart';
import 'package:nepa_bid/common/widgets/container/card.dart';
import 'package:nepa_bid/domain/bidder/usecases/get_search_items_usecase.dart';
import 'package:nepa_bid/service_locator.dart';

class GridViewForSearch extends StatefulWidget {
  final bool hasMore;
  final SearchLoadedState state;
  const GridViewForSearch({
    super.key,
    required this.hasMore,
    required this.state,
  });

  @override
  State<GridViewForSearch> createState() => _GridViewOfAuctioneerState();
}

class _GridViewOfAuctioneerState extends State<GridViewForSearch> {
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
            _scrollController.position.maxScrollExtent - 100 &&
        widget.state.hasMore) {
      context.read<SearchCubit>().execute(sl<GetSearchItemsUsecase>());
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
        if (index >= widget.state.data.length) {
          return _loadingIndicator();
        }
        return CustomCard(
          imageUrl: widget.state.data[index].images[0].url!,
          title: widget.state.data[index].title!,
          currentBid: widget.state.data[index].currentBid!,
        );
      },
      itemCount: widget.state.hasMore
          ? widget.state.data.length + 1
          : widget.state.data.length,
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

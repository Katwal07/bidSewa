import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/pagination_bloc_newin/pagination_newsin_bloc.dart';
import 'package:nepa_bid/common/bloc/pagination_bloc_newin/pagination_newsin_event.dart';
import 'package:nepa_bid/common/bloc/pagination_bloc_newin/pagination_newsin_state.dart';
import 'package:nepa_bid/common/widgets/container/card.dart';
import 'package:nepa_bid/service_locator.dart';
import '../../../../common/res/size_configs.dart';
import '../../../../core/config/routes/routes_name.dart';
import '../../../../domain/bidder/entity/item_entity.dart';
import '../../../../domain/bidder/usecases/get_top_bidd_usecase.dart';

class NewBiddingSection extends StatefulWidget {
  final bool hasMore;
  final PaginationNewsInLoadedState state;
  const NewBiddingSection(
      {super.key, required this.hasMore, required this.state});

  @override
  State<NewBiddingSection> createState() => _NewBiddingSectionState();
}

class _NewBiddingSectionState extends State<NewBiddingSection> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        widget.hasMore) {
      context.read<PaginationNewsInBloc>().add(
            PaginatedNewsInEvent(
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
        itemCount: widget.hasMore ? widget.state.entity.length + 1 : widget.state.entity.length,
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

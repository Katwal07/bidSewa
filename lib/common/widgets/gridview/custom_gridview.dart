import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nepa_bid/common/widgets/container/card.dart';
import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';

import '../../res/size_configs.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.itemCount,
    required this.data,
  });

  final int itemCount;
  final List<AuctionItemEntity> data;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: itemCount,
      mainAxisSpacing: 1.72 * SizeConfigs.heightMultiplier,
      crossAxisSpacing: 3.72 * SizeConfigs.widthMultiplier,
      itemBuilder: (context, index) {
        var auctionItem = data[index];
        var imageUrl = auctionItem.images[0].url;
        return CustomCard(
          imageUrl: imageUrl ?? "",
          title: auctionItem.title ?? "",
          currentBid: auctionItem.currentBid ?? 0,
        );
      },
    );
  }
}

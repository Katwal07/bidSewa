import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nepa_bid/common/widgets/container/card.dart';
import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';

import '../../res/size_configs.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.itemCount,
    required this.data,
    required this.scrollController,
    required this.isLoading,
  });

  final int itemCount;
  final List<AuctionItemEntity> data;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 1.72 * SizeConfigs.heightMultiplier,
        crossAxisSpacing: 3.72 * SizeConfigs.widthMultiplier,
        childAspectRatio: (30.2 * SizeConfigs.widthMultiplier) /
            (20 * SizeConfigs.heightMultiplier),
      ),
      itemBuilder: (context, index) {
        if (index >= data.length) {
          Timer(const Duration(milliseconds: 30), () {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
          return _loadingIndicator();
        }

        var auctionItem = data[index];
        return GestureDetector(
          onTap: () {
            //Navigator.pushNamed(context, AppRoutesName.detailsScreen);
          },
          child: CustomCard(
            imageUrl: auctionItem.images[0].url ?? "",
            title: auctionItem.title ?? "No title",
            currentBid: auctionItem.currentBid ?? 0,
          ),
        );
      },
      itemCount: itemCount,
    );
  }

  Widget _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

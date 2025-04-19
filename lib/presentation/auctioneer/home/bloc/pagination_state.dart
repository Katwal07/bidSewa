import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';

abstract class PaginationStateForAuctioneer {}

class PaginationInitialStateForAuctioneer
    extends PaginationStateForAuctioneer {}

class PaginationLoadingStateForAuctioneer
    extends PaginationStateForAuctioneer {}

class PaginationLoadedStateForAuctioneer extends PaginationStateForAuctioneer {
  final List<AuctionItemEntity> entity;
  final bool hasMore;
  final int currentPage;

  PaginationLoadedStateForAuctioneer({
    required this.entity,
    required this.hasMore,
    required this.currentPage,
  });
}

class PaginationFailureStateForAuctioneer extends PaginationStateForAuctioneer{
  final String errMessage;

  PaginationFailureStateForAuctioneer({required this.errMessage});
}


import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';

abstract class PaginationStateAuctioneer {}

class PaginationInitialState extends PaginationStateAuctioneer{}

class PaginationLoadedState extends PaginationStateAuctioneer{
  final List<AuctionItemEntity> post;

  PaginationLoadedState({required this.post});
}

class PaginationLoadingState extends PaginationStateAuctioneer{
  final List<AuctionItemEntity> oldPost;
  final bool isFirstFetch;

  PaginationLoadingState({required this.oldPost, required this.isFirstFetch});

}

class PaginationLoadFailure extends PaginationStateAuctioneer{
  final String errorMessage;

  PaginationLoadFailure({required this.errorMessage});
}

class NoStateData extends PaginationStateAuctioneer{}
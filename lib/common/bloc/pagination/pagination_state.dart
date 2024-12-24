import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';

abstract class PaginationState {}

class PaginationInitialState extends PaginationState{}

class PaginationLoadedState extends PaginationState{
  final List<AuctionItemEntity> post;

  PaginationLoadedState({required this.post});
}

class PaginationLoadingState extends PaginationState{
  final List<AuctionItemEntity> oldPost;
  final bool isFirstFetch;

  PaginationLoadingState({required this.oldPost, required this.isFirstFetch});

}

class PaginationLoadFailure extends PaginationState{
  final String errorMessage;

  PaginationLoadFailure({required this.errorMessage});
}

import 'package:nepa_bid/domain/bidder/entity/bidder.dart';

abstract class PaginationState {}

class PaginationInitialState extends PaginationState{}

class PaginationLoadedState extends PaginationState{
  final List<BidderItemEntity> post;

  PaginationLoadedState({required this.post});
}

class PaginationLoadingState extends PaginationState{
  final List<BidderItemEntity> oldPost;
  final bool isFirstFetch;

  PaginationLoadingState({required this.oldPost, required this.isFirstFetch});

}

class PaginationLoadFailure extends PaginationState{
  final String errorMessage;

  PaginationLoadFailure({required this.errorMessage});
}
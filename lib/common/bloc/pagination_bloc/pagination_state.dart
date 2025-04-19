import 'package:nepa_bid/domain/bidder/entity/bidder.dart';

abstract class PaginationState {}

class PaginationInitialState extends PaginationState{}

class PaginationLoadingState extends PaginationState{}

class PaginationLoadedState extends PaginationState{
  final List<BidderItemEntity> entity;
  final bool hasMore;
  final int currentPage;

  PaginationLoadedState({required this.entity, required this.hasMore, required this.currentPage});
}

class PaginationFailureState extends PaginationState{
  final String errorMessage;

  PaginationFailureState({required this.errorMessage});
}
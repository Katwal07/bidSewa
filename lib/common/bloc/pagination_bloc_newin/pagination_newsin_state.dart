import 'package:nepa_bid/domain/bidder/entity/bidder.dart';

abstract class PaginationNewsInState {}

class PaginationNewsInInitialState extends PaginationNewsInState{}

class PaginationNewsInLoadingState extends PaginationNewsInState{}

class PaginationNewsInLoadedState extends PaginationNewsInState{
  final List<BidderItemEntity> entity;
  final bool hasMore;
  final int currentPage;

  PaginationNewsInLoadedState({required this.entity, required this.hasMore, required this.currentPage});
}

class PaginationNewsInFailureState extends PaginationNewsInState{
  final String errorMessage;

  PaginationNewsInFailureState({required this.errorMessage});
}
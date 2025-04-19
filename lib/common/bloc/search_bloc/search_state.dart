import '../../../domain/bidder/entity/bidder.dart';

abstract class SearchItemState {}

class SearchInitialState extends SearchItemState {}

class SearchLoadingState extends SearchItemState {}

class SearchLoadedState extends SearchItemState {
  final List<BidderItemEntity> data;
  final bool hasMore;
  final int currentPage;

  SearchLoadedState(
      {required this.data, required this.hasMore, required this.currentPage});
}

class SearchFailureState extends SearchItemState {
  final String errorMessage;

  SearchFailureState({required this.errorMessage});
}

import '../../../domain/bidder/entity/bidder.dart';

abstract class SearchItemState {}

class SearchInitialState extends SearchItemState {}

class SearchLoadingState extends SearchItemState {}

class SearchLoadedState extends SearchItemState {
  final List<BidderItemEntity> data;

  SearchLoadedState({required this.data});

}

class SearchFailureState extends SearchItemState {
  final String errorMessage;

  SearchFailureState({required this.errorMessage});
}

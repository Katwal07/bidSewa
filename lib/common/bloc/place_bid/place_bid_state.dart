abstract class PlaceBidState {}

class BidInitial extends PlaceBidState {}

class BidLoading extends PlaceBidState {}

class BidLoaded<T> extends PlaceBidState {
  final T data;

  BidLoaded({required this.data});
}

class BidFailure extends PlaceBidState {
  final String errorMessage;

  BidFailure({required this.errorMessage});
}

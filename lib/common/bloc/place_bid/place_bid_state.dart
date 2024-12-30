abstract class PlaceBidState {}

class BidInitial extends PlaceBidState {}

class ShowState extends PlaceBidState{}

class BidLoading extends PlaceBidState {}

class BidLoaded<T> extends PlaceBidState {
  final String message;
  final T data;
  final bool success;

  BidLoaded({required this.message, required this.data, required this.success});
}

class BidFailure extends PlaceBidState {
  final String errorMessage;

  BidFailure({required this.errorMessage});
}

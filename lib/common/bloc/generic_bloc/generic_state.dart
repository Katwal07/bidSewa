abstract class GenericState {}

class DataInitial extends GenericState {}

class DataLoading extends GenericState {}

class DataLoaded<T> extends GenericState {
  final T data;

  DataLoaded({required this.data});
}

class DataFailure extends GenericState {
  final String errorMessage;

  DataFailure({required this.errorMessage});
}

abstract class DateTimePickerState {}

class DateInitialState extends DateTimePickerState{}

class DateLoadingState extends DateTimePickerState{}

class DateLoadedState extends DateTimePickerState{
  final DateTime? combinedDateTime;
  final DateTime? currentTime;

  DateLoadedState({required this.combinedDateTime, required this.currentTime});


  DateTime? get getCombinedDateTime => combinedDateTime;
}

class DateLoadFailure extends DateTimePickerState{
  final String errorMessage;

  DateLoadFailure({required this.errorMessage});
}


// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'date_time_picker_state.dart';

class DateTimePickerCubit extends Cubit<DateTimePickerState> {
  DateTimePickerCubit() : super(DateInitialState());

  DateTime now = DateTime.now();
  DateTime? selectedDateTime;

  Future<void> displayDateTime(BuildContext context) async {
    try {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (pickedDate == null) {
        return;
      }

      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime == null) {
        return;
      }

      final DateTime combinedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      selectedDateTime = combinedDateTime;

      emit(
        DateLoadedState(combinedDateTime: combinedDateTime, currentTime: now,),
      );
    } catch (e) {
      emit(DateLoadFailure(errorMessage: e.toString()));
    }
  }

  DateTime? getUserCombinedDateTime() {
    final currentState = state;
    if (currentState is DateLoadedState) {
      return currentState.getCombinedDateTime;
    }
    return null;
  }

  void reset() {
    selectedDateTime = null;
    emit(DateInitialState());
  }
}

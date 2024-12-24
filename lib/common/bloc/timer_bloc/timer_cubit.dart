import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<Duration>{
  final DateTime endTime;
  late Timer _timer;

  TimerCubit({required this.endTime}) :super(endTime.difference(DateTime.now())){
    /// start the timer to update every seconds
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
  }

  /// update the remaining time
  void _updateTime(Timer timer){
    final remainingTime = endTime.difference(DateTime.now());
    emit(remainingTime);
      /// stop the timer when time is up
  if(remainingTime.isNegative){
    _timer.cancel();
    /// set the remaining time to 0
    emit(const Duration(seconds: 0));
  }
  }

  @override
  Future<void> close(){
    _timer.cancel();
    return super.close();
  }


}
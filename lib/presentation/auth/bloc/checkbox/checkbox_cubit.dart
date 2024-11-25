import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/presentation/auth/bloc/checkbox/checkbox_state.dart';

class CheckBoxCubit extends Cubit<CheckBoxState>{
  CheckBoxCubit(): super(CheckBoxState());

  void toggleCheckbox1(bool value){
    emit(state.copyWith(checkbox1: value,checkbox2: false));
  }
  void toggleCheckbox2(bool value){
    emit(state.copyWith(checkbox2: value,checkbox1: false));
  }
}
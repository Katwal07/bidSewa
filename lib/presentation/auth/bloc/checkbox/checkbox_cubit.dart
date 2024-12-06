import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/presentation/auth/bloc/checkbox/checkbox_state.dart';

class CheckBoxCubit extends Cubit<CheckBoxState> {
  CheckBoxCubit() : super(CheckBoxState());

  void toggleCheckbox1() {
      emit(CheckBoxState(checkbox1: true, checkbox2: false));
    
  }

  void toggleCheckbox2() {
      emit(CheckBoxState(checkbox1: false, checkbox2: true));
    
  }
}

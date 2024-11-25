import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/presentation/auth/bloc/signup/signup_state.dart';

class SignupCubit extends Cubit<SignupState>{
  SignupCubit(): super(SignupState());

  void toggleCheckbox1(bool value){
    emit(state.copyWith(checkbox1: value,checkbox2: false));
  }
  void toggleCheckbox2(bool value){
    emit(state.copyWith(checkbox2: value,checkbox1: false));
  }
}
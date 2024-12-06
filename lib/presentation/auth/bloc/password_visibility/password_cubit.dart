import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/presentation/auth/bloc/password_visibility/password_state.dart';

class PasswordVisiblityCubit extends Cubit<PasswordVisibilityState>{
  PasswordVisiblityCubit(): super(PasswordVisibilityInitial(obscureText: true));

  void onClick(bool value){
    emit(PasswordVisibilityLoaded(obscureText: !value));
  }
}
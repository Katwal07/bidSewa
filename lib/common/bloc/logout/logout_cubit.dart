import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/logout/logout_state.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';

class LogoutCubit extends Cubit<LogoutState>{
  LogoutCubit(): super(LogoutInitial());

  void logoutUser({required UseCase usecase}) async{
    emit(LogoutLoading());

    try {
      Either result = await usecase.call();
      return result.fold(
        (error){
          emit(LogoutFailure(errorMessage: error));
        }, 
        (data){
          emit(LogoutSuccess());
        }
      );
    } catch (e) {
      emit(LogoutFailure(errorMessage: e.toString()));
    }

  }
}
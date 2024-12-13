import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/core/error/app_error.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());

  void execute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoading());

    await Future.delayed(const Duration(seconds: 3));

   
      Either result = await usecase.call(param: params);
      result.fold((error) {
        emit(ButtonFailure(errorType: error,));
      }, (data) {
        bool success = data['success'] ?? false;
        String message = data['message'] ?? 'Unknown message';
        String role = data['user']['role'] ?? "Bidder";
        emit(ButtonLoaded(success: success, message: message, role: role));
      });
  }
}

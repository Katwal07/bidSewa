import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());

  void execute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoading());

    await Future.delayed(const Duration(seconds: 3));

    try {
      Either result = await usecase.call(param: params);
      result.fold((error) {
        emit(ButtonFailure(message: error));
      }, (data) {
        emit(ButtonLoaded());
      });
    } catch (e) {
      emit(ButtonFailure(message: e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/button_bloc_for_auction/button_state.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';

class ButtonCubitA extends Cubit<ButtonStateA> {
  ButtonCubitA() : super(ButtonInitialA());

  void execute(
      {dynamic params,
      required UseCase usecase,
      required BuildContext context}) async {
    try {
      emit(ButtonLoadingA());

      Either result = await usecase.call(param: params);
      result.fold((error) {
        emit(ButtonFailureA(
          errorMessage: error.toString(),
        ));
      }, (data) {
        emit(
          ButtonLoadedA(
            success: data.success ?? true,
            message: data.message ?? "success",
            role: data.user?.role ?? "Bidder",
          ),
        );
      });
    } catch (e) {
      emit(ButtonFailureA(errorMessage: e.toString()));
    }
  }

  void reset() {
    emit(ButtonInitialA());
  }
}

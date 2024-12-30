import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/auth/entity/user_response.dart';

import '../../../core/error/failure.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());

  void execute({dynamic params, required UseCase usecase, required BuildContext context}) async {
    try {
      emit(ButtonLoading());

    Either<Failure, UserResponseEntity> result =
        await usecase.call(param: params);
    result.fold((error) {
      emit(ButtonFailure(
        errorMessage: error.toString(),
      ));
    }, (data) {
      if(data.success == false){
        emit(ButtonFailure(errorMessage: data.message ?? 'Login Failed'));
      }else{
        emit(
        ButtonLoaded(
          success: data.success ?? true,
          message: data.message ?? "success",
          role: data.user?.role ?? "Bidder",
        ),
      );
      }
      handleLoginSuccess(data, context);
     }
    );
    } catch (e) {
      emit(ButtonFailure(errorMessage: "Authentication Failed"));
    }
  }

  void reset() {
    emit(ButtonInitial());
  }

  void handleLoginSuccess(UserResponseEntity entity, BuildContext context) {
    if (entity.success!) {
      switch (entity.user?.role) {
        case 'Bidder':
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutesName.navPageBidder,
            (route) => false,
          );
          break;
        case 'Auctioneer':
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutesName.navPage,
            (route) => false,
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Unknown user role')),
          );
          break;
      }
    }else{
      emit(ButtonFailure(errorMessage: entity.message!));
    }
  }
}

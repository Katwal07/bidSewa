import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/auth/entity/user_response.dart';
import '../../../../core/error/failure.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(ButtonInitialState());

  void execute(
      {dynamic params,
      required UseCase usecase,
      required BuildContext context}) async {
    
      emit(ButtonLoadingState());

      await Future.delayed(const Duration(seconds: 2));

      Either<Failure, UserResponseEntity> result =
          await usecase.call(param: params);
      result.fold((error) {
        if(error is NetworkFailure){
          emit(ButtonFailureState(errorMessage: "Please check your internet connection."));
        }else if(error is UnAuthorizedFailure){
          emit(ButtonFailureState(errorMessage: error.message ?? "Invalid credentials. Please try again."));
        }else{
          emit(ButtonFailureState(errorMessage: error.message ?? "An error occured"));
        }
      }, (data) {
        if (data.success == false) {
          emit(
              ButtonFailureState(errorMessage: data.message ?? 'Login Failed'));
        } else {
          emit(
            ButtonLoadedState(
              success: data.success ?? true,
              message: data.message ?? "success",
              role: data.user?.role ?? "Bidder",
            ),
          );
        }
        handleLoginSuccess(data, context);
      });
  }

  void reset() {
    emit(ButtonInitialState());
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
    } else {
      emit(ButtonFailureState(errorMessage: entity.message!));
    }
  }
}

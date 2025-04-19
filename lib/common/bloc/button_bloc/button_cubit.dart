import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/core/config/routes/routes_name.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/auth/entity/user_response.dart';

part 'button_state.dart';

class ButtonCubit extends Cubit<ButtonState> {
  ButtonCubit() : super(ButtonInitial());

  void execute({
    dynamic params,
    required UseCase usecase,
    required BuildContext context,
    bool isLogin = false,
  }) async {
    try {
      emit(ButtonLoading());

      Either result = await usecase.call(param: params);
      result.fold((error) {
        emit(ButtonFailure(
          errorMessage: error.toString(),
        ));
      }, (data) {
         if (isLogin) {
            handleLoginSuccess(data, context);
          } else {
            handleGenericSuccessResponse(data, context);
          }
      });
    } catch (e) {
      emit(ButtonFailure(errorMessage: e.toString()));
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
    } else {
      emit(ButtonFailure(errorMessage: entity.message!));
    }
  }

  void handleGenericSuccessResponse(dynamic data, BuildContext context) {
    try {

      final Map<String, dynamic> response = data as Map<String, dynamic>;
      
      if (response.containsKey('success') && response['success'] == true) {
        emit(ButtonLoaded(
          success: true,
          message: response['message'] ?? "Operation successful",
          role: "Bidder", // Default role for non-login operations
        ));
        // Navigate or show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? "Success")),
        );
      } else {
        emit(ButtonFailure(
          errorMessage: response['message'] ?? 'Operation failed',
        ));
      }
    } catch (e) {
      emit(ButtonFailure(errorMessage: 'Invalid response format'));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/domain/bidder/usecases/place_bid_usecase.dart';

import 'place_bid_state.dart';

class PlaceBidCubit extends Cubit<PlaceBidState> {
  PlaceBidCubit() : super(BidInitial());

  void execute<T>(PlaceBidUseCase usecase,
      {dynamic params1, dynamic params2}) async {
    emit(BidLoading());

    Either returnedData = await usecase.call(param1: params1, param2: params2);
    returnedData.fold((error) {
      emit(BidFailure(errorMessage: error.toString()));
    }, (data) {
      if (data.success == false) {
        emit(BidLoaded(
            message: data.message, data: data, success: data.success));
      } else {
        emit(BidLoaded(
            message: data.message, data: data, success: data.success));
      }
    });
  }

  void onClick() {
    emit(ShowState());
  }
}

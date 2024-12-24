import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/generic_bloc/generic_state.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';

class GenericCubit extends Cubit<GenericState> {
  GenericCubit() : super(DataInitial());

  void execute<T>(UseCase usecase, {dynamic params,}) async {
    emit(DataLoading());

    Either returnedData = await usecase.call(param: params);
    returnedData.fold((error) {
      emit(DataFailure(errorMessage: error.toString()));
    }, (data) {
      emit(DataLoaded<T>(data: data));
    });
  }
}

/// Note:
/// exexute({Usecase usecase, dynamic params})
/// --> This is Named Parameter meaning we need to specity their name when calling this method.
/// and usecase and params is optional

/// exexute(Usecase usecase, dynamic params)
/// ---> This is Positional Parameter meaning the order in which they are passes matters.
/// and usecase and params are not optional.
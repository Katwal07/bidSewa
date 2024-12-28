


import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/search_bloc/search_state.dart';

import '../../../domain/bidder/usecases/get_search_items_usecase.dart';

class SearchCubit extends Cubit<SearchItemState> {
  SearchCubit() : super(SearchInitialState());

  void execute(SearchUseCase usecase,
      {dynamic params1, dynamic params2}) async {
    emit(SearchLoadingState());

    Either returnedData = await usecase.call(param1: params1, param2: params2);
    returnedData.fold((error) {
      emit(SearchFailureState(errorMessage: error.toString()));
    }, (data) {
      if(params2.isEmpty){
        emit(SearchInitialState());
      }else{
        emit(SearchLoadedState(data: data));
      }
    });
  }
}

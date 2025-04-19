import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/search_bloc/search_state.dart';
import 'package:nepa_bid/domain/bidder/entity/bidder.dart';
import '../../../domain/bidder/usecases/get_search_items_usecase.dart';

class SearchCubit extends Cubit<SearchItemState> {
  bool hasMore = true;
  int currentPage = 1;
  List<BidderItemEntity> entity = [];
  bool loadFirstTime = true;
  SearchCubit() : super(SearchInitialState());

  void execute(
    SearchUseCase usecase, {
    dynamic params1,
    dynamic params2,
  }) async {
    if (!hasMore) return;
    try {
      emit(
        loadFirstTime
            ? SearchLoadingState()
            : SearchLoadedState(
                data: entity,
                hasMore: hasMore,
                currentPage: currentPage,
              ),
      );
      Either returnedData =
          await usecase.call(param1: params1, param2: params2, param3: currentPage);
      return returnedData.fold(
        (error) {
          emit(SearchFailureState(errorMessage: error.toString()));
        },
        (data) {
          entity.addAll(data);
          hasMore = data.isNotEmpty;
          if (data.isNotEmpty) {
            currentPage++;
          }
          loadFirstTime = false;

          emit(
            SearchLoadedState(
              data: entity,
              hasMore: hasMore,
              currentPage: currentPage,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        SearchFailureState(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/pagination_bloc_newin/pagination_newsin_event.dart';
import 'package:nepa_bid/common/bloc/pagination_bloc_newin/pagination_newsin_state.dart';
import 'package:nepa_bid/domain/bidder/entity/bidder.dart';

class PaginationNewsInBloc extends Bloc<PaginationNewsInEvent, PaginationNewsInState> {
  bool hasMore = true;
  int currentPage = 1;
  bool loadForFirstTime = true;
  final List<BidderItemEntity> entity = [];
  PaginationNewsInBloc() : super(PaginationNewsInInitialState()) {
    on<PaginatedNewsInEvent>(_pagination);
  }

  FutureOr<void> _pagination(
      PaginatedNewsInEvent event, Emitter<PaginationNewsInState> emit) async {
    if (!hasMore) return;
    try {
      emit(
        loadForFirstTime
            ? PaginationNewsInLoadingState()
            : PaginationNewsInLoadedState(
                entity: entity, hasMore: hasMore, currentPage: currentPage),
      );
      Either returnedData = await event.useCase.call(param: currentPage);
      return returnedData.fold(
        (error) {
          emit(
            PaginationNewsInFailureState(
              errorMessage: error.toString(),
            ),
          );
        },
        (data) {
          entity.addAll(data);
          hasMore = data.isNotEmpty;

          if (data.isNotEmpty) {
            currentPage++;
          }

          loadForFirstTime = false;

          emit(
            PaginationNewsInLoadedState(
              entity: entity,
              hasMore: hasMore,
              currentPage: currentPage,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        PaginationNewsInFailureState(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

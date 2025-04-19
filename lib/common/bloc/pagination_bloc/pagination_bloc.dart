import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/pagination_bloc/pagination_event.dart';
import 'package:nepa_bid/common/bloc/pagination_bloc/pagination_state.dart';
import 'package:nepa_bid/domain/bidder/entity/bidder.dart';

class PaginationBloc extends Bloc<PaginationEvent, PaginationState> {
  bool hasMore = true;
  int currentPage = 1;
  bool loadForFirstTime = true;
  final List<BidderItemEntity> entity = [];
  PaginationBloc() : super(PaginationInitialState()) {
    on<PaginatedEvent>(_pagination);
  }

  FutureOr<void> _pagination(
      PaginatedEvent event, Emitter<PaginationState> emit) async {
    if (!hasMore) return;
    try {
      emit(
        loadForFirstTime
            ? PaginationLoadingState()
            : PaginationLoadedState(
                entity: entity, hasMore: hasMore, currentPage: currentPage),
      );
      Either returnedData = await event.useCase.call(param: currentPage);
      return returnedData.fold(
        (error) {
          emit(
            PaginationFailureState(
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
            PaginationLoadedState(
              entity: entity,
              hasMore: hasMore,
              currentPage: currentPage,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        PaginationFailureState(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';
import 'package:nepa_bid/presentation/auctioneer/home/bloc/pagination_event.dart';
import 'package:nepa_bid/presentation/auctioneer/home/bloc/pagination_state.dart';

class PaginationBlocForAuctioneer
    extends Bloc<PaginationEventForAuctioneer, PaginationStateForAuctioneer> {
  bool hasMore = true;
  int currentPage = 1;
  List<AuctionItemEntity> items = [];
  bool loadForFirstTime = true;
  PaginationBlocForAuctioneer() : super(PaginationInitialStateForAuctioneer()) {
    on<PaginatedEventForAuctioneer>(_pagination);
  }

  FutureOr<void> _pagination(PaginatedEventForAuctioneer event,
      Emitter<PaginationStateForAuctioneer> emit) async {
    if (!hasMore) return;
    try {
      emit(
        loadForFirstTime
            ? PaginationLoadingStateForAuctioneer()
            : PaginationLoadedStateForAuctioneer(
                entity: items,
                hasMore: hasMore,
                currentPage: currentPage,
              ),
      );

      Either result = await event.usecase.call(param: currentPage);
      return result.fold(
        (error) {
          emit(
            PaginationFailureStateForAuctioneer(
              errMessage: error.toString(),
            ),
          );
        },
        (data) {
          items.addAll(data);

          hasMore = data.isNotEmpty;

          if (data.isNotEmpty) {
            currentPage++;
          }


          loadForFirstTime = false;

          emit(
            PaginationLoadedStateForAuctioneer(
              entity: items,
              hasMore: hasMore,
              currentPage: currentPage,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        PaginationFailureStateForAuctioneer(
          errMessage: e.toString(),
        ),
      );
    }
  }
}

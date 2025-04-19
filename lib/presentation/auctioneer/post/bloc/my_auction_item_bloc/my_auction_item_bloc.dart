import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/presentation/auctioneer/post/bloc/my_auction_item_bloc/my_auction_item_event.dart';
import 'package:nepa_bid/presentation/auctioneer/post/bloc/my_auction_item_bloc/my_auction_item_state.dart';

class MyAuctionItemBloc extends Bloc<MyAuctionItemEvent, MyAuctionItemState> {
  MyAuctionItemBloc() : super(MyAuctionItemInitialState()) {
    on<MyAuctionItemFetchedEvent>(_auctionItemFetched);
  }

  FutureOr<void> _auctionItemFetched(MyAuctionItemFetchedEvent event, Emitter<MyAuctionItemState> emit) async {
    emit(
      MyAuctionItemLoadingState(),
    );
    try {
      final returnedData = await event.usecase.call();
      return returnedData.fold(
        (error) {
          emit(
            MyAuctionItemFailureState(
              errorMessage: error.toString(),
            ),
          );
        },
        (data) {
          emit(
            MyAuctionItemLoadedState(entity: data),
          );
        },
      );
    } catch (e) {
      emit(
        MyAuctionItemFailureState(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
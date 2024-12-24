import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/pagination/pagination_state.dart';
import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';
import 'package:nepa_bid/domain/auctioneer/usecases/auction.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../core/usecase/usecase.dart';

class PaginationCubit extends Cubit<PaginationState> {
  PaginationCubit() : super(PaginationInitialState());

  int page = 1;

  void loadPost({
    dynamic params,
    required UseCase usecase,
  }) async {
    if (state is PaginationLoadingState) return;

    final currentState = state;
    var oldPost = <AuctionItemEntity>[];

    if (currentState is PaginationLoadedState) {
      oldPost = currentState.post;
    }

    emit(PaginationLoadingState(oldPost: oldPost, isFirstFetch: page == 1));

    final result = await sl<AuctionUseCase>().call(param: page);

    result.fold(
      (error) {
        emit(PaginationLoadFailure(errorMessage: error.toString()));
        debugPrint("Failed to fetch new posts: $error");
      },
      (newPostList) {
        if (newPostList.isEmpty) {
          debugPrint("No more posts available.");
          emit(PaginationLoadedState(post: oldPost));
          return;
        }

        page++;
        final updatedPost = List.of(oldPost)..addAll(newPostList);
        emit(PaginationLoadedState(post: updatedPost));
      },
    );
  }
}

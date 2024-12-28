

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';

import '../../../../core/usecase/usecase.dart';
import 'pagination_state_auction.dart';

class PaginationCubitAuctioneer extends Cubit<PaginationStateAuctioneer> {
  PaginationCubitAuctioneer() : super(PaginationInitialState());
  int page = 1;

  Future<void> loadPost(UseCase usecase, {dynamic params}) async {
    if (state is PaginationLoadingState) return;

    final currentState = state;
    List<AuctionItemEntity> oldPost = [];

    if (currentState is PaginationLoadedState) {
      oldPost = currentState.post;
    }

    emit(PaginationLoadingState(oldPost: oldPost, isFirstFetch: page == 1));

    Either result = await usecase.call(param: page);

    result.fold(
      (error) {
        emit(PaginationLoadFailure(errorMessage: error.toString()));
        debugPrint("Failed to fetch new posts: $error");
      },
      (newPostList){
        if(newPostList.isEmpty){
          emit(PaginationLoadedState(post: oldPost));
          return;
        }
        page++;
        final updatedPost = (state as PaginationLoadingState).oldPost;
        updatedPost.addAll(newPostList);
        emit(PaginationLoadedState(post: updatedPost));
      },
    );
  }
}

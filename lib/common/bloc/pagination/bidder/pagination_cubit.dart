import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nepa_bid/common/bloc/pagination/bidder/pagination_state.dart';
import 'package:nepa_bid/domain/bidder/entity/bidder.dart';

import '../../../../core/usecase/usecase.dart';

class PaginationCubit extends Cubit<PaginationState> {
  PaginationCubit() : super(PaginationInitialState());
  int page = 1;

  Future<void> loadPost(UseCase usecase, {dynamic params}) async {
    if (state is PaginationLoadingState) return;

    final currentState = state;
    List<BidderItemEntity> oldPost = [];

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
      (newPostList) {
        if (newPostList.isEmpty) {
          debugPrint("No more posts available.");
          emit(PaginationLoadedState(post: oldPost));
          return;
        }

        page++;
        var updatedPost = List.of(oldPost)..addAll(newPostList);
        emit(PaginationLoadedState(post: updatedPost));
      },
    );
  }
}

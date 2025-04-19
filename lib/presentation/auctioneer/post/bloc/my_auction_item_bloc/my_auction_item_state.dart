import 'package:nepa_bid/domain/auctioneer/entity/my_auction_item.dart';

abstract class MyAuctionItemState {}

class MyAuctionItemInitialState extends MyAuctionItemState{}

class MyAuctionItemLoadingState extends MyAuctionItemState{}

class MyAuctionItemLoadedState extends MyAuctionItemState{
  final MyAuctionItemsEntity entity;

  MyAuctionItemLoadedState({required this.entity});
}

class MyAuctionItemFailureState extends MyAuctionItemState{
  final String errorMessage;

  MyAuctionItemFailureState({required this.errorMessage});
}


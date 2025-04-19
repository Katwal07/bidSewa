import 'package:nepa_bid/domain/auctioneer/usecases/get_my_auction_item_usecase.dart';

abstract class MyAuctionItemEvent {}

class MyAuctionItemFetchedEvent extends MyAuctionItemEvent{
  final GetMyAuctionItemUsecase usecase;

  MyAuctionItemFetchedEvent({required this.usecase,});

}
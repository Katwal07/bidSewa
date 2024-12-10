import 'package:dartz/dartz.dart';
import 'package:nepa_bid/domain/auctioneer/entity/post_auction.dart';

abstract class AuctionRepository {
  Future<Either> getAllAuctionItems();
  Future<Either> createAuction(PostAuctionItemEntity entity);
}
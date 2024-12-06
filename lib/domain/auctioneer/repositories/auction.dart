import 'package:dartz/dartz.dart';
import 'package:nepa_bid/domain/auctioneer/entity/post_auction.dart';

abstract class AuctionRepository {
  Future<Either> createAuction(PostAuctionItemEntity entity);
}
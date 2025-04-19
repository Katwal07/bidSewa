import 'package:dartz/dartz.dart';
import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';
import 'package:nepa_bid/domain/auctioneer/entity/my_auction_item.dart';
import 'package:nepa_bid/domain/auctioneer/entity/post_auction.dart';

import '../../../core/error/failure.dart';

abstract class AuctionRepository {
  Future<Either<Failure, List<AuctionItemEntity>>> getAllAuctionItems(int page);
  Future<Either> createAuction(PostAuctionItemEntity entity);
  Future<Either<Failure, MyAuctionItemsEntity>> getMyAuctionItems();
}
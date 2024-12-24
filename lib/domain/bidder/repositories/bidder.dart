import 'package:dartz/dartz.dart';
import 'package:nepa_bid/domain/bidder/entity/auction_items_details.dart';
import 'package:nepa_bid/domain/bidder/entity/bidder.dart';
import 'package:nepa_bid/domain/bidder/entity/place_bid_response.dart';
import '../../../core/error/failure.dart';
import '../entity/place_bid.dart';

abstract class BidderRepository{
  Future<Either<Failure, List<BidderItemEntity>>> getTopBidding();
  Future<Either<Failure, List<BidderItemEntity>>> getNewsIn();
  Future<Either<Failure, AuctionItemsDetailsEntity>> getItemsDetails(String itemId);
  Future<Either<Failure, PlaceBidResponseEntity>> placeBid(PlaceBidEntity placeBidEntity,String itemId);
}
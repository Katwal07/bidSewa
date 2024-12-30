import 'package:nepa_bid/data/bidder/model/get_bids_by_bidder_id.dart';

import '../../domain/bidder/entity/get_bids_by_bidder_id.dart';

class BidderDetailsMapper {
  static BidderDetailsEntity toBidderDetailsEntity(
      BidderDetailsModel bidderDetailsModel) {
    return BidderDetailsEntity(
      bidder: toBidderDetails(bidderDetailsModel.bidder!),
      id: bidderDetailsModel.id,
      amount: bidderDetailsModel.amount,
      auctionItem: toAuctionItemEntity(bidderDetailsModel.auctionItem!),
      v: bidderDetailsModel.v,
    );
  }

  static AuctionItemEntity toAuctionItemEntity(
      AuctionItemModel auctionItemModel) {
    return AuctionItemEntity(
      id: auctionItemModel.id,
      title: auctionItemModel.title,
      description: auctionItemModel.description,
      currentBid: auctionItemModel.currentBid,
    );
  }

  static BidderEntity toBidderDetails(BidderModel bidderModel) {
    return BidderEntity(
      id: bidderModel.id,
      profileImage: bidderModel.profileImage,
    );
  }
}

import 'package:nepa_bid/data/bidder/model/bidder.dart';
import 'package:nepa_bid/domain/bidder/entity/bidder.dart';

class BidderAuctionMapper {
  static BidderItemEntity toAuctionItemEntity(BidderItemModel item) {
    return BidderItemEntity(
      id: item.id,
      title: item.title,
      description: item.description,
      category: item.category,
      condition: item.condition,
      startingBid: item.startingBid,
      currentBid: item.currentBid,
      startTime: item.startTime,
      endTime: item.endTime,
      images: item.images.map(toImageEntity).toList(),
      videos: item.videos.map(toImageEntity).toList(),
      createdBy: item.createdBy,
      commissionCalculated: item.commissionCalculated,
      createdAt: item.createdAt,
      v: item.v,
      bids: item.bids.map(toBidEntity).toList(),
    );
  }

  static BiderEntity toBidEntity(BidderModel bid) {
    return BiderEntity(
      userId: bid.userId,
      profileImage: bid.profileImage,
      amount: bid.amount,
      id: bid.id,
    );
  }

  static BidderImageEntity toImageEntity(BidderImageModel image) {
    return BidderImageEntity(
      publicId: image.publicId,
      url: image.url,
      id: image.id,
    );
  }
}

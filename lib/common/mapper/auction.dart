import 'package:nepa_bid/data/auctioneer/model/auction.dart';
import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';

class AuctionMapper {
  static AuctionItemEntity toAuctionItemEntity(AuctionItemModel item) {
    return AuctionItemEntity(
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

  static BidEntity toBidEntity(BidModel bid) {
    return BidEntity(
      userId: bid.userId,
      profileImage: bid.profileImage,
      amount: bid.amount,
      id: bid.id,
    );
  }

  static ImageEntity toImageEntity(ImageModel image) {
    return ImageEntity(
      publicId: image.publicId,
      url: image.url,
      id: image.id,
    );
  }
}

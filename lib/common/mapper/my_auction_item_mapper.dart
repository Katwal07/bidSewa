import 'package:nepa_bid/data/auctioneer/model/my_auction_item.dart';
import 'package:nepa_bid/domain/auctioneer/entity/my_auction_item.dart';

class MyAuctionItemMapper {
  static MyAuctionItemsEntity toMyAuctionItemEntity(
      MyAuctionItemsModel myAuctionItemsModel) {
    return MyAuctionItemsEntity(
      success: myAuctionItemsModel.success,
      auctions: myAuctionItemsModel.auctions.map(toAuctionEntity).toList(),
    );
  }

  static AuctionEntity toAuctionEntity(AuctionModel auctionModel) {
    return AuctionEntity(
      id: auctionModel.id,
      title: auctionModel.title,
      description: auctionModel.description,
      category: auctionModel.category,
      condition: auctionModel.condition,
      startingBid: auctionModel.startingBid,
      currentBid: auctionModel.currentBid,
      startTime: auctionModel.startTime,
      endTime: auctionModel.endTime,
      images: auctionModel.images.map(toImageEntity).toList(),
      videos: auctionModel.videos.map(toImageEntity).toList(),
      createdBy: auctionModel.createdBy,
      commissionCalculated: auctionModel.commissionCalculated,
      bids: auctionModel.bids,
      comments: auctionModel.comments,
      createdAt: auctionModel.createdAt,
      v: auctionModel.v,
    );
  }

  static ImageEntity toImageEntity(ImageModel imageModel) {
    return ImageEntity(
      publicId: imageModel.publicId,
      url: imageModel.url,
      id: imageModel.id,
    );
  }
}

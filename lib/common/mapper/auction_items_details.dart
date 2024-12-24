import 'package:nepa_bid/data/bidder/model/auction_items_details.dart';
import 'package:nepa_bid/domain/bidder/entity/auction_items_details.dart';

class AuctionItemsDetailsMapper {
  static AuctionItemsDetailsEntity toAuctionItemDeatilsEntity(
      AuctionItemsDetailsModel model) {
    return AuctionItemsDetailsEntity(
      success: model.success,
      auction: toAuctionEntity(model.auction!),
      bidders: model.bidders.map((e)=> e).toList(),
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
      videos: auctionModel.videos.map(toVideoEntity).toList(),
      createdBy: auctionModel.createdBy,
      commissionCalculated: auctionModel.commissionCalculated,
      bids: auctionModel.bids,
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

    static VideoEntity toVideoEntity(VideoModel videoModel) {
    return VideoEntity(
      publicId: videoModel.publicId,
      url: videoModel.url,
      id: videoModel.id,
    );
  }
}

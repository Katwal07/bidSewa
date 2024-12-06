import '../../data/auctioneer/model/post_auction.dart';
import '../../domain/auctioneer/entity/post_auction.dart';

class CreateAuctionMapper {
  static PostAuctionItemModel toModel(PostAuctionItemEntity entity) {
    return PostAuctionItemModel(
      title: entity.title,
      description: entity.description,
      category: entity.category,
      condition: entity.condition,
      startingBid: entity.startingBid,
      startTime: entity.startTime,
      endTime: entity.endTime,
      images: entity.images,
      videos: entity.videos,
    );
  }
}

class AuctionItemsDetailsEntity {
    AuctionItemsDetailsEntity({
        required this.success,
        required this.auction,
        required this.bidders,
    });

    final bool? success;
    final AuctionEntity? auction;
    final List<dynamic> bidders;
}

class AuctionEntity {
    AuctionEntity({
        required this.id,
        required this.title,
        required this.description,
        required this.category,
        required this.condition,
        required this.startingBid,
        required this.currentBid,
        required this.startTime,
        required this.endTime,
        required this.images,
        required this.videos,
        required this.createdBy,
        required this.commissionCalculated,
        required this.bids,
        required this.createdAt,
        required this.v,
    });

    final String? id;
    final String? title;
    final String? description;
    final String? category;
    final String? condition;
    final int? startingBid;
    final int? currentBid;
    final String? startTime;
    final String? endTime;
    final List<ImageEntity> images;
    final List<VideoEntity> videos;
    final String? createdBy;
    final bool? commissionCalculated;
    final List<dynamic> bids;
    final DateTime? createdAt;
    final int? v;
}

class ImageEntity {
    ImageEntity({
        required this.publicId,
        required this.url,
        required this.id,
    });

    final String? publicId;
    final String? url;
    final String? id;
}

class VideoEntity {
    VideoEntity({
        required this.publicId,
        required this.url,
        required this.id,
    });

    final String? publicId;
    final String? url;
    final String? id;
}

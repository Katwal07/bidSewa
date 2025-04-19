class MyAuctionItemsEntity {
    MyAuctionItemsEntity({
        required this.success,
        required this.auctions,
    });

    final bool? success;
    final List<AuctionEntity> auctions;
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
        required this.comments,
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
    final List<ImageEntity> videos;
    final String? createdBy;
    final bool? commissionCalculated;
    final List<dynamic> bids;
    final List<dynamic> comments;
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

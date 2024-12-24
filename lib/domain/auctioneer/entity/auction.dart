
class AuctionItemEntity {
  AuctionItemEntity({
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
    required this.createdAt,
    required this.v,
    required this.bids,
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
  final DateTime? createdAt;
  final int? v;
  final List<BidEntity> bids;
}

class BidEntity {
  BidEntity({
    required this.userId,
    required this.profileImage,
    required this.amount,
    required this.id,
  });

  final String? userId;
  final String? profileImage;
  final int? amount;
  final String? id;
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

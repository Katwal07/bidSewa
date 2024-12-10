class AuctionUserModel {
    AuctionUserModel({
        required this.success,
        required this.items,
    });

    final bool? success;
    final List<AuctionItemModel> items;

    factory AuctionUserModel.fromJson(Map<String, dynamic> json){ 
        return AuctionUserModel(
            success: json["success"],
            items: json["items"] == null ? [] : List<AuctionItemModel>.from(json["items"]!.map((x) => AuctionItemModel.fromJson(x))),
        );
    }
}

class AuctionItemModel {
    AuctionItemModel({
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
    final List<ImageModel> images;
    final List<ImageModel> videos;
    final String? createdBy;
    final bool? commissionCalculated;
    final DateTime? createdAt;
    final int? v;
    final List<BidModel> bids;

    factory AuctionItemModel.fromJson(Map<String, dynamic> json){ 
        return AuctionItemModel(
            id: json["_id"],
            title: json["title"],
            description: json["description"],
            category: json["category"],
            condition: json["condition"],
            startingBid: json["startingBid"],
            currentBid: json["currentBid"],
            startTime: json["startTime"],
            endTime: json["endTime"],
            images: json["images"] == null ? [] : List<ImageModel>.from(json["images"]!.map((x) => ImageModel.fromJson(x))),
            videos: json["videos"] == null ? [] : List<ImageModel>.from(json["videos"]!.map((x) => ImageModel.fromJson(x))),
            createdBy: json["createdBy"],
            commissionCalculated: json["commissionCalculated"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            v: json["__v"],
            bids: json["bids"] == null ? [] : List<BidModel>.from(json["bids"]!.map((x) => BidModel.fromJson(x))),
        );
    }

}

class BidModel {
    BidModel({
        required this.userId,
        required this.profileImage,
        required this.amount,
        required this.id,
    });

    final String? userId;
    final String? profileImage;
    final int? amount;
    final String? id;

    factory BidModel.fromJson(Map<String, dynamic> json){ 
        return BidModel(
            userId: json["userId"],
            profileImage: json["profileImage"],
            amount: json["amount"],
            id: json["_id"],
        );
    }

}

class ImageModel {
    ImageModel({
        required this.publicId,
        required this.url,
        required this.id,
    });

    final String? publicId;
    final String? url;
    final String? id;

    factory ImageModel.fromJson(Map<String, dynamic> json){ 
        return ImageModel(
            publicId: json["public_id"],
            url: json["url"],
            id: json["_id"],
        );
    }

}

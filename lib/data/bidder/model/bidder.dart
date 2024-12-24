class BidderItemModel {
    BidderItemModel({
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
    final List<BidderImageModel> images;
    final List<BidderImageModel> videos;
    final String? createdBy;
    final bool? commissionCalculated;
    final DateTime? createdAt;
    final int? v;
    final List<BidderModel> bids;

    factory BidderItemModel.fromJson(Map<String, dynamic> json){ 
        return BidderItemModel(
            id: json["_id"],
            title: json["title"],
            description: json["description"],
            category: json["category"],
            condition: json["condition"],
            startingBid: json["startingBid"],
            currentBid: json["currentBid"],
            startTime: json["startTime"],
            endTime: json["endTime"],
            images: json["images"] == null ? [] : List<BidderImageModel>.from(json["images"]!.map((x) => BidderImageModel.fromJson(x))),
            videos: json["videos"] == null ? [] : List<BidderImageModel>.from(json["videos"]!.map((x) => BidderImageModel.fromJson(x))),
            createdBy: json["createdBy"],
            commissionCalculated: json["commissionCalculated"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            v: json["__v"],
            bids: json["bids"] == null ? [] : List<BidderModel>.from(json["bids"]!.map((x) => BidderModel.fromJson(x))),
        );
    }

}

class BidderModel {
    BidderModel({
        required this.userId,
        required this.profileImage,
        required this.amount,
        required this.id,
    });

    final String? userId;
    final String? profileImage;
    final int? amount;
    final String? id;

    factory BidderModel.fromJson(Map<String, dynamic> json){ 
        return BidderModel(
            userId: json["userId"],
            profileImage: json["profileImage"],
            amount: json["amount"],
            id: json["_id"],
        );
    }

}

class BidderImageModel {
    BidderImageModel({
        required this.publicId,
        required this.url,
        required this.id,
    });

    final String? publicId;
    final String? url;
    final String? id;

    factory BidderImageModel.fromJson(Map<String, dynamic> json){ 
        return BidderImageModel(
            publicId: json["public_id"],
            url: json["url"],
            id: json["_id"],
        );
    }

}

class AuctionItemsDetailsModel {
    AuctionItemsDetailsModel({
        required this.success,
        required this.auction,
        required this.bidders,
    });

    final bool? success;
    final AuctionModel? auction;
    final List<dynamic> bidders;

    factory AuctionItemsDetailsModel.fromJson(Map<String, dynamic> json){ 
        return AuctionItemsDetailsModel(
            success: json["success"],
            auction: json["auction"] == null ? null : AuctionModel.fromJson(json["auction"]),
            bidders: json["bidders"] == null ? [] : List<dynamic>.from(json["bidders"]!.map((x) => x)),
        );
    }

}

class AuctionModel {
    AuctionModel({
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
    final List<ImageModel> images;
    final List<VideoModel> videos;
    final String? createdBy;
    final bool? commissionCalculated;
    final List<dynamic> bids;
    final DateTime? createdAt;
    final int? v;

    factory AuctionModel.fromJson(Map<String, dynamic> json){ 
        return AuctionModel(
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
            videos: json["videos"] == null ? [] : List<VideoModel>.from(json["videos"]!.map((x) => VideoModel.fromJson(x))),
            createdBy: json["createdBy"],
            commissionCalculated: json["commissionCalculated"],
            bids: json["bids"] == null ? [] : List<dynamic>.from(json["bids"]!.map((x) => x)),
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            v: json["__v"],
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

class VideoModel {
    VideoModel({
        required this.publicId,
        required this.url,
        required this.id,
    });

    final String? publicId;
    final String? url;
    final String? id;

    factory VideoModel.fromJson(Map<String, dynamic> json){ 
        return VideoModel(
            publicId: json["public_id"],
            url: json["url"],
            id: json["_id"],
        );
    }

}

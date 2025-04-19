class BidderDetailsModel {
    BidderDetailsModel({
        required this.bidder,
        required this.id,
        required this.amount,
        required this.auctionItem,
        required this.v,
    });

    final BidderModel? bidder;
    final String? id;
    final int? amount;
    final AuctionItemModel? auctionItem;
    final int? v;

    factory BidderDetailsModel.fromJson(Map<String, dynamic> json){ 
        return BidderDetailsModel(
            bidder: json["bidder"] == null ? null : BidderModel.fromJson(json["bidder"]),
            id: json["_id"],
            amount: json["amount"],
            auctionItem: json["auctionItem"] == null ? null : AuctionItemModel.fromJson(json["auctionItem"]),
            v: json["__v"],
        );
    }

}

class AuctionItemModel {
    AuctionItemModel({
        required this.id,
        required this.title,
        required this.description,
        required this.currentBid,
        required this.endTime,
    });

    final String? id;
    final String? title;
    final String? description;
    final int? currentBid;
    final String? endTime;

    factory AuctionItemModel.fromJson(Map<String, dynamic> json){ 
        return AuctionItemModel(
            id: json["_id"],
            title: json["title"],
            description: json["description"],
            currentBid: json["currentBid"],
            endTime: json["endTime"],
        );
    }

}

class BidderModel {
    BidderModel({
        required this.id,
        required this.profileImage,
    });

    final String? id;
    final String? profileImage;

    factory BidderModel.fromJson(Map<String, dynamic> json){ 
        return BidderModel(
            id: json["id"],
            profileImage: json["profileImage"],
        );
    }

}

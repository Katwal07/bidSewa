class BidderDetailsEntity {
    BidderDetailsEntity({
        required this.bidder,
        required this.id,
        required this.amount,
        required this.auctionItem,
        required this.v,
    });

    final BidderEntity? bidder;
    final String? id;
    final int? amount;
    final AuctionItemEntity? auctionItem;
    final int? v;

}

class AuctionItemEntity {
    AuctionItemEntity({
        required this.id,
        required this.title,
        required this.description,
        required this.currentBid,
    });

    final String? id;
    final String? title;
    final String? description;
    final int? currentBid;
}

class BidderEntity {
    BidderEntity({
        required this.id,
        required this.profileImage,
    });

    final String? id;
    final String? profileImage;

}

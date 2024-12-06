import 'dart:io';

class PostAuctionItemEntity {
    PostAuctionItemEntity({
        required this.title,
        required this.description,
        required this.category,
        required this.condition,
        required this.startingBid,
        required this.startTime,
        required this.endTime,
        required this.images,
        required this.videos,
    });

    final String? title;
    final String? description;
    final String? category;
    final String? condition;
    final int? startingBid;
    final String? startTime;
    final String? endTime;
    final List<File> images;
    final List<File> videos;
}

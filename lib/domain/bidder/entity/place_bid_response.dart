class PlaceBidResponseEntity {
    PlaceBidResponseEntity({
        required this.success,
        required this.message,
        required this.currentBid,
    });

    final bool? success;
    final String? message;
    final int? currentBid;
}
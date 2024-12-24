class PlaceBidResponseModel {
    PlaceBidResponseModel({
        required this.success,
        required this.message,
        required this.currentBid,
    });

    final bool? success;
    final String? message;
    final int? currentBid;

    factory PlaceBidResponseModel.fromJson(Map<String, dynamic> json){ 
        return PlaceBidResponseModel(
            success: json["success"],
            message: json["message"],
            currentBid: json["currentBid"],
        );
    }

}
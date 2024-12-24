import 'package:nepa_bid/data/bidder/model/place_bid_response.dart';
import 'package:nepa_bid/domain/bidder/entity/place_bid_response.dart';

class PlaceBidResponseMapper {
  static PlaceBidResponseEntity toPlaceBidResponseEntity(
      PlaceBidResponseModel placeBidResponseModel) {
    return PlaceBidResponseEntity(
      success: placeBidResponseModel.success,
      message: placeBidResponseModel.message,
      currentBid: placeBidResponseModel.currentBid,
    );
  }
}

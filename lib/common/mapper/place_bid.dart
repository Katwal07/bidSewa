import 'package:nepa_bid/data/bidder/model/place_bid.dart';
import 'package:nepa_bid/domain/bidder/entity/place_bid.dart';

class PlaceBidMapper {
  static PlaceBidModel toPlaceBidModel(PlaceBidEntity placeBidEntity) {
    return PlaceBidModel(
      amount: placeBidEntity.amount,
    );
  }
}

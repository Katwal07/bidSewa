import 'package:dartz/dartz.dart';
import 'package:nepa_bid/domain/bidder/entity/place_bid.dart';
import 'package:nepa_bid/domain/bidder/entity/place_bid_response.dart';
import 'package:nepa_bid/domain/bidder/repositories/bidder.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../core/error/failure.dart';

abstract class PlaceBidUseCase<Type, Param1, Param2> {
  Future<Type> call({Param1 param1, Param2 param2});
}

class BidderPlaceBidUsecase extends PlaceBidUseCase<Either<Failure, PlaceBidResponseEntity>, PlaceBidEntity, String > {
  @override
  Future<Either<Failure, PlaceBidResponseEntity>> call({PlaceBidEntity? param1, String ? param2}) async{
    return await sl<BidderRepository>().placeBid(param1!, param2!);
  }
}
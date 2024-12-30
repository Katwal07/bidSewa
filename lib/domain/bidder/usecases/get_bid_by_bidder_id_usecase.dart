import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/bidder/entity/get_bids_by_bidder_id.dart';
import 'package:nepa_bid/domain/bidder/repositories/bidder.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../core/error/failure.dart';

class GetBidByBidderIdUsecase extends UseCase<Either<Failure, List<BidderDetailsEntity>>,String >{
  @override
  Future<Either<Failure, List<BidderDetailsEntity>>> call({String ?  param}) async{
    return await sl<BidderRepository>().getBidsByBidderId(param!);
  }
}
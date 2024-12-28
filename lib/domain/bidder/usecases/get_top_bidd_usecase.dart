import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/bidder/entity/bidder.dart';
import 'package:nepa_bid/domain/bidder/repositories/bidder.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../core/error/failure.dart';

class GetTopBiddUsecase extends UseCase<Either<Failure, List<BidderItemEntity>>, int>{
  @override
  Future<Either<Failure, List<BidderItemEntity>>> call({int ? param}) async{
    return await sl<BidderRepository>().getTopBidding(param!);
  }
}
import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';
import 'package:nepa_bid/domain/auctioneer/repositories/auction.dart';

import '../../../core/error/failure.dart';
import '../../../service_locator.dart';

class AuctionUseCase extends UseCase<Either<Failure,List<AuctionItemEntity>>, int> {
  @override
  Future<Either<Failure, List<AuctionItemEntity>>> call({ int? param}) async{
      return await sl<AuctionRepository>().getAllAuctionItems(param!);
  }
}
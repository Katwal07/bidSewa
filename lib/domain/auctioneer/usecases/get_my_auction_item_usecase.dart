import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/error/failure.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/auctioneer/entity/my_auction_item.dart';
import 'package:nepa_bid/domain/auctioneer/repositories/auction.dart';
import 'package:nepa_bid/service_locator.dart';

class GetMyAuctionItemUsecase extends UseCase<Either<Failure, MyAuctionItemsEntity>, dynamic>{
  @override
  Future<Either<Failure, MyAuctionItemsEntity>> call({param}) async{
    return await sl<AuctionRepository>().getMyAuctionItems();
  }
}
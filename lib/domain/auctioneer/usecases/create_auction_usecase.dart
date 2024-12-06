import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/auctioneer/entity/post_auction.dart';
import 'package:nepa_bid/domain/auctioneer/repositories/auction.dart';
import 'package:nepa_bid/service_locator.dart';

class CreateAuctionUsecase implements UseCase<Either, PostAuctionItemEntity>{
  @override
  Future<Either> call({PostAuctionItemEntity ? param}) async{
    return await sl<AuctionRepository>().createAuction(param!);
  }

}
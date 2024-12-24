import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/error/failure.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/bidder/entity/auction_items_details.dart';

import '../../../service_locator.dart';
import '../repositories/bidder.dart';


class GetItemsDetailsUsecase extends UseCase<Either<Failure, AuctionItemsDetailsEntity>, String>{
  @override
  Future<Either<Failure, AuctionItemsDetailsEntity>> call({String ? param}) async{
    return await sl<BidderRepository>().getItemsDetails(param!);
  }
}
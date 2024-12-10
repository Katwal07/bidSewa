import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/auctioneer/repositories/auction.dart';

import '../../../service_locator.dart';

class AuctionUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({param}) async{
    return await sl<AuctionRepository>().getAllAuctionItems();
  }

}
import 'package:dartz/dartz.dart';
import 'package:nepa_bid/common/mapper/auction.dart';
import 'package:nepa_bid/common/mapper/create_auction.dart';
import 'package:nepa_bid/data/auctioneer/model/auction.dart';
import 'package:nepa_bid/data/auctioneer/source/auction_api_service.dart';
import 'package:nepa_bid/domain/auctioneer/entity/post_auction.dart';
import 'package:nepa_bid/domain/auctioneer/repositories/auction.dart';

import '../../../service_locator.dart';

class AuctionRepositoryImpl extends AuctionRepository {
  @override
  Future<Either> createAuction(PostAuctionItemEntity entity) async {
    try {
      var auctionItem = CreateAuctionMapper.toModel(entity);
      Either result = await sl<AuctionApiService>().createAuction(auctionItem);
      return result.fold((error) {
        return Left(error);
      }, (data) {
        return Right(data);
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getAllAuctionItems() async {
    var returnedData = await sl<AuctionApiService>().getAllAuctionItems();
    return returnedData.fold(
      (error) {
        return Left(error);
      },
      (data) {
        var auctionItems = List.from(data['items'])
            .map(
              (items) => AuctionMapper.toAuctionItemEntity(
                AuctionItemModel.fromJson(items),
              ),
            ).toList();
        return Right(auctionItems);
      },
    );
  }
}

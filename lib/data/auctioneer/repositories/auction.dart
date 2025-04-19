import 'package:dartz/dartz.dart';
import 'package:nepa_bid/common/mapper/auction.dart';
import 'package:nepa_bid/common/mapper/create_auction.dart';
import 'package:nepa_bid/common/mapper/my_auction_item_mapper.dart';
import 'package:nepa_bid/data/auctioneer/source/auction_api_service.dart';
import 'package:nepa_bid/domain/auctioneer/entity/auction.dart';
import 'package:nepa_bid/domain/auctioneer/entity/my_auction_item.dart';
import 'package:nepa_bid/domain/auctioneer/entity/post_auction.dart';
import 'package:nepa_bid/domain/auctioneer/repositories/auction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/failure.dart';
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
  Future<Either<Failure, List<AuctionItemEntity>>> getAllAuctionItems(
      int page) async {
   
      Either returnedData = await sl<AuctionApiService>().getAllAuctionItems(page);
      return returnedData.fold(
        (error) {
          return Left(error);
        },
        (data) {
          final List<AuctionItemEntity> auctionItemEntity = (data as List).map((item)=> AuctionMapper.toAuctionItemEntity(item)).toList();
          return Right(auctionItemEntity);
        },
      );
  }

  @override
  Future<Either<Failure, MyAuctionItemsEntity>> getMyAuctionItems() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final userId = prefs.getString('userId');
    Either returnedData = await sl<AuctionApiService>().getMyAuctionItems(userId!);
      return returnedData.fold(
        (error) {
          return Left(error);
        },
        (data) {
          final MyAuctionItemsEntity auctionItemEntity = MyAuctionItemMapper.toMyAuctionItemEntity(data);
          return Right(auctionItemEntity);
        },
      );
  }
}

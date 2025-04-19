import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:nepa_bid/common/mapper/auction_items_details.dart';
import 'package:nepa_bid/common/mapper/bidder_details.dart';
import 'package:nepa_bid/common/mapper/bidder_items.dart';
import 'package:nepa_bid/common/mapper/category.dart';
import 'package:nepa_bid/common/mapper/place_bid.dart';
import 'package:nepa_bid/common/mapper/place_bid_response.dart';
import 'package:nepa_bid/core/error/failure.dart';
import 'package:nepa_bid/core/error/mapping.dart';
import 'package:nepa_bid/data/bidder/model/bidder.dart';
import 'package:nepa_bid/data/bidder/sources/bidder_api_sources.dart';
import 'package:nepa_bid/domain/bidder/entity/auction_items_details.dart';
import 'package:nepa_bid/domain/bidder/entity/bidder.dart';
import 'package:nepa_bid/domain/bidder/entity/category.dart';
import 'package:nepa_bid/domain/bidder/entity/get_bids_by_bidder_id.dart';
import 'package:nepa_bid/domain/bidder/entity/place_bid_response.dart';
import 'package:nepa_bid/domain/bidder/repositories/bidder.dart';
import 'package:nepa_bid/service_locator.dart';

import '../../../domain/bidder/entity/place_bid.dart';

class BidderRepositoryImpl extends BidderRepository {
  @override
  Future<Either<Failure, List<BidderItemEntity>>> getNewsIn(int page) async {
    Either returnedData = await sl<BidderApiSources>().getNewsIn(page);
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      // Define formatters for different possible formats
      final dateFormats = DateFormat("yyyy-MM-dd HH:mm");

      final List<BidderItemModel> sortedItems = data
        ..sort((BidderItemModel a, BidderItemModel b) {
          final DateTime aDate = dateFormats.parse(a.startTime!);
          final DateTime bDate = dateFormats.parse(b.startTime!);

          // Sort descending
          return bDate.compareTo(aDate);
        });

      final List<BidderItemEntity> items = sortedItems
          .map((item) => BidderAuctionMapper.toAuctionItemEntity(item))
          .toList();

      return Right(items);
    });
  }

  @override
  Future<Either<Failure, List<BidderItemEntity>>> getTopBidding(
      int page) async {
    Either returnedData = await sl<BidderApiSources>().getTopBidding(page);
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      final List<BidderItemModel> sortedItems = (data as List<BidderItemModel>)
        ..sort((BidderItemModel a, BidderItemModel b) =>
            b.currentBid!.compareTo(a.currentBid!));
      final List<BidderItemEntity> items = sortedItems
          .map((e) => BidderAuctionMapper.toAuctionItemEntity(e))
          .toList();
      return Right(items);
    });
  }

  @override
  Future<Either<Failure, AuctionItemsDetailsEntity>> getItemsDetails(
      String itemId) async {
    Either returnedData = await sl<BidderApiSources>().getItemsDetails(itemId);
    return returnedData.fold((error) {
      return Left(mapExceptionToFailure(error));
    }, (data) {
      final itemDetails =
          AuctionItemsDetailsMapper.toAuctionItemDeatilsEntity(data);
      return Right(itemDetails);
    });
  }

  @override
  Future<Either<Failure, PlaceBidResponseEntity>> placeBid(
      PlaceBidEntity placeBidEntity, String itemId) async {
    Either returnedData = await sl<BidderApiSources>()
        .placeBid(PlaceBidMapper.toPlaceBidModel(placeBidEntity), itemId);
    return returnedData.fold((error) {
      return Left(mapExceptionToFailure(error));
    }, (data) {
      final placeBidResponse =
          PlaceBidResponseMapper.toPlaceBidResponseEntity(data);
      return Right(placeBidResponse);
    });
  }

  @override
  Future<Either<Failure, List<BidderItemEntity>>> searchItems(
      String keywordName, String searchItemName, int page) async {
    Either returnedData =
        await sl<BidderApiSources>().searchItems(keywordName, searchItemName, page);
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      final List<BidderItemEntity> items = (data as List)
          .map((e) => BidderAuctionMapper.toAuctionItemEntity(e))
          .toList();
      return Right(items);
    });
  }

  @override
  Future<Either<Failure, List<CategoryElementEntity>>> getAllCategory() async {
    var returnedData = await sl<BidderApiSources>().getAllCategory();
    return returnedData.fold((error) {
      return Left(mapExceptionToFailure(error));
    }, (data) {
      final List<CategoryElementEntity> category =
          (data).map((e) => CategoryMapper.toCategoryItemEntity(e)).toList();
      return Right(category);
    });
  }

  @override
  Future<Either<Failure, List<BidderDetailsEntity>>> getBidsByBidderId(
      String bidderId) async {
    var returnedData = await sl<BidderApiSources>().getBidsByBidderId(bidderId);
    return returnedData.fold(
      (error) {
        return Left(mapExceptionToFailure(error));
      },
      (data) {
        final List<BidderDetailsEntity> bidderDetails = (data).map((e)=> BidderDetailsMapper.toBidderDetailsEntity(e)).toList();
        return Right(bidderDetails);
      },
    );
  }
}

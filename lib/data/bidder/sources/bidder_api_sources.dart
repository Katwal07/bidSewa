import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nepa_bid/core/error/exception.dart';
import 'package:nepa_bid/core/network/api_client.dart';
import 'package:nepa_bid/core/network/network_const/api_endpoint_urls.dart';
import 'package:nepa_bid/core/network/network_const/constant.dart';
import 'package:nepa_bid/data/bidder/model/auction_items_details.dart';
import 'package:nepa_bid/data/bidder/model/bidder.dart';
import 'package:nepa_bid/data/bidder/model/category.dart';
import 'package:nepa_bid/data/bidder/model/place_bid_response.dart';
import 'package:nepa_bid/service_locator.dart';
import '../model/place_bid.dart';

abstract class BidderApiSources {
  Future<Either<AppException, List<BidderItemModel>>> getTopBidding(int page);
  Future<Either<AppException, List<BidderItemModel>>> getNewsIn(int page);
  Future<Either<AppException, AuctionItemsDetailsModel>> getItemsDetails(
      String itemId);
  Future<Either<AppException, PlaceBidResponseModel>> placeBid(
      PlaceBidModel placeBidModel, String itemId);
  Future<Either<AppException, List<BidderItemModel>>> searchItems(
      String keywordName, String searchItemName);
  Future<Either<AppException, List<CategoryElementModel>>> getAllCategory();
}

class BidderApiSourceImpl extends BidderApiSources {
  @override
  Future<Either<AppException, List<BidderItemModel>>> getNewsIn(int page) async {
    try {
      var response =
          await sl<ApiClient>().getRequest(path: "${ApiEndpointUrls.getAllItems}?limit=$fetchLimit&&page=$page");
      final List<BidderItemModel> auctionItemModel =
          (response.data['items'] as List)
              .map((item) => BidderItemModel.fromJson(item))
              .toList();
      return Right(auctionItemModel);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left(
            NetworkException(message: "Unable to connect to the server."));
      }
      if (e.type == DioExceptionType.connectionError) {
        return Left(NetworkException(message: "No internet connection."));
      }
      if (e.response?.statusCode == 401) {
        return Left(UnAuthorizedException(
            message: e.response?.data['message'] ?? "Invalid credentials."));
      }
      return Left(ServerException(
          message: e.response?.data['message'] ?? "An error occurred."));
    }
  }

  @override
  Future<Either<AppException, List<BidderItemModel>>> getTopBidding(int page) async {
    try {
      var response =
          await sl<ApiClient>().getRequest(path: "${ApiEndpointUrls.getAllItems}?limit=$fetchLimit&&page=$page");
      final List<BidderItemModel> auctionItemModel =
          (response.data['items'] as List)
              .map((item) => BidderItemModel.fromJson(item))
              .toList();
      return Right(auctionItemModel);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left(
            NetworkException(message: "Unable to connect to the server."));
      }
      if (e.type == DioExceptionType.connectionError) {
        return Left(NetworkException(message: "No internet connection."));
      }
      if (e.response?.statusCode == 401) {
        return Left(UnAuthorizedException(
            message: e.response?.data['message'] ?? "Invalid credentials."));
      }
      return Left(ServerException(
          message: e.response?.data['message'] ?? "An error occurred."));
    }
  }

  @override
  Future<Either<AppException, AuctionItemsDetailsModel>> getItemsDetails(
      String itemId) async {
    try {
      var response = await sl<ApiClient>()
          .getRequest(path: "${ApiEndpointUrls.getItemsDetails}$itemId");
      final itemDetails = AuctionItemsDetailsModel.fromJson(response.data);
      return Right(itemDetails);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left(
            NetworkException(message: "Unable to connect to the server."));
      }
      if (e.type == DioExceptionType.connectionError) {
        return Left(NetworkException(message: "No internet connection."));
      }
      if (e.response?.statusCode == 401) {
        return Left(UnAuthorizedException(
            message: e.response?.data['message'] ?? "Invalid credentials."));
      }
      return Left(ServerException(
          message: e.response?.data['message'] ?? "An error occurred."));
    }
  }

  @override
  Future<Either<AppException, PlaceBidResponseModel>> placeBid(
      PlaceBidModel placeBidModel, String itemId) async {
    try {
      var response = await sl<ApiClient>().postRequest(
          path: "${ApiEndpointUrls.bidItem}$itemId",
          body: placeBidModel.toMap());
      final placeBidResponse = PlaceBidResponseModel.fromJson(response.data);
      return Right(placeBidResponse);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left(
            NetworkException(message: "Unable to connect to the server."));
      }
      if (e.type == DioExceptionType.connectionError) {
        return Left(NetworkException(message: "No internet connection."));
      }
      if (e.response?.statusCode == 401) {
        return Left(UnAuthorizedException(
            message: e.response?.data['message'] ?? "Invalid credentials."));
      }
      return Left(ServerException(
          message: e.response?.data['message'] ?? "An error occurred."));
    }
  }

  @override
  Future<Either<AppException, List<BidderItemModel>>> searchItems(
      String keywordName, String searchItemName) async {
    try {
      var response = await sl<ApiClient>().getRequest(
        path: "${ApiEndpointUrls.searchItem}$keywordName=$searchItemName",
      );
      final List<BidderItemModel> auctionItemModel =
          (response.data['items'] as List)
              .map((item) => BidderItemModel.fromJson(item))
              .toList();
      return Right(auctionItemModel);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left(
          NetworkException(message: "Unable to connect to the server."),
        );
      }
      if (e.type == DioExceptionType.connectionError) {
        return Left(
          NetworkException(message: "No internet connection."),
        );
      }
      if (e.response?.statusCode == 401) {
        return Left(
          UnAuthorizedException(
              message: e.response?.data['message'] ?? "Invalid credentials."),
        );
      }
      return Left(
        ServerException(
            message: e.response?.data['message'] ?? "An error occurred."),
      );
    }
  }
  
  @override
  Future<Either<AppException, List<CategoryElementModel>>> getAllCategory() async{
    try {
      var response = await sl<ApiClient>().getRequest(path: ApiEndpointUrls.category);
      final List<CategoryElementModel> category = (response.data["categories"] as List).map((e)=> CategoryElementModel.fromJson(e)).toList();
      return Right(category);

    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return Left(
          NetworkException(message: "Unable to connect to the server."),
        );
      }
      if (e.type == DioExceptionType.connectionError) {
        return Left(
          NetworkException(message: "No internet connection."),
        );
      }
      if (e.response?.statusCode == 401) {
        return Left(
          UnAuthorizedException(
              message: e.response?.data['message'] ?? "Invalid credentials."),
        );
      }
      return Left(
        ServerException(
            message: e.response?.data['message'] ?? "An error occurred."),
      );
    }
  }
}

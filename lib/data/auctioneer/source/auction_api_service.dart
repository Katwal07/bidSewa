import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:nepa_bid/core/network/api_client.dart';
import 'package:nepa_bid/core/network/network_const/api_endpoint_urls.dart';
import 'package:nepa_bid/data/auctioneer/model/post_auction.dart';
import 'package:nepa_bid/service_locator.dart';

abstract class AuctionApiService {
  Future<Either> createAuction(PostAuctionItemModel model);
}

class AuctionApiServiceImpl extends AuctionApiService {
  @override
  Future<Either> createAuction(PostAuctionItemModel model) async {
    try {
      List<MultipartFile> imageMultipartFiles = [];
      List<MultipartFile> videoMultipartFiles = [];
      List<File> images = model.images;
      List<File> videos = model.videos;

      for (var file in videos) {
        final String fileExtension = file.path.split('.').last.toLowerCase();
        if (!['mp4', 'avi', 'mov', 'mkv'].contains(fileExtension)) {
          return const Left("Invalid video file type");
        }

        final videoFile = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType(
            'videos',
            fileExtension,
          ),
        );

        videoMultipartFiles.add(videoFile);
      }

      for (var file in images) {
        final String fileExtension = file.path.split('.').last.toLowerCase();
        if (!['jpg', 'jpeg', '.png', 'webp'].contains(fileExtension)) {
          return const Left("Invalid File Type");
        }

        final imageFile = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType('image', fileExtension),
        );

        imageMultipartFiles.add(imageFile);
      }

      final FormData formData = FormData.fromMap({
        'images': imageMultipartFiles,
        'videos': videoMultipartFiles,
        'title': model.title,
        'endTime': model.endTime,
        'startTime': model.startTime,
        'condition': model.condition,
        'startingBid': model.startingBid,
        'category': model.category,
        'description': model.description,
      });

      var response = await sl<ApiClient>().postRequest(
        path: ApiEndpointUrls.createItem,
        body: formData,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}

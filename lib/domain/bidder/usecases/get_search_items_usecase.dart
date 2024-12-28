import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/error/failure.dart';
import 'package:nepa_bid/domain/bidder/entity/bidder.dart';
import 'package:nepa_bid/domain/bidder/repositories/bidder.dart';
import 'package:nepa_bid/service_locator.dart';

abstract class SearchUseCase<Type, Param1, Param2>{
  Future<Type> call({Param1 param1, Param2 param2});
}

class GetSearchItemsUsecase extends SearchUseCase<Either<Failure, List<BidderItemEntity>>, String , String>{
  @override
  Future<Either<Failure, List<BidderItemEntity>>> call({String? param1, String? param2}) async{
    return await sl<BidderRepository>().searchItems(param1!, param2!);
  }
}
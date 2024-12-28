import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/error/failure.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/domain/bidder/entity/category.dart';
import 'package:nepa_bid/domain/bidder/repositories/bidder.dart';
import 'package:nepa_bid/service_locator.dart';

class GetCategoryUsecase extends UseCase<Either<Failure, List<CategoryElementEntity>>, dynamic>{
  @override
  Future<Either<Failure, List<CategoryElementEntity>>> call({param}) async{
    return await sl<BidderRepository>().getAllCategory();
  }
}
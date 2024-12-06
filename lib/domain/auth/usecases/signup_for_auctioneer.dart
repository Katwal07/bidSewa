import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/usecase/usecase.dart';
import 'package:nepa_bid/data/auth/model/signup_req_params_for_auctioneer.dart';
import 'package:nepa_bid/domain/auth/repositories/auth.dart';
import 'package:nepa_bid/service_locator.dart';

class SignupUseCaseForAuctioneer implements UseCase<Either, SignupReqParamsForAuctioneer> {

  @override
  Future<Either> call({SignupReqParamsForAuctioneer ? param}) async {
    return await sl<AuthRepository>().signupForAuctioneer(param!);
  }
}
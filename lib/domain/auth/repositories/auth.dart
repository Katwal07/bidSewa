import 'package:dartz/dartz.dart';
import 'package:nepa_bid/core/error/app_error.dart';
import 'package:nepa_bid/data/auth/model/signup_req_params_for_auctioneer.dart';
import '../../../data/auth/model/signin_req_params.dart';
import '../../../data/auth/model/signup_req_params.dart';

abstract class AuthRepository{
  Future<Either<AppError, dynamic>> signin(SigninReqParams params);
  Future<Either> signup(SignupReqParams params);
  Future<Either> signupForAuctioneer(SignupReqParamsForAuctioneer params);
  Future<bool> isLoggedIn();
  Future<Either> loggedOut();
  Future<Either> getAuctioneerUserProfile();
}
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:nepa_bid/common/mapper/auction_user.dart';
import 'package:nepa_bid/data/auth/model/auctionner_user.dart';
import 'package:nepa_bid/data/auth/model/signup_req_params_for_auctioneer.dart';
import 'package:nepa_bid/data/auth/source/auth_local_service.dart';
import 'package:nepa_bid/data/auth/source/token_service.dart';

import '../../../service_locator.dart';
import '../../../domain/auth/repositories/auth.dart';
import '../model/signin_req_params.dart';
import '../model/signup_req_params.dart';
import '../source/auth_api_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(
      SigninReqParams params) async {
    Either result = await sl<AuthApiService>().signin(params);
    return result.fold((error) {
      debugPrint(error);
      return Left(error);
    }, (data) async {
      if(data['success']){
      final token = data['token'];

      await TokenService.saveToken(token);
      }
      return Right(data);
    });
  }

  @override
  Future<Either> signup(SignupReqParams params) async {
    Either result = await sl<AuthApiService>().signup(params);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      return Right(data);
    });
  }

  @override
  Future<Either> signupForAuctioneer(
      SignupReqParamsForAuctioneer params) async {
    Either result = await sl<AuthApiService>().signupForAuctioneer(params);
    return result.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data);
    });
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either> loggedOut() async {
    return await sl<AuthLocalService>().loggedOut();
  }

  @override
  Future<Either> getAuctioneerUserProfile() async {
    Either returnedData = await sl<AuthApiService>().getAuctioneerUserProfile();
    return returnedData.fold((error) {
      return Left(error);
    }, (data) {
      var userProfile = AuctionUserMapper.toAuctionUserEntity(
          AuctioneerUserModel.fromJson(data));
      return Right(userProfile);
    });
  }
}

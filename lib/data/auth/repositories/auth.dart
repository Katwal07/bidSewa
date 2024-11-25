import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:nepa_bid/data/auth/source/auth_local_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../service_locator.dart';
import '../../../domain/auth/repositories/auth.dart';
import '../model/signin_req_params.dart';
import '../model/signup_req_params.dart';
import '../source/auth_api_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninReqParams params) async {
    Either result = await sl<AuthApiService>().signin(params);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('token',response.data["token"]);
      return Right(response);
    });
  }

  @override
  Future<Either> signup(SignupReqParams params) async {
    Either result = await sl<AuthApiService>().signup(params);
    return result.fold((error) {
      return Left(error);
    }, (data) async {
      Response response = data;
      return Right(response);
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
}

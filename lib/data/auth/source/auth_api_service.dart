// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:nepa_bid/core/network/api_client.dart';
import 'package:nepa_bid/core/network/api_endpoint_urls.dart';
import 'package:nepa_bid/data/auth/model/signin_req_params.dart';
import 'package:nepa_bid/service_locator.dart';

import '../model/signup_req_params.dart';
import '../model/signup_req_params_for_auctioneer.dart';

abstract class AuthApiService {
  Future<Either> signin(SigninReqParams params);
  Future<Either> signup(SignupReqParams params);
  Future<Either> signupForAuctioneer(SignupReqParamsForAuctioneer params);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signin(SigninReqParams params) async {
    try {
      var response = await sl<ApiClient>().postRequest(
        path: ApiEndpointUrls.login,
        body: params.toMap(),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> signup(SignupReqParams params) async {
    try {
      final String fileExtension =
          params.profileImage.path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png', 'webp'].contains(fileExtension)) {
        return const Left(
            'Invalid file type. Please use JPG, PNG or WebP images.');
      }

      final FormData formData = FormData.fromMap(
        {
          'username': params.fullName,
          'email': params.email,
          'password': params.password,
          'phone': params.phoneNumber,
          'role': params.role,
          'profileImage': await MultipartFile.fromFile(
            params.profileImage.path,
            filename: params.profileImage.path.split('/').last,
            contentType: MediaType('image', fileExtension),
          ),
        },
      );

      var response = await sl<ApiClient>().postRequest(
        path: ApiEndpointUrls.register,
        body: formData,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> signupForAuctioneer(
      SignupReqParamsForAuctioneer params) async {
    try {
      final String fileExtension =
          params.profileImage.path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png', 'webp'].contains(fileExtension)) {
        return const Left(
            'Invalid file type. Please use JPG, PNG or WebP images.');
      }

      final FormData formData = FormData.fromMap(
        {
          'username': params.fullName,
          'email': params.email,
          'password': params.password,
          'phone': params.phoneNumber,
          'role': params.role,
          'bankAccountName': params.bankAccountName,
          'bankAccountNumber': params.bankAccountNumber,
          'bankName': params.bankName,
          'swiftCode': params.swiftCode,
          'address': params.address,
          'paypalEmail': params.paypalEmail,
          'imepayNumber': params.imepayNumber,
          'khaltiNumber': params.khaltiNumber,
          'esewaNumber': params.esewaNumber,
          'profileImage': await MultipartFile.fromFile(
            params.profileImage.path,
            filename: params.profileImage.path.split('/').last,
            contentType: MediaType('image', fileExtension),
          ),
        },
      );

      var response = await sl<ApiClient>().postRequest(
        path: ApiEndpointUrls.register,
        body: formData,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}

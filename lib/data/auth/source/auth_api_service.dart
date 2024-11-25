// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:nepa_bid/core/network/api_client.dart';
import 'package:nepa_bid/core/network/api_endpoint_urls.dart';
import 'package:nepa_bid/data/auth/model/signin_req_params.dart';
import 'package:nepa_bid/service_locator.dart';

import '../model/signup_req_params.dart';

abstract class AuthApiService {
  Future<Either> signin(SigninReqParams params);
  Future<Either> signup(SignupReqParams params);
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

      final FormData formData = FormData.fromMap({
        'username': params.fullName,
        'email': params.email,
        'password': params.password,
        'phone': params.phoneNumber,
        'role': params.role,
        'profileImage': await MultipartFile.fromFile(
          params.profileImage.path,
          filename: params.profileImage.path.split('/').last,
          contentType:
              MediaType('image', fileExtension),
        ),
      });

      var response = await sl<ApiClient>().postRequest(
        path: ApiEndpointUrls.register,
        body: formData,
      );
      return Right(response);
    } on DioException catch (e) {
      print('DioError Type: ${e.type}');
      print('DioError Message: ${e.message}');
      print('Response Status: ${e.response?.statusCode}');
      print('Response Data: ${e.response?.data}');
      print('Request Data: ${e.requestOptions.data}');
      return Left(e.response?.data['message'] ?? 'Network error occurred');
    } catch (e) {
      print('General error: $e');
      return const Left('An unexpected error occurred');
    }
  }
}

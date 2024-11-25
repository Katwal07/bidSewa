// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nepa_bid/core/network/api_constant.dart';
import 'package:nepa_bid/core/network/api_exception.dart';

class ApiClient {
  late Dio dio;
  late BaseOptions baseOptions;

  ApiClient() {
    baseOptions = BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (status) => status! < 500,
    );
    dio = Dio(baseOptions);

     dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  /// GET REQUEST
  Future<Response> getRequest({required String path}) async {
    try {
      debugPrint("==========API REQUEST==========");
      debugPrint("Request URL: ${baseOptions.baseUrl + path}");
      final Response response = await dio.get(path);
      debugPrint("==========API RESPONSE==========");
      debugPrint("Status Code: ${response.statusCode}");
      log("Data: ${response.data}");
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        debugPrint(e.response!.headers.toString());
        debugPrint(e.response!.requestOptions.toString());
        throw ApiException(message: e.response!.statusMessage);
      } else {
        debugPrint(e.requestOptions.toString());
        debugPrint(e.message);
        throw ApiException(message: e.message);
      }
    }
  }

  /// POST REQUEST
  Future<Response> postRequest({
    required String path,
    required dynamic body,
  }) async {
    try {
      debugPrint("==========API REQUEST==========");
      debugPrint("Request URL: ${baseOptions.baseUrl + path}");
      final Response response = await dio.post(path, data: body);
      debugPrint("==========API RESPONSE==========");
      debugPrint("Status Code: ${response.statusCode}");
      log("Data: ${response.data}");
      return response;
    } catch (e) {
      print('ApiClient error details:');
      if (e is DioException) {
        print('Response status: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        print('Request data: ${e.requestOptions.data}');
      }
      rethrow;
    }
  }
}

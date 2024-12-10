import 'package:dio/dio.dart';

import 'interceptors.dart';
import 'network_const/api_constant.dart';

class ApiClient {
  late Dio dio;
  late BaseOptions baseOptions;

  ApiClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            responseType: ResponseType.json,
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
            sendTimeout: const Duration(seconds: 30),
          ),
        )..interceptors.addAll(
            [
              LoggerInterceptor(),
              AuthorizationInterceptor(),
            ],
          );

  /// GET REQUEST
  Future<Response> getRequest({required String path}) async {
    try {
      final Response response = await dio.get(path);
      return response;
    } on DioException {
      rethrow;
    }
  }

  /// POST REQUEST
  Future<Response> postRequest({
    required String path,
    required dynamic body,
    bool isTokenRequired = false,
  }) async {
    try {
      final Response response = await dio.post(path, data: body);
      return response;
    } on DioException {
      rethrow;
    }
  }
}

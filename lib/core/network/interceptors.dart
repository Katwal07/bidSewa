import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

//! This interceptor is used to show request and response logs
/// Preety Printer makes logs more readable and visually appealing.
/// methodCount: 0 "dont show me which methods were called to reach this log"
/// If we were debugging complex call stacks , we might increase this to 2 or 3 to see more context.
/// colors: true allows different types of logs gets different colors
/// printEmojis: true adds fun and descriptive emojis to our logs messages.

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
      printer: PrettyPrinter(
    methodCount: 3,
    colors: true,
    printEmojis: true,
  ));

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    /// 1.Capture Request Details
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';

    /// 2.Log the Full Request Path
    logger.e('${options.baseUrl} request ==> $requestPath');

  print('🐛 Error type: ${err.type}');
  print('🐛 Error message: ${err.message}');
  print('🐛 Status code: ${err.response?.statusCode}');
  print('🐛 Response data: ${err.response?.data}');
  print('🐛 Request data: ${err.requestOptions.data}');

    /// 3.Log Detailed Error Information
    logger.d(
      'Error type: ${err.error} \n '
      'Error message: ${err.message}',
    );

    /// 4.Continue Error Handling
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// 1. Construct the Full Request Path
    final requestPath = '${options.baseUrl}${options.path}';

    /// 2. Log the Request Details
    logger.i('${options.method} request ==> $requestPath');

    /// 3. Allow the Request to Proceed
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    /// 1. Log the Detailed Response Information
    logger.d(
      'STATUSCODE: ${response.statusCode} \n '
      'STATUSMESSAGE: ${response.statusMessage} \n'
      'HEADERS: ${response.headers} \n'
      'Data: ${response.data}',
    );

    /// 2. Allow the Response to Continue
    handler.next(response);
  }
}

class AuthorizationInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    if (token != null) {
      options.headers['Authorization'] = "Bearer $token";
    }
    handler.next(options);
  }
}


/// Note: rethrow will pass the error to the calller and
/// caller can now handle or respond to the error

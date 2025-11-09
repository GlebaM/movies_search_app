import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint('--> ${options.method} ${options.uri}');
      debugPrint('Headers: ${options.headers}');
      if (options.data != null) {
        debugPrint('Body: ${options.data}');
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      debugPrint('<-- ${response.statusCode} ${response.realUri}');
      debugPrint('Response: ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        '!!! ERROR ${err.response?.statusCode} ${err.requestOptions.uri}',
      );
      debugPrint('${err.message}');
      if (err.response?.data != null) {
        debugPrint('Error response: ${err.response?.data}');
      }
    }
    super.onError(err, handler);
  }
}

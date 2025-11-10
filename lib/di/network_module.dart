import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

import '../core/network/dio_logging_interceptor.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final apiKey = dotenv.env['OMDB_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Missing OMDB_API_KEY in .env');
    }

    return Dio(
      BaseOptions(
        baseUrl: 'https://www.omdbapi.com/',
        queryParameters: <String, dynamic>{'apikey': apiKey},
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    )..interceptors.add(DioLoggingInterceptor());
  }
}

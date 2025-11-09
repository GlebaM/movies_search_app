import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/view/app.dart';
import 'core/network/dio_logging_interceptor.dart';
import 'features/movies/data/clients/omdb_api_client.dart';
import 'features/movies/data/repositories/omdb_movie_repository.dart';
import 'features/movies/domain/repositories/movie_repository.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  final apiKey = dotenv.env['OMDB_API_KEY'];
  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('Missing OMDB_API_KEY in .env');
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.omdbapi.com/',
      queryParameters: <String, dynamic>{'apikey': apiKey},
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  )..interceptors.add(DioLoggingInterceptor());

  final movieRepository = OmdbMovieRepository(apiClient: OmdbApiClient(dio));

  runApp(
    RepositoryProvider<MovieRepository>.value(
      value: movieRepository,
      child: const MoviesSearchApp(),
    ),
  );
}

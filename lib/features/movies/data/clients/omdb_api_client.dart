import 'package:dio/dio.dart';

import '../models/movie_detail.dart';
import '../models/omdb_search_response.dart';

class OmdbApiClient {
  OmdbApiClient(this._dio);

  final Dio _dio;

  Future<OmdbSearchResponse> searchMovies(String query) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '',
      queryParameters: {'s': query, 'type': 'movie'},
    );

    return OmdbSearchResponse.fromJson(response.data ?? <String, dynamic>{});
  }

  Future<MovieDetail> getMovieDetail(String imdbId) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '',
      queryParameters: {'i': imdbId, 'plot': 'full'},
    );

    return MovieDetail.fromJson(response.data ?? <String, dynamic>{});
  }
}

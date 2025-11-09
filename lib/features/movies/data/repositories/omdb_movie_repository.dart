import 'package:dio/dio.dart';

import '../../../../core/error/repository_exception.dart';
import '../../domain/repositories/movie_repository.dart';
import '../clients/omdb_api_client.dart';
import '../models/movie_detail.dart';
import '../models/movie_summary.dart';

class OmdbMovieRepository implements MovieRepository {
  OmdbMovieRepository({required OmdbApiClient apiClient})
    : _apiClient = apiClient;

  final OmdbApiClient _apiClient;

  @override
  Future<MovieDetail> getMovieDetail(String imdbId) async {
    try {
      final detail = await _apiClient.getMovieDetail(imdbId);
      return detail;
    } on DioException catch (error, stackTrace) {
      Error.throwWithStackTrace(_mapToRepositoryException(error), stackTrace);
    }
  }

  @override
  Future<List<MovieSummary>> searchMovies(String query) async {
    try {
      final response = await _apiClient.searchMovies(query);
      if (!response.isSuccess) {
        throw RepositoryException(response.error ?? 'Unknown error');
      }

      return response.search ?? <MovieSummary>[];
    } on DioException catch (error, stackTrace) {
      Error.throwWithStackTrace(_mapToRepositoryException(error), stackTrace);
    }
  }

  RepositoryException _mapToRepositoryException(DioException error) {
    final message = error.response?.data is Map<String, dynamic>
        ? (error.response?.data['Error'] as String?)
        : error.message;
    return RepositoryException(message ?? 'Network error');
  }
}

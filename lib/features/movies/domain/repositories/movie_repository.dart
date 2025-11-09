import '../../data/models/movie_detail.dart';
import '../../data/models/movie_summary.dart';

abstract class MovieRepository {
  Future<List<MovieSummary>> searchMovies(String query);

  Future<MovieDetail> getMovieDetail(String imdbId);
}

import 'package:injectable/injectable.dart';

import '../../data/models/movie_summary.dart';
import '../repositories/movie_repository.dart';

@injectable
class SearchMovies {
  const SearchMovies({required MovieRepository repository})
    : _repository = repository;

  final MovieRepository _repository;

  Future<List<MovieSummary>> call(String query) {
    return _repository.searchMovies(query);
  }
}

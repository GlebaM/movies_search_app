import 'package:injectable/injectable.dart';

import '../../data/models/movie_detail.dart';
import '../repositories/movie_repository.dart';

@injectable
class GetMovieDetail {
  const GetMovieDetail({required MovieRepository repository})
    : _repository = repository;

  final MovieRepository _repository;

  Future<MovieDetail> call(String imdbId) {
    return _repository.getMovieDetail(imdbId);
  }
}

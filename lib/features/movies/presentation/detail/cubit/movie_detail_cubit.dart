import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/repository_exception.dart';
import '../../../domain/repositories/movie_repository.dart';
import 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit(this._repository) : super(const MovieDetailState());

  final MovieRepository _repository;

  Future<void> loadMovie(String imdbId) async {
    emit(
      state.copyWith(
        status: MovieDetailStatus.loading,
        imdbId: imdbId,
        clearErrorMessage: true,
      ),
    );

    try {
      final movie = await _repository.getMovieDetail(imdbId);
      emit(state.copyWith(status: MovieDetailStatus.success, movie: movie));
    } on RepositoryException catch (error) {
      emit(
        state.copyWith(
          status: MovieDetailStatus.failure,
          errorMessage: error.message,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: MovieDetailStatus.failure,
          errorMessage: 'Unexpected error occurred',
        ),
      );
    }
  }
}

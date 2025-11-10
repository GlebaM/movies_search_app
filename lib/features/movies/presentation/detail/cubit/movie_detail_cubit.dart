import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/error/repository_exception.dart';
import '../../../domain/usecases/get_movie_detail.dart';
import 'movie_detail_state.dart';

@injectable
class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit(this._getMovieDetail) : super(const MovieDetailState());

  final GetMovieDetail _getMovieDetail;

  Future<void> initialize(String imdbId) async {
    await loadMovie(imdbId);
  }

  Future<void> loadMovie(String imdbId) async {
    emit(
      state.copyWith(
        status: MovieDetailStatus.loading,
        imdbId: imdbId,
        clearErrorMessage: true,
      ),
    );

    try {
      final movie = await _getMovieDetail(imdbId);
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

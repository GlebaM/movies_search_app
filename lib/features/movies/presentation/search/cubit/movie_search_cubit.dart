import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/repository_exception.dart';
import '../../../data/models/movie_summary.dart';
import '../../../domain/repositories/movie_repository.dart';
import 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  MovieSearchCubit(
    this._repository, {
    Duration debounce = const Duration(milliseconds: 400),
  }) : _debounceDuration = debounce,
       super(const MovieSearchState());

  final MovieRepository _repository;
  final Duration _debounceDuration;
  Timer? _debounce;

  void search(String query) {
    final trimmed = query.trim();
    _debounce?.cancel();

    if (trimmed.isEmpty) {
      emit(const MovieSearchState());
      return;
    }

    _debounce = Timer(_debounceDuration, () => _performSearch(trimmed));
  }

  Future<void> _performSearch(String query) async {
    emit(
      state.copyWith(
        status: MovieSearchStatus.loading,
        query: query,
        clearErrorMessage: true,
      ),
    );

    try {
      final results = await _repository.searchMovies(query);
      if (results.isEmpty) {
        emit(
          state.copyWith(
            status: MovieSearchStatus.empty,
            results: const <MovieSummary>[],
          ),
        );
      } else {
        emit(
          state.copyWith(status: MovieSearchStatus.success, results: results),
        );
      }
    } on RepositoryException catch (error) {
      emit(
        state.copyWith(
          status: MovieSearchStatus.failure,
          errorMessage: error.message,
          results: const <MovieSummary>[],
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: MovieSearchStatus.failure,
          errorMessage: 'Unexpected error occurred',
          results: const <MovieSummary>[],
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

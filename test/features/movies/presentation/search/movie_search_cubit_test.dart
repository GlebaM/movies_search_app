import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movies_search_app/core/error/repository_exception.dart';
import 'package:movies_search_app/features/movies/data/models/movie_summary.dart';
import 'package:movies_search_app/features/movies/domain/usecases/search_movies.dart';
import 'package:movies_search_app/features/movies/presentation/search/cubit/movie_search_cubit.dart';
import 'package:movies_search_app/features/movies/presentation/search/cubit/movie_search_state.dart';

class _MockSearchMovies extends Mock implements SearchMovies {}

void main() {
  late SearchMovies searchMovies;

  setUp(() {
    searchMovies = _MockSearchMovies();
  });

  group('MovieSearchCubit', () {
    final movie = MovieSummary(
      title: 'Batman Begins',
      year: '2005',
      imdbId: 'tt0372784',
      type: 'movie',
      poster: 'poster.jpg',
    );

    test('emits initial state when query is empty', () {
      final cubit = MovieSearchCubit(searchMovies);

      cubit.search('   ');

      expect(cubit.state, const MovieSearchState());
      cubit.close();
    });

    test('emits loading then success when search succeeds', () async {
      when(
        () => searchMovies('Batman'),
      ).thenAnswer((_) async => <MovieSummary>[movie]);

      final cubit = MovieSearchCubit(searchMovies);

      final emittedStates = <MovieSearchState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      cubit.search('Batman');
      await Future<void>.delayed(const Duration(milliseconds: 600));

      expect(emittedStates, <MovieSearchState>[
        const MovieSearchState(
          status: MovieSearchStatus.loading,
          query: 'Batman',
        ),
        MovieSearchState(
          status: MovieSearchStatus.success,
          query: 'Batman',
          results: <MovieSummary>[movie],
        ),
      ]);

      await subscription.cancel();
      await cubit.close();
    });

    test('emits failure when repository throws', () async {
      when(
        () => searchMovies('Batman'),
      ).thenThrow(RepositoryException('Network error'));

      final cubit = MovieSearchCubit(searchMovies);

      final emittedStates = <MovieSearchState>[];
      final subscription = cubit.stream.listen(emittedStates.add);

      cubit.search('Batman');
      await Future<void>.delayed(const Duration(milliseconds: 600));

      expect(emittedStates, <MovieSearchState>[
        const MovieSearchState(
          status: MovieSearchStatus.loading,
          query: 'Batman',
        ),
        const MovieSearchState(
          status: MovieSearchStatus.failure,
          query: 'Batman',
          results: <MovieSummary>[],
          errorMessage: 'Network error',
        ),
      ]);

      await subscription.cancel();
      await cubit.close();
    });
  });
}

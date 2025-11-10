import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movies_search_app/core/error/repository_exception.dart';
import 'package:movies_search_app/features/movies/data/models/movie_detail.dart';
import 'package:movies_search_app/features/movies/data/models/movie_rating.dart';
import 'package:movies_search_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movies_search_app/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:movies_search_app/features/movies/presentation/detail/cubit/movie_detail_cubit.dart';
import 'package:movies_search_app/features/movies/presentation/detail/cubit/movie_detail_state.dart';

class _MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieRepository repository;
  late MovieDetailCubit cubit;

  setUp(() {
    repository = _MockMovieRepository();
    cubit = MovieDetailCubit(GetMovieDetail(repository: repository));
  });

  tearDown(() async {
    await cubit.close();
  });

  const imdbId = 'tt0372784';

  final detail = MovieDetail(
    title: 'Batman Begins',
    year: '2005',
    rated: 'PG-13',
    released: '15 Jun 2005',
    runtime: '140 min',
    genre: 'Action, Adventure',
    director: 'Christopher Nolan',
    writer: 'Bob Kane, David S. Goyer, Christopher Nolan',
    actors: 'Christian Bale, Michael Caine, Liam Neeson',
    plot: 'The story of Batman begins.',
    language: 'English',
    country: 'USA',
    awards: 'Won 1 Oscar',
    poster: 'poster.jpg',
    ratings: <MovieRating>[
      MovieRating(source: 'Internet Movie Database', value: '8.2/10'),
    ],
    metascore: '70',
    imdbRating: '8.2',
    imdbVotes: '1,000,000',
    imdbID: imdbId,
    type: 'movie',
    boxOffice: '\$100,000,000',
  );

  test('emits loading then success when repository returns detail', () async {
    when(
      () => repository.getMovieDetail(imdbId),
    ).thenAnswer((_) async => detail);

    final emitted = <MovieDetailState>[];
    final subscription = cubit.stream.listen(emitted.add);

    await cubit.loadMovie(imdbId);
    await Future<void>.delayed(Duration.zero);

    expect(emitted, <MovieDetailState>[
      const MovieDetailState(status: MovieDetailStatus.loading, imdbId: imdbId),
      MovieDetailState(
        status: MovieDetailStatus.success,
        imdbId: imdbId,
        movie: detail,
      ),
    ]);

    await subscription.cancel();
  });

  test('emits failure when repository throws', () async {
    when(
      () => repository.getMovieDetail(imdbId),
    ).thenThrow(RepositoryException('error'));

    final emitted = <MovieDetailState>[];
    final subscription = cubit.stream.listen(emitted.add);

    await cubit.loadMovie(imdbId);
    await Future<void>.delayed(Duration.zero);

    expect(emitted, const <MovieDetailState>[
      MovieDetailState(status: MovieDetailStatus.loading, imdbId: imdbId),
      MovieDetailState(
        status: MovieDetailStatus.failure,
        imdbId: imdbId,
        errorMessage: 'error',
      ),
    ]);

    await subscription.cancel();
  });
}

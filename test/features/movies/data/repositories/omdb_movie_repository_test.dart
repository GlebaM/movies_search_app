import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movies_search_app/core/error/repository_exception.dart';
import 'package:movies_search_app/features/movies/data/clients/omdb_api_client.dart';
import 'package:movies_search_app/features/movies/data/models/movie_detail.dart';
import 'package:movies_search_app/features/movies/data/models/movie_rating.dart';
import 'package:movies_search_app/features/movies/data/models/movie_summary.dart';
import 'package:movies_search_app/features/movies/data/models/omdb_search_response.dart';
import 'package:movies_search_app/features/movies/data/repositories/omdb_movie_repository.dart';

class _MockOmdbApiClient extends Mock implements OmdbApiClient {}

void main() {
  late OmdbMovieRepository repository;
  late _MockOmdbApiClient apiClient;

  setUp(() {
    apiClient = _MockOmdbApiClient();
    repository = OmdbMovieRepository(apiClient: apiClient);
  });

  group('searchMovies', () {
    const query = 'Batman';

    final movies = <MovieSummary>[
      MovieSummary(
        title: 'Batman Begins',
        year: '2005',
        imdbId: 'tt0372784',
        type: 'movie',
        poster: 'poster.jpg',
      ),
    ];

    test('returns movies when response is successful', () async {
      when(() => apiClient.searchMovies(query)).thenAnswer(
        (_) async => OmdbSearchResponse(
          response: 'True',
          search: movies,
          totalResults: '1',
        ),
      );

      final result = await repository.searchMovies(query);

      expect(result, movies);
      verify(() => apiClient.searchMovies(query)).called(1);
    });

    test('throws RepositoryException when response indicates failure', () {
      when(() => apiClient.searchMovies(query)).thenAnswer(
        (_) async =>
            OmdbSearchResponse(response: 'False', error: 'Movie not found!'),
      );

      expect(
        () => repository.searchMovies(query),
        throwsA(
          isA<RepositoryException>().having(
            (e) => e.message,
            'message',
            'Movie not found!',
          ),
        ),
      );
    });

    test('wraps DioException into RepositoryException', () {
      when(
        () => apiClient.searchMovies(query),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '/')));

      expect(
        () => repository.searchMovies(query),
        throwsA(isA<RepositoryException>()),
      );
    });
  });

  group('getMovieDetail', () {
    const imdbId = 'tt0372784';

    final movieDetail = MovieDetail(
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

    test('returns movie detail when successful', () async {
      when(
        () => apiClient.getMovieDetail(imdbId),
      ).thenAnswer((_) async => movieDetail);

      final result = await repository.getMovieDetail(imdbId);

      expect(result, movieDetail);
      verify(() => apiClient.getMovieDetail(imdbId)).called(1);
    });

    test('wraps DioException into RepositoryException', () {
      when(
        () => apiClient.getMovieDetail(imdbId),
      ).thenThrow(DioException(requestOptions: RequestOptions(path: '/')));

      expect(
        () => repository.getMovieDetail(imdbId),
        throwsA(isA<RepositoryException>()),
      );
    });
  });
}

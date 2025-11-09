import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movies_search_app/features/movies/data/models/movie_detail.dart';
import 'package:movies_search_app/features/movies/data/models/movie_rating.dart';
import 'package:movies_search_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movies_search_app/features/movies/presentation/detail/view/movie_detail_page.dart';

class _MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieRepository repository;

  setUp(() {
    repository = _MockMovieRepository();
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
    boxOffice: r'$100,000,000',
  );

  Widget buildSubject() {
    return RepositoryProvider<MovieRepository>.value(
      value: repository,
      child: MaterialApp(
        home: MovieDetailPage(imdbId: imdbId, title: 'Batman Begins'),
      ),
    );
  }

  testWidgets('shows loading indicator initially', (tester) async {
    when(
      () => repository.getMovieDetail(imdbId),
    ).thenAnswer((_) async => detail);

    await tester.pumpWidget(buildSubject());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders movie details when loaded', (tester) async {
    when(
      () => repository.getMovieDetail(imdbId),
    ).thenAnswer((_) async => detail);

    await tester.pumpWidget(buildSubject());

    await tester.pumpAndSettle();

    expect(find.text('Plot'), findsOneWidget);
    expect(find.text('The story of Batman begins.'), findsOneWidget);
    expect(find.text('Ratings'), findsOneWidget);
  });
}

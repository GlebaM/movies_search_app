import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hooked_bloc/hooked_bloc.dart';

import 'package:movies_search_app/features/movies/data/models/movie_summary.dart';
import 'package:movies_search_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movies_search_app/features/movies/domain/usecases/search_movies.dart';
import 'package:movies_search_app/features/movies/presentation/search/cubit/movie_search_cubit.dart';
import 'package:movies_search_app/features/movies/presentation/search/view/movie_search_page.dart';

class _MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieRepository repository;
  late SearchMovies searchMovies;

  setUp(() {
    repository = _MockMovieRepository();
    searchMovies = SearchMovies(repository: repository);
  });

  T injector<T extends Object>([String? instanceName, dynamic param1, dynamic param2]) {
    if (T == MovieSearchCubit) {
      return MovieSearchCubit(searchMovies) as T;
    }
    throw UnimplementedError('No injector registered for type $T');
  }

  Widget buildSubject() {
    return HookedBlocConfigProvider(
      injector: () => injector,
      child: const MaterialApp(home: MovieSearchPage()),
    );
  }

  testWidgets('shows placeholder before search', (tester) async {
    await tester.pumpWidget(buildSubject());

    expect(find.text('Find your next movie'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('displays results when search succeeds', (tester) async {
    final movie = MovieSummary(
      title: 'Batman Begins',
      year: '2005',
      imdbId: 'tt0372784',
      type: 'movie',
      poster: 'poster.jpg',
    );

    when(
      () => repository.searchMovies('Batman'),
    ).thenAnswer((_) async => <MovieSummary>[movie]);

    await tester.pumpWidget(buildSubject());

    await tester.enterText(find.byType(TextField), 'Batman');

    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    expect(find.text('Batman Begins'), findsOneWidget);
  });
}

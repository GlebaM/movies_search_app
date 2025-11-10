// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movies_search_app/app/view/app.dart';
import 'package:movies_search_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movies_search_app/features/movies/domain/usecases/search_movies.dart';
import 'package:movies_search_app/features/movies/presentation/search/cubit/movie_search_cubit.dart';
import 'package:movies_search_app/di/injection.dart';

class _MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieRepository repository;

  setUp(() {
    repository = _MockMovieRepository();
    getIt.reset();
    getIt.registerSingleton<MovieRepository>(repository);
    getIt.registerFactory<SearchMovies>(
      () => SearchMovies(repository: getIt<MovieRepository>()),
    );
    getIt.registerFactory<MovieSearchCubit>(
      () => MovieSearchCubit(getIt<SearchMovies>()),
    );
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('renders search placeholder on launch', (tester) async {
    await tester.pumpWidget(const MoviesSearchApp());

    expect(find.text('Find your next movie'), findsOneWidget);
  });
}

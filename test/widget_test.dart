// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movies_search_app/app/view/app.dart';
import 'package:movies_search_app/features/movies/domain/repositories/movie_repository.dart';

class _MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  testWidgets('renders search placeholder on launch', (tester) async {
    final repository = _MockMovieRepository();

    await tester.pumpWidget(
      RepositoryProvider<MovieRepository>.value(
        value: repository,
        child: const MoviesSearchApp(),
      ),
    );

    expect(find.text('Find your next movie'), findsOneWidget);
  });
}

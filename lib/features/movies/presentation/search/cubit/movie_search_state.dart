import 'package:equatable/equatable.dart';

import '../../../data/models/movie_summary.dart';

enum MovieSearchStatus { initial, loading, success, empty, failure }

class MovieSearchState extends Equatable {
  const MovieSearchState({
    this.status = MovieSearchStatus.initial,
    this.query = '',
    this.results = const <MovieSummary>[],
    this.errorMessage,
  });

  final MovieSearchStatus status;
  final String query;
  final List<MovieSummary> results;
  final String? errorMessage;

  bool get hasResults => results.isNotEmpty;

  MovieSearchState copyWith({
    MovieSearchStatus? status,
    String? query,
    List<MovieSummary>? results,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return MovieSearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      results: results ?? this.results,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[status, query, results, errorMessage];
}

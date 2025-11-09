import 'package:equatable/equatable.dart';

import '../../../data/models/movie_detail.dart';

enum MovieDetailStatus { initial, loading, success, failure }

class MovieDetailState extends Equatable {
  const MovieDetailState({
    this.status = MovieDetailStatus.initial,
    this.imdbId = '',
    this.movie,
    this.errorMessage,
  });

  final MovieDetailStatus status;
  final String imdbId;
  final MovieDetail? movie;
  final String? errorMessage;

  MovieDetailState copyWith({
    MovieDetailStatus? status,
    String? imdbId,
    MovieDetail? movie,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      imdbId: imdbId ?? this.imdbId,
      movie: movie ?? this.movie,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[status, imdbId, movie, errorMessage];
}

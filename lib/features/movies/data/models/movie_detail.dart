import 'package:json_annotation/json_annotation.dart';

import 'movie_rating.dart';

part 'movie_detail.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetail {
  MovieDetail({
    required this.title,
    required this.year,
    required this.rated,
    required this.released,
    required this.runtime,
    required this.genre,
    required this.director,
    required this.writer,
    required this.actors,
    required this.plot,
    required this.language,
    required this.country,
    required this.awards,
    required this.poster,
    required this.ratings,
    required this.metascore,
    required this.imdbRating,
    required this.imdbVotes,
    required this.imdbID,
    required this.type,
    required this.boxOffice,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailFromJson(json);

  @JsonKey(name: 'Title')
  final String title;
  @JsonKey(name: 'Year')
  final String year;
  @JsonKey(name: 'Rated')
  final String rated;
  @JsonKey(name: 'Released')
  final String released;
  @JsonKey(name: 'Runtime')
  final String runtime;
  @JsonKey(name: 'Genre')
  final String genre;
  @JsonKey(name: 'Director')
  final String director;
  @JsonKey(name: 'Writer')
  final String writer;
  @JsonKey(name: 'Actors')
  final String actors;
  @JsonKey(name: 'Plot')
  final String plot;
  @JsonKey(name: 'Language')
  final String language;
  @JsonKey(name: 'Country')
  final String country;
  @JsonKey(name: 'Awards')
  final String awards;
  @JsonKey(name: 'Poster')
  final String poster;
  @JsonKey(name: 'Ratings')
  final List<MovieRating> ratings;
  @JsonKey(name: 'Metascore')
  final String metascore;
  @JsonKey(name: 'imdbRating')
  final String imdbRating;
  @JsonKey(name: 'imdbVotes')
  final String imdbVotes;
  @JsonKey(name: 'imdbID')
  final String imdbID;
  @JsonKey(name: 'Type')
  final String type;
  @JsonKey(name: 'BoxOffice')
  final String boxOffice;

  Map<String, dynamic> toJson() => _$MovieDetailToJson(this);
}

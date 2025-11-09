// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetail _$MovieDetailFromJson(Map<String, dynamic> json) => MovieDetail(
  title: json['Title'] as String,
  year: json['Year'] as String,
  rated: json['Rated'] as String,
  released: json['Released'] as String,
  runtime: json['Runtime'] as String,
  genre: json['Genre'] as String,
  director: json['Director'] as String,
  writer: json['Writer'] as String,
  actors: json['Actors'] as String,
  plot: json['Plot'] as String,
  language: json['Language'] as String,
  country: json['Country'] as String,
  awards: json['Awards'] as String,
  poster: json['Poster'] as String,
  ratings: (json['Ratings'] as List<dynamic>)
      .map((e) => MovieRating.fromJson(e as Map<String, dynamic>))
      .toList(),
  metascore: json['Metascore'] as String,
  imdbRating: json['imdbRating'] as String,
  imdbVotes: json['imdbVotes'] as String,
  imdbID: json['imdbID'] as String,
  type: json['Type'] as String,
  boxOffice: json['BoxOffice'] as String,
);

Map<String, dynamic> _$MovieDetailToJson(MovieDetail instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'Rated': instance.rated,
      'Released': instance.released,
      'Runtime': instance.runtime,
      'Genre': instance.genre,
      'Director': instance.director,
      'Writer': instance.writer,
      'Actors': instance.actors,
      'Plot': instance.plot,
      'Language': instance.language,
      'Country': instance.country,
      'Awards': instance.awards,
      'Poster': instance.poster,
      'Ratings': instance.ratings.map((e) => e.toJson()).toList(),
      'Metascore': instance.metascore,
      'imdbRating': instance.imdbRating,
      'imdbVotes': instance.imdbVotes,
      'imdbID': instance.imdbID,
      'Type': instance.type,
      'BoxOffice': instance.boxOffice,
    };

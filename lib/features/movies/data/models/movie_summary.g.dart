// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieSummary _$MovieSummaryFromJson(Map<String, dynamic> json) => MovieSummary(
  title: json['Title'] as String,
  year: json['Year'] as String,
  imdbId: json['imdbID'] as String,
  type: json['Type'] as String,
  poster: json['Poster'] as String,
);

Map<String, dynamic> _$MovieSummaryToJson(MovieSummary instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Year': instance.year,
      'imdbID': instance.imdbId,
      'Type': instance.type,
      'Poster': instance.poster,
    };

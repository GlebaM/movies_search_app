import 'package:json_annotation/json_annotation.dart';

part 'movie_summary.g.dart';

@JsonSerializable()
class MovieSummary {
  MovieSummary({
    required this.title,
    required this.year,
    required this.imdbId,
    required this.type,
    required this.poster,
  });

  factory MovieSummary.fromJson(Map<String, dynamic> json) =>
      _$MovieSummaryFromJson(json);

  @JsonKey(name: 'Title')
  final String title;
  @JsonKey(name: 'Year')
  final String year;
  @JsonKey(name: 'imdbID')
  final String imdbId;
  @JsonKey(name: 'Type')
  final String type;
  @JsonKey(name: 'Poster')
  final String poster;

  Map<String, dynamic> toJson() => _$MovieSummaryToJson(this);
}

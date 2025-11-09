import 'package:json_annotation/json_annotation.dart';

part 'movie_rating.g.dart';

@JsonSerializable()
class MovieRating {
  MovieRating({required this.source, required this.value});

  factory MovieRating.fromJson(Map<String, dynamic> json) =>
      _$MovieRatingFromJson(json);

  @JsonKey(name: 'Source')
  final String source;

  @JsonKey(name: 'Value')
  final String value;

  Map<String, dynamic> toJson() => _$MovieRatingToJson(this);
}

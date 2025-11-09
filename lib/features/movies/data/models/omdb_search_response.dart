import 'package:json_annotation/json_annotation.dart';

import 'movie_summary.dart';

part 'omdb_search_response.g.dart';

@JsonSerializable(explicitToJson: true)
class OmdbSearchResponse {
  OmdbSearchResponse({
    required this.response,
    this.totalResults,
    this.search,
    this.error,
  });

  factory OmdbSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$OmdbSearchResponseFromJson(json);

  @JsonKey(name: 'Response')
  final String response;

  @JsonKey(name: 'totalResults')
  final String? totalResults;

  @JsonKey(name: 'Search')
  final List<MovieSummary>? search;

  @JsonKey(name: 'Error')
  final String? error;

  bool get isSuccess => response.toLowerCase() == 'true';

  Map<String, dynamic> toJson() => _$OmdbSearchResponseToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'omdb_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OmdbSearchResponse _$OmdbSearchResponseFromJson(Map<String, dynamic> json) =>
    OmdbSearchResponse(
      response: json['Response'] as String,
      totalResults: json['totalResults'] as String?,
      search: (json['Search'] as List<dynamic>?)
          ?.map((e) => MovieSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['Error'] as String?,
    );

Map<String, dynamic> _$OmdbSearchResponseToJson(OmdbSearchResponse instance) =>
    <String, dynamic>{
      'Response': instance.response,
      'totalResults': instance.totalResults,
      'Search': instance.search?.map((e) => e.toJson()).toList(),
      'Error': instance.error,
    };

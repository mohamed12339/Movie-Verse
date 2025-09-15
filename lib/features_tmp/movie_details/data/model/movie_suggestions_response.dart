import 'package:json_annotation/json_annotation.dart';

import 'movie_details_response.dart';

part 'movie_suggestions_response.g.dart';

@JsonSerializable()
class MovieSuggestionsResponse { ///وهنا المفروض يبقا هنا يبعتلي الافلام المقترحة الي هتبقا شبة ال فيلم من افلام ال details من الاخر دا ال similar الي موجود في الي ui
  final String? status;
  @JsonKey(name: 'status_message')
  final String? statusMessage;
  final SuggestionsData? data;

  MovieSuggestionsResponse({
    this.status,
    this.statusMessage,
    this.data,
  });

  factory MovieSuggestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieSuggestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieSuggestionsResponseToJson(this);
}

@JsonSerializable()
class SuggestionsData {
  @JsonKey(name: 'movie_count')
  final int? movieCount;
  final List<SuggestedMovie>? movies;

  SuggestionsData({this.movieCount, this.movies});

  factory SuggestionsData.fromJson(Map<String, dynamic> json) =>
      _$SuggestionsDataFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestionsDataToJson(this);
}

@JsonSerializable()
class SuggestedMovie {
  final int? id;
  final String? url;
  @JsonKey(name: 'imdb_code')
  final String? imdbCode;
  final String? title;
  @JsonKey(name: 'title_english')
  final String? titleEnglish;
  @JsonKey(name: 'title_long')
  final String? titleLong;
  final String? slug;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;
  final String? summary;
  @JsonKey(name: 'description_full')
  final String? descriptionFull;
  final String? synopsis;
  @JsonKey(name: 'yt_trailer_code')
  final String? ytTrailerCode;
  final String? language;
  @JsonKey(name: 'mpa_rating')
  final String? mpaRating;
  @JsonKey(name: 'background_image')
  final String? backgroundImage;
  @JsonKey(name: 'background_image_original')
  final String? backgroundImageOriginal;
  @JsonKey(name: 'small_cover_image')
  final String? smallCoverImage;
  @JsonKey(name: 'medium_cover_image')
  final String? mediumCoverImage;
  final String? state;
  final List<Torrent>? torrents;
  @JsonKey(name: 'date_uploaded')
  final String? dateUploaded;
  @JsonKey(name: 'date_uploaded_unix')
  final int? dateUploadedUnix;

  SuggestedMovie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory SuggestedMovie.fromJson(Map<String, dynamic> json) =>
      _$SuggestedMovieFromJson(json);

  Map<String, dynamic> toJson() => _$SuggestedMovieToJson(this);
}
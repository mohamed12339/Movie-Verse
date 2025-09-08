import 'package:json_annotation/json_annotation.dart';

part 'list_movies_response.g.dart';

@JsonSerializable()
class ListMoviesResponse {
  final String? status;
  @JsonKey(name: 'status_message')
  final String? statusMessage;
  final Data? data;
  @JsonKey(name: '@meta')
  final Meta? meta;

  ListMoviesResponse({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  factory ListMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$ListMoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListMoviesResponseToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: 'movie_count')
  final int? movieCount;
  final int? limit;
  @JsonKey(name: 'page_number')
  final int? pageNumber;
  final List<MovieDM>? movies;

  Data({
    this.movieCount,
    this.limit,
    this.pageNumber,
    this.movies,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class MovieDM {
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
  @JsonKey(name: 'large_cover_image')
  final String? largeCoverImage;
  final String? state;
  final List<Torrent>? torrents;
  @JsonKey(name: 'date_uploaded')
  final String? dateUploaded;
  @JsonKey(name: 'date_uploaded_unix')
  final int? dateUploadedUnix;

  MovieDM({
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
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory MovieDM.fromJson(Map<String, dynamic> json) => _$MovieDMFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDMToJson(this);
}

@JsonSerializable()
class Torrent {
  final String? url;
  final String? hash;
  final String? quality;
  final String? type;
  @JsonKey(name: 'is_repack')
  final String? isRepack;
  @JsonKey(name: 'video_codec')
  final String? videoCodec;
  @JsonKey(name: 'bit_depth')
  final String? bitDepth;
  @JsonKey(name: 'audio_channels')
  final String? audioChannels;
  final int? seeds;
  final int? peers;
  final String? size;
  @JsonKey(name: 'size_bytes')
  final int? sizeBytes;
  @JsonKey(name: 'date_uploaded')
  final String? dateUploaded;
  @JsonKey(name: 'date_uploaded_unix')
  final int? dateUploadedUnix;

  Torrent({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) => _$TorrentFromJson(json);

  Map<String, dynamic> toJson() => _$TorrentToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: 'server_time')
  final int? serverTime;
  @JsonKey(name: 'server_timezone')
  final String? serverTimezone;
  @JsonKey(name: 'api_version')
  final int? apiVersion;
  @JsonKey(name: 'execution_time')
  final String? executionTime;

  Meta({
    this.serverTime,
    this.serverTimezone,
    this.apiVersion,
    this.executionTime,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'movie_details_response.g.dart';

@JsonSerializable()
class MovieDetailsResponse {
  final String? status;
  @JsonKey(name: 'status_message')
  final String? statusMessage;
  final MovieData? data;

  MovieDetailsResponse({
    this.status,
    this.statusMessage,
    this.data,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsResponseToJson(this);
}

@JsonSerializable()
class MovieData {
  final Movie? movie;

  MovieData({this.movie});

  factory MovieData.fromJson(Map<String, dynamic> json) =>
      _$MovieDataFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDataToJson(this);
}

@JsonSerializable()
class Movie {
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
  @JsonKey(name: 'like_count')
  final int? likeCount;
  @JsonKey(name: 'description_intro')
  final String? descriptionIntro;
  @JsonKey(name: 'description_full')
  final String? descriptionFull;
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

  @JsonKey(name: 'medium_screenshot_image1')
  final String? mediumScreenshotImage1;
  @JsonKey(name: 'medium_screenshot_image2')
  final String? mediumScreenshotImage2;
  @JsonKey(name: 'medium_screenshot_image3')
  final String? mediumScreenshotImage3;
  @JsonKey(name: 'large_screenshot_image1')
  final String? largeScreenshotImage1;
  @JsonKey(name: 'large_screenshot_image2')
  final String? largeScreenshotImage2;
  @JsonKey(name: 'large_screenshot_image3')
  final String? largeScreenshotImage3;

  final List<Cast>? cast;
  final List<Torrent>? torrents;

  @JsonKey(name: 'date_uploaded')
  final String? dateUploaded;
  @JsonKey(name: 'date_uploaded_unix')
  final int? dateUploadedUnix;

  Movie({
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
    this.likeCount,
    this.descriptionIntro,
    this.descriptionFull,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.mediumScreenshotImage1,
    this.mediumScreenshotImage2,
    this.mediumScreenshotImage3,
    this.largeScreenshotImage1,
    this.largeScreenshotImage2,
    this.largeScreenshotImage3,
    this.cast,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable()
class Cast {
  final String? name;
  @JsonKey(name: 'character_name')
  final String? characterName;
  @JsonKey(name: 'url_small_image')
  final String? urlSmallImage;
  @JsonKey(name: 'imdb_code')
  final String? imdbCode;

  Cast({
    this.name,
    this.characterName,
    this.urlSmallImage,
    this.imdbCode,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
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

  factory Torrent.fromJson(Map<String, dynamic> json) =>
      _$TorrentFromJson(json);

  Map<String, dynamic> toJson() => _$TorrentToJson(this);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsResponse _$MovieDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    MovieDetailsResponse(
      status: json['status'] as String?,
      statusMessage: json['status_message'] as String?,
      data: json['data'] == null
          ? null
          : MovieData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDetailsResponseToJson(
        MovieDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_message': instance.statusMessage,
      'data': instance.data,
    };

MovieData _$MovieDataFromJson(Map<String, dynamic> json) => MovieData(
      movie: json['movie'] == null
          ? null
          : Movie.fromJson(json['movie'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieDataToJson(MovieData instance) => <String, dynamic>{
      'movie': instance.movie,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
      imdbCode: json['imdb_code'] as String?,
      title: json['title'] as String?,
      titleEnglish: json['title_english'] as String?,
      titleLong: json['title_long'] as String?,
      slug: json['slug'] as String?,
      year: (json['year'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      runtime: (json['runtime'] as num?)?.toInt(),
      genres:
          (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
      likeCount: (json['like_count'] as num?)?.toInt(),
      descriptionIntro: json['description_intro'] as String?,
      descriptionFull: json['description_full'] as String?,
      ytTrailerCode: json['yt_trailer_code'] as String?,
      language: json['language'] as String?,
      mpaRating: json['mpa_rating'] as String?,
      backgroundImage: json['background_image'] as String?,
      backgroundImageOriginal: json['background_image_original'] as String?,
      smallCoverImage: json['small_cover_image'] as String?,
      mediumCoverImage: json['medium_cover_image'] as String?,
      largeCoverImage: json['large_cover_image'] as String?,
      mediumScreenshotImage1: json['medium_screenshot_image1'] as String?,
      mediumScreenshotImage2: json['medium_screenshot_image2'] as String?,
      mediumScreenshotImage3: json['medium_screenshot_image3'] as String?,
      largeScreenshotImage1: json['large_screenshot_image1'] as String?,
      largeScreenshotImage2: json['large_screenshot_image2'] as String?,
      largeScreenshotImage3: json['large_screenshot_image3'] as String?,
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
      torrents: (json['torrents'] as List<dynamic>?)
          ?.map((e) => Torrent.fromJson(e as Map<String, dynamic>))
          .toList(),
      dateUploaded: json['date_uploaded'] as String?,
      dateUploadedUnix: (json['date_uploaded_unix'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'imdb_code': instance.imdbCode,
      'title': instance.title,
      'title_english': instance.titleEnglish,
      'title_long': instance.titleLong,
      'slug': instance.slug,
      'year': instance.year,
      'rating': instance.rating,
      'runtime': instance.runtime,
      'genres': instance.genres,
      'like_count': instance.likeCount,
      'description_intro': instance.descriptionIntro,
      'description_full': instance.descriptionFull,
      'yt_trailer_code': instance.ytTrailerCode,
      'language': instance.language,
      'mpa_rating': instance.mpaRating,
      'background_image': instance.backgroundImage,
      'background_image_original': instance.backgroundImageOriginal,
      'small_cover_image': instance.smallCoverImage,
      'medium_cover_image': instance.mediumCoverImage,
      'large_cover_image': instance.largeCoverImage,
      'medium_screenshot_image1': instance.mediumScreenshotImage1,
      'medium_screenshot_image2': instance.mediumScreenshotImage2,
      'medium_screenshot_image3': instance.mediumScreenshotImage3,
      'large_screenshot_image1': instance.largeScreenshotImage1,
      'large_screenshot_image2': instance.largeScreenshotImage2,
      'large_screenshot_image3': instance.largeScreenshotImage3,
      'cast': instance.cast,
      'torrents': instance.torrents,
      'date_uploaded': instance.dateUploaded,
      'date_uploaded_unix': instance.dateUploadedUnix,
    };

Cast _$CastFromJson(Map<String, dynamic> json) => Cast(
      name: json['name'] as String?,
      characterName: json['character_name'] as String?,
      urlSmallImage: json['url_small_image'] as String?,
      imdbCode: json['imdb_code'] as String?,
    );

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
      'name': instance.name,
      'character_name': instance.characterName,
      'url_small_image': instance.urlSmallImage,
      'imdb_code': instance.imdbCode,
    };

Torrent _$TorrentFromJson(Map<String, dynamic> json) => Torrent(
      url: json['url'] as String?,
      hash: json['hash'] as String?,
      quality: json['quality'] as String?,
      type: json['type'] as String?,
      isRepack: json['is_repack'] as String?,
      videoCodec: json['video_codec'] as String?,
      bitDepth: json['bit_depth'] as String?,
      audioChannels: json['audio_channels'] as String?,
      seeds: (json['seeds'] as num?)?.toInt(),
      peers: (json['peers'] as num?)?.toInt(),
      size: json['size'] as String?,
      sizeBytes: (json['size_bytes'] as num?)?.toInt(),
      dateUploaded: json['date_uploaded'] as String?,
      dateUploadedUnix: (json['date_uploaded_unix'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TorrentToJson(Torrent instance) => <String, dynamic>{
      'url': instance.url,
      'hash': instance.hash,
      'quality': instance.quality,
      'type': instance.type,
      'is_repack': instance.isRepack,
      'video_codec': instance.videoCodec,
      'bit_depth': instance.bitDepth,
      'audio_channels': instance.audioChannels,
      'seeds': instance.seeds,
      'peers': instance.peers,
      'size': instance.size,
      'size_bytes': instance.sizeBytes,
      'date_uploaded': instance.dateUploaded,
      'date_uploaded_unix': instance.dateUploadedUnix,
    };

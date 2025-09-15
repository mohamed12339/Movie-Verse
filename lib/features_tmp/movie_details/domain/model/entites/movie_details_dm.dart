

import 'package:hive/hive.dart';

part 'movie_details_dm.g.dart';

@HiveType(typeId: 1)
class MovieDetailsDm {  /// دا الحاجات الي هاستخدمها واخزنها كمان هيا بس والانا عملتوا دا ال adapter بس
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? titleEnglish;

  @HiveField(3)
  final String? titleLong;

  @HiveField(4)
  final int year;

  @HiveField(5)
  final int likeCount;

  @HiveField(6)
  final double rating;

  @HiveField(7)
  final int runtime;

  @HiveField(8)
  final List<String> genres;

  @HiveField(9)
  final String description;

  @HiveField(10)
  final String? ytTrailerCode;

  @HiveField(11)
  final String? language;

  @HiveField(12)
  final String? mpaRating;

  @HiveField(13)
  final String? backgroundImage;

  @HiveField(14)
  final String? largeCoverImage;

  @HiveField(15)
  final List<CastEntity> cast;

  @HiveField(16)
  final List<TorrentEntity> torrents;

  @HiveField(17)
  final List<String> screenshots;

  MovieDetailsDm({
    required this.id,
    required this.title,
    this.titleEnglish,
    this.titleLong,
    required this.year,
    required this.likeCount,
    required this.rating,
    required this.runtime,
    required this.genres,
    required this.description,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.largeCoverImage,
    required this.cast,
    required this.torrents,
    required this.screenshots,
  });
}

@HiveType(typeId: 2)
class CastEntity {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String? characterName;

  @HiveField(2)
  final String? imageUrl;

  CastEntity({
    required this.name,
    this.characterName,
    this.imageUrl,
  });
}

@HiveType(typeId: 3)
class TorrentEntity {
  @HiveField(0)
  final String quality;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String size;

  @HiveField(3)
  final int seeds;

  @HiveField(4)
  final int peers;

  @HiveField(5)
  final String url;

  @HiveField(6)
  final String videoCodec;

  @HiveField(7)
  final String audioChannels;

  @HiveField(8)
  final String dateUploaded;

  TorrentEntity({
    required this.quality,
    required this.type,
    required this.size,
    required this.seeds,
    required this.peers,
    required this.url,
    required this.videoCodec,
    required this.audioChannels,
    required this.dateUploaded,
  });
}
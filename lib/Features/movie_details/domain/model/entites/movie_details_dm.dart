class MovieDetailsDm { ///هنا الحاجات الي هاستخدمها بس
  final int id;
  final String title;
  final String? titleEnglish;
  final String? titleLong;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String description;
  final String? ytTrailerCode;
  final String? language;
  final String? mpaRating;
  final String? backgroundImage;
  final String? largeCoverImage;
  final List<CastEntity> cast;
  final List<TorrentEntity> torrents;

  MovieDetailsDm({
    required this.id,
    required this.title,
    this.titleEnglish,
    this.titleLong,
    required this.year,
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
  });
}

class CastEntity {
  final String name;
  final String? characterName;
  final String? imageUrl;

  CastEntity({
    required this.name,
    this.characterName,
    this.imageUrl,
  });
}

class TorrentEntity {
  final String quality;
  final String type;
  final String size;
  final int seeds;
  final int peers;

  TorrentEntity({
    required this.quality,
    required this.type,
    required this.size,
    required this.seeds,
    required this.peers,
  });
}
class SuggestedMovieDM { ///هنا الحاجات الي هاستخدمها بس
  final int id;
  final String title;
  final String? titleEnglish;
  final String? titleLong;
  final int year;
  final double rating;
  final int runtime;
  final List<String> genres;
  final String? summary;
  final String? ytTrailerCode;
  final String? backgroundImage;
  final String? coverImage;

  SuggestedMovieDM({
    required this.id,
    required this.title,
    this.titleEnglish,
    this.titleLong,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.genres,
    this.summary,
    this.ytTrailerCode,
    this.backgroundImage,
    this.coverImage,
  });
}
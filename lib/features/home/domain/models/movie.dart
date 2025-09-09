class Movie {
  int id = 0;
  num rating = 0;
  String largeCoverImage = "";

  Movie({
    required this.id,
    required this.rating,
    required this.largeCoverImage,
  });

  static List<Movie> dummyMovies = [
    Movie(id: 1, rating: 8.5, largeCoverImage: "assets/images/movie1.jpg"),
    Movie(id: 2, rating: 7.3, largeCoverImage: "assets/images/movie2.jpg"),
    Movie(id: 3, rating: 9.0, largeCoverImage: "assets/images/movie3.jpg"),
  ];

  factory Movie.fromJson(dynamic json) {
    return Movie(
      id: json['id'] ?? 0,
      rating: json['rating'] ?? 0,
      largeCoverImage: json['large_cover_image'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'large_cover_image': largeCoverImage,
    };
  }
}

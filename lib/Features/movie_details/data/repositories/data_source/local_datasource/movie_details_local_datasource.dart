import '../../../../domain/model/entites/movie_details_dm.dart';

abstract class MovieDetailsLocalDatasource { /// دا الداتا الاوفلاين وكمان دا هوا ال abstract الي مش هابعت فية الحاجة ال impl هوا الي هايبعت الحاجة
  Future<void> toggleWatchlist(MovieDetailsDm movie); /// عشان اخزنهم بقا
  Future<bool> checkWatchlist(int movieId);
  Future<List<MovieDetailsDm>> getWatchlist();

}
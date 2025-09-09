import 'package:movies/features/home/domain/models/movie.dart';

abstract class VisitedMoviesHistoryRepository {
  Future<void> addMovieToHistory(Movie movie);
  Future<List<Movie>> getVisitedMoviesHistory();
}
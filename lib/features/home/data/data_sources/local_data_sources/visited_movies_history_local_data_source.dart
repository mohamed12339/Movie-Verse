import 'package:movies/features/home/domain/models/movie.dart';

abstract class VisitedMoviesHistoryLocalDataSource {
  Future<void> addMovieToHistory(Movie movie);
  Future<List<Movie>> getVisitedMoviesHistory();
}

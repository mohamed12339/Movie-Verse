

import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';

abstract class VisitedMoviesHistoryLocalDataSource {
  Future<void> addMovieToHistory(Movie movie);
  Future<List<Movie>> getVisitedMoviesHistory();
}

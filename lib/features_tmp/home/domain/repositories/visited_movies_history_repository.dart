

import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';

abstract class VisitedMoviesHistoryRepository {
  Future<ApiResult<void>> addMovieToHistory(Movie movie);
  Future<ApiResult<List<Movie>>> getVisitedMoviesHistory();
}
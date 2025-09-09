import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/domain/models/movie.dart';

abstract class VisitedMoviesHistoryRepository {
  Future<ApiResult<void>> addMovieToHistory(Movie movie);
  Future<ApiResult<List<Movie>>> getVisitedMoviesHistory();
}
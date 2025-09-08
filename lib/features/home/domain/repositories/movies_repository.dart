import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/domain/models/movie.dart';

abstract class MoviesRepository{
  Future<ApiResult<List<Movie>>> getTopRatedMovies();
  Future<ApiResult<Set<String>>> getAllGenres();
  Future<ApiResult<List<Movie>>> getMoviesByGenre(String genre);
  Future<ApiResult<List<Movie>>> getMoviesByQuery(String query);
}
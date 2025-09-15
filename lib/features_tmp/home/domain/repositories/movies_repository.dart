

import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';

abstract class MoviesRepository{
  Future<ApiResult<List<Movie>>> getTopRatedMovies();
  Future<ApiResult<Set<String>>> getAllGenres();
  Future<ApiResult<List<Movie>>> getMoviesByGenre(String genre);
  Future<ApiResult<List<Movie>>> getMoviesByQuery(String query);
}
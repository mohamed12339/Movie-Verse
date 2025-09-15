

import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/home/data/models/list_movies_response.dart';

abstract class MoviesRemoteDataSource {
  Future<ApiResult<ListMoviesResponse>> getTopRatedMovies();
  Future<ApiResult<Set<String>>> getAllGenres();
  Future<ApiResult<ListMoviesResponse>> getMoviesByGenre(String genre);
  Future<ApiResult<ListMoviesResponse>> getMoviesByQuery(String query);
}
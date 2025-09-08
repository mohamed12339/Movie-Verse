import 'package:injectable/injectable.dart';
import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/data/models/list_movies_response.dart';

abstract class MoviesRemoteDataSource {
  Future<ApiResult<ListMoviesResponse>> getTopRatedMovies();
  Future<ApiResult<Set<String>>> getAllGenres();
  Future<ApiResult<ListMoviesResponse>> getMoviesByGenre(String genre);
  Future<ApiResult<ListMoviesResponse>> getMoviesByQuery(String query);
}
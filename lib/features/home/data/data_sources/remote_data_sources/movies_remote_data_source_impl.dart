import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/data/data_sources/remote_data_sources/movies_remote_data_source.dart';
import 'package:movies/features/home/data/models/list_movies_response.dart';
import 'package:movies/features/home/network/api/movies_api_services.dart';

@Injectable(as: MoviesRemoteDataSource)
class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final MoviesApiServices moviesApiServices;

  MoviesRemoteDataSourceImpl(this.moviesApiServices);

  @override
  Future<ApiResult<ListMoviesResponse>> getTopRatedMovies() async {
    try {
      final response = await moviesApiServices.getMoviesList(
        sortBy: "rating",
        orderBy: "desc",
      );
      return SuccessApiResult(response);
    } catch (e) {
      return ErrorApiResult(AppErrors(e.toString()));
    }
  }

  @override
  Future<ApiResult<Set<String>>> getAllGenres() async {
    try {
      final response = await moviesApiServices.getMoviesList();
      Set<String> genres = {};
      for (var movie in response.data?.movies ?? []) {
        for (var genre in movie.genres) {
          genres.add(genre);
        }
      }
      return SuccessApiResult(genres);
    } catch (e) {
      return ErrorApiResult(AppErrors(e.toString()));
    }
  }

  @override
  Future<ApiResult<ListMoviesResponse>> getMoviesByGenre(String genre) async {
    try {
      final response = await moviesApiServices.getMoviesList(genre: genre);
      return SuccessApiResult(response);
    } catch (e) {
      return ErrorApiResult(AppErrors(e.toString()));
    }
  }

  @override
  Future<ApiResult<ListMoviesResponse>> getMoviesByQuery(String query) async {
    try {
      final response = await moviesApiServices.getMoviesList(queryTerm: query);
      return SuccessApiResult(response);
    } catch (e) {
      return ErrorApiResult(AppErrors(e.toString()));
    }
  }
}

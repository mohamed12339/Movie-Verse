import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/features/home/data/models/list_movies_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

  part 'movies_api_services.g.dart';

  @injectable
  @RestApi(baseUrl: "https://yts.mx/api/v2/")
  abstract class MoviesApiServices {
    @factoryMethod
    factory MoviesApiServices(Dio dio) = _MoviesApiServices;

  @GET("/list_movies.json")
  Future<ListMoviesResponse> getMoviesList({
    @Query("sort_by") String? sortBy,
    @Query("order_by") String? orderBy,
    @Query("query_term") String? queryTerm,
    @Query("genre") String? genre,
    @Query("page") int? page,
    @Query("limit") int? limit,
  });
}
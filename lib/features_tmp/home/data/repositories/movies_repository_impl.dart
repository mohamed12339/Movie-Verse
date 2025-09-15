import 'package:injectable/injectable.dart';
import 'package:project_movie_app/core/api_result/api_result.dart';
import 'package:project_movie_app/features_tmp/home/data/data_sources/remote_data_sources/movies_remote_data_source.dart';
import 'package:project_movie_app/features_tmp/home/data/mappers/movie_mapper.dart';
import 'package:project_movie_app/features_tmp/home/domain/models/movie.dart';
import 'package:project_movie_app/features_tmp/home/domain/repositories/movies_repository.dart';


@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource homeRemoteDataSource;
  final MovieMapper movieMapper;

  MoviesRepositoryImpl(this.homeRemoteDataSource, this.movieMapper);

  @override
  Future<ApiResult<Set<String>>> getAllGenres() {
    return homeRemoteDataSource.getAllGenres();
  }

  @override
  Future<ApiResult<List<Movie>>> getMoviesByGenre(String genre) async {
    //try {
      final result = await homeRemoteDataSource.getMoviesByGenre(genre);
      if (result.hasData) {
        return SuccessApiResult(
          movieMapper.fromDataModelList(result.myData.data?.movies?? []),
        );
      } else {
        return ErrorApiResult(result.myError);
      }
    // } on Exception catch (e) {
    //   return ErrorApiResult(AppErrors(e.toString()));
    // }
  }

  @override
  Future<ApiResult<List<Movie>>> getMoviesByQuery(String query) async {
    try {
      final result = await homeRemoteDataSource.getMoviesByQuery(query);
      if (result.hasData) {
        return SuccessApiResult(
          movieMapper.fromDataModelList(result.myData.data?.movies ?? []),
        );
      } else {
        return ErrorApiResult(result.myError);
      }
    } on Exception catch (e) {
      return ErrorApiResult(AppErrors(e.toString()));
    }
  }

  @override
  Future<ApiResult<List<Movie>>> getTopRatedMovies() async {
    try {
      final result = await homeRemoteDataSource.getTopRatedMovies();
      if (result.hasData) {
        return SuccessApiResult(
          movieMapper.fromDataModelList(result.myData.data?.movies ?? []),
        );
      } else {
        return ErrorApiResult(result.myError);
      }
    } on Exception catch (e) {
      return ErrorApiResult(AppErrors(e.toString()));
    }
  }
}

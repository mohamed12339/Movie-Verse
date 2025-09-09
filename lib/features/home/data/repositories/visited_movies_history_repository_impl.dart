import 'package:injectable/injectable.dart';
import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/data/data_sources/local_data_sources/visited_movies_history_local_data_source.dart';
import 'package:movies/features/home/data/mappers/movie_mapper.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/domain/repositories/visited_movies_history_repository.dart';

@Injectable(as: VisitedMoviesHistoryRepository)
class VisitedMoviesHistoryRepositoryImpl
    implements VisitedMoviesHistoryRepository {
  final VisitedMoviesHistoryLocalDataSource visitedMoviesHistoryLocalDataSource;
  final MovieMapper movieMapper;

  VisitedMoviesHistoryRepositoryImpl(
    this.movieMapper,
    this.visitedMoviesHistoryLocalDataSource,
  );

  @override
  Future<ApiResult<void>> addMovieToHistory(Movie movie) async {
    try {
      await visitedMoviesHistoryLocalDataSource.addMovieToHistory(movie);
      return SuccessApiResult(null);
    } on Exception catch (e) {
      return ErrorApiResult(AppErrors(e.toString()));
    }
  }

  @override
  Future<ApiResult<List<Movie>>> getVisitedMoviesHistory() async {
    try {
      var movies =
          await visitedMoviesHistoryLocalDataSource.getVisitedMoviesHistory();
      return SuccessApiResult(movies);
    } on Exception catch (e) {
      return ErrorApiResult(AppErrors(e.toString()));
    }
  }
}

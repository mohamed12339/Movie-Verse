import 'package:injectable/injectable.dart';
import 'package:movies/core/api_result/api_result.dart';
import 'package:movies/features/home/data/data_sources/local_data_sources/visited_movies_history_local_data_source.dart';
import 'package:movies/features/home/data/mappers/movie_mapper.dart';
import 'package:movies/features/home/domain/models/movie.dart';
import 'package:movies/features/home/domain/repositories/visited_movies_history_repository.dart';

@Injectable(as: VisitedMoviesHistoryRepository)
class VisitedMoviesHistoryRepositoryImpl implements VisitedMoviesHistoryRepository {
  final VisitedMoviesHistoryLocalDataSource visitedMoviesHistoryLocalDataSource;
  final MovieMapper movieMapper;

  VisitedMoviesHistoryRepositoryImpl(this.movieMapper,this.visitedMoviesHistoryLocalDataSource);

  @override
  Future<void> addMovieToHistory(Movie movie) async {
    await visitedMoviesHistoryLocalDataSource.addMovieToHistory(movie);
  }

  @override
  Future<List<Movie>> getVisitedMoviesHistory() async {
    return await visitedMoviesHistoryLocalDataSource.getVisitedMoviesHistory();
  }
}